use std::fmt::format;

use indexmap::IndexMap;

use crate::Ir::expr::{self, BinOp, EnumExprField, Expr, ExprType, Lookup, UnaryOp};
use crate::Ir::r#gen;
use crate::Ir::shared::TypeContext;
use crate::Ir::stmt::{Declaration, EnumVariant, StructField};
use crate::shared::{arg_pos, coerce_numeric, is_numeric};

use super::*;

impl Lookup for Gen {
    fn look_var(&self, name: &String) -> Option<Type> {
        if self.structs.get(name).is_some() {
            return Some(Type::Struct(name.clone()));
        }
        if self.enums.get(name).is_some() {
            // possible bug
            return Some(Type::Enum(name.clone(), None));
        } else {
            let var = self.lookup_var(name);
            return Some(var.var_type.clone());
        }
    }
    fn look_unary(&self, op: &UnaryOp, expr: &Box<Expr>) -> Type {
        match op {
            UnaryOp::BitNot => todo!(),
            UnaryOp::Neg => expr.get_type(self),
            UnaryOp::Not => Type::Primitive(TokenType::CharType), // boolean
            UnaryOp::GetAddr => Type::Pointer(Box::new(expr.get_type(self))),
        }
    }
    fn look_binary(&self, op: &BinOp, left: &Box<Expr>, right: &Box<Expr>) -> Type {
        let lty = left.get_type(self);
        let rty = right.get_type(self);
        coerce_numeric(&lty, &rty)
    }
    fn look_struct_init(&self, struct_name: &String) -> Type {
        if let Some(_struct_data) = self.structs.get(struct_name) {
            Type::Struct(struct_name.clone())
        } else {
            self::panic!("Struct {} not found in get_type", struct_name);
        }
    }
    fn look_deref(&self, ptr_expr: &Box<Expr>) -> Type {
        match ptr_expr.get_type(self) {
            Type::Pointer(inner) => *inner,
            _ => self::panic!(
                "Cannot dereference a non-pointer: {:?}",
                ptr_expr.get_type(self)
            ),
        }
    }
    fn look_addres_of(&self, var_expr: &Box<Expr>) -> Type {
        let ty = var_expr.get_type(self);
        Type::Pointer(Box::new(ty))
    }
    fn look_index(&self, base: &Box<Expr>, index: &Box<Expr>) -> Type {
        let base_ty = base.get_type(self);
        let idx_ty = index.get_type(self);
        if !is_numeric(&idx_ty) {
            self::panic!("Array index must be integer");
        }
        match base_ty {
            Type::Array(elem_ty, _) => *elem_ty,
            Type::Pointer(elem_ty) => *elem_ty,
            _ => base_ty,
        }
    }
    fn look_struct_member(&self, base: &Box<Expr>, name: &String) -> Type {
        let base_ty = base.get_type(self);
        let base_ty = self.resolve_generic_inst(&base_ty);

        let struct_name = match &base_ty {
            Type::Struct(n) => n.clone(),
            // todo: fix this
            Type::Pointer(inner) => match inner.as_ref() {
                Type::Struct(n) => n.clone(),
                _ => self::panic!("pointer to non-struct: {:?}", inner),
            },
            _ => self::panic!("member access on non-struct: {:?}", base_ty),
        };
        let struct_data = self.structs.get(&struct_name).unwrap();
        let field = struct_data.elements.get(name).unwrap();
        field.ty.clone()
    }
    fn look_call(&self, name: &String, args: &Vec<Expr>, generics: &Vec<Type>) -> Type {
        let func_name = name.clone();

        let vec_func_data: Vec<FuncData> = if generics.len() > 0 {
            let new_name = self.transform_generic_name(&func_name, generics);
            if let Some(existing) = self.functions.get(&new_name) {
                existing.clone()
            } else {
                let func_data = self.functions.get(&func_name).unwrap()[0].clone();
                let new_args: Vec<Declaration> =
                    self.convert_generic_args(&func_data.args, generics, &self.generics);
                let ret_type: Type = match &func_data.return_type {
                    Type::GenericType(name) => {
                        let pos = func_data
                            .generic
                            .iter()
                            .position(|g| g == name)
                            .expect(&format!("non existing generic var: {}", name));
                        generics[pos].clone()
                    }
                    _ => func_data.return_type.clone(),
                };
                vec![FuncData {
                    args: new_args,
                    generic: Vec::new(),
                    return_type: ret_type,
                }]
            }
        } else {
            self.functions.get(&func_name).unwrap().clone()
        };
        let func_data = vec_func_data
            .iter()
            .find(|func| {
                if func.args.len() != args.len() {
                    return false;
                }
                args.iter().enumerate().all(|(index, expr)| {
                    let expr_ty = self.resolve_generic_inst(&expr.get_type(self));
                    let arg_ty = self.resolve_generic_inst(&func.args[index].ty);
                    check_types(&expr_ty, &arg_ty)
                })
            })
            .expect(&format!(
                "no matching overload for function '{}'",
                func_name
            ));

        func_data.return_type.clone()
    }
    fn look_array_init(&self, elements: &Vec<Expr>) -> Type {
        if elements.len() > 0 {
            return elements[0].get_type(self);
        } else {
            Type::Unknown
        }
    }

    fn look_get_enum(&self, base: &String, variant: &String) -> Type {
        Type::Enum(base.clone(), Some(variant.clone()))
    }
}

impl Gen {
    fn gen_expr_binop(
        &mut self,
        op: &BinOp,
        left_reg: &str,
        right_reg: &str,
        expected_type: &Type,
    ) {
        match op {
            BinOp::BitAnd => {
                self.emit_func_data(format!("    and {}, {}", left_reg, right_reg));
            }
            BinOp::BitOr => {
                self.emit_func_data(format!("    or {}, {}", left_reg, right_reg));
            }
            BinOp::BitXor => {
                self.emit_func_data(format!("    xor {}, {}", left_reg, right_reg));
            }
            BinOp::ShiftLeft => {
                // shift amount must be in cl
                self.emit(format!("    mov rcx, {}", right_reg));
                self.emit(format!("    shl {}, cl", left_reg));
            }
            BinOp::ShiftRight => {
                self.emit(format!("    mov rcx, {}", right_reg));
                self.emit(format!("    shr {}, cl", left_reg));
            }
            BinOp::Add => {
                self.emit_func_data(format!("    add {}, {}", left_reg, right_reg));
            }
            BinOp::Sub => {
                self.emit_func_data(format!("    sub {}, {}", left_reg, right_reg));
            }
            BinOp::Mul => {
                self.emit_func_data(format!("    imul {}, {}", left_reg, right_reg));
            }
            BinOp::Div => {
                if self.type_size(expected_type) == 8 {
                    self.emit_func_data("    cqo".to_string());
                } else {
                    self.emit_func_data("    cdq".to_string());
                }
                self.emit_func_data(format!("    idiv {}", right_reg));
                // result already in rax
            }
            BinOp::Mod => {
                if self.type_size(expected_type) == 8 {
                    self.emit_func_data("    cqo".to_string());
                } else {
                    self.emit_func_data("    cdq".to_string());
                }
                self.emit_func_data(format!("    idiv {}", right_reg));
                // remainder in rdx, move to rax
                self.emit_func_data(format!(
                    "    mov {}, {}",
                    left_reg,
                    self.reg_for_size("rdx", expected_type).unwrap()
                ));
            }
            BinOp::Eq | BinOp::Neq | BinOp::Lt | BinOp::Lte | BinOp::Gt | BinOp::Gte => {
                self.emit_func_data(format!("    cmp {}, {}", left_reg, right_reg));
                let set_instr = match op {
                    BinOp::Eq => "sete",
                    BinOp::Neq => "setne",
                    BinOp::Lt => "setl",
                    BinOp::Lte => "setle",
                    BinOp::Gt => "setg",
                    BinOp::Gte => "setge",
                    _ => unreachable!(),
                };
                self.emit_func_data(format!("    {} al", set_instr));
                self.emit_func_data(format!("    movzx {}, al", left_reg));
            }
            BinOp::And => {
                unreachable!()
            }
            BinOp::Or => {
                let left_byte = self
                    .reg_for_size(left_reg, &Type::Primitive(TokenType::CharType))
                    .unwrap();
                let right_byte = self
                    .reg_for_size(right_reg, &Type::Primitive(TokenType::CharType))
                    .unwrap();
                self.emit_func_data(format!("    cmp {}, 0", left_reg));
                self.emit_func_data(format!("    setne {}", left_byte));
                self.emit_func_data(format!("    cmp {}, 0", right_reg));
                self.emit_func_data(format!("    setne {}", right_byte));
                self.emit_func_data(format!("    or {}, {}", left_byte, right_byte));
                self.emit_func_data(format!("    movzx {}, {}", left_reg, left_byte));
            }
        }
    }

    fn push_result(&mut self) {
        self.emit_func_data("    push rax".to_string());
    }
    fn pop_into(&mut self, reg: &str) {
        self.emit_func_data(format!("    pop {}", reg));
    }

    fn gen_expr_num(&mut self, num: &i64, expected_type: &Type) -> String {
        let expected_type = match expected_type {
            Type::GenericType(name) => self.generics.get(name).unwrap(),
            _ => expected_type,
        };
        let sized_rax = self.reg_for_size("rax", expected_type).unwrap();
        self.emit_func_data(format!("    mov {}, {}", sized_rax, num));
        "rax".to_string()
    }

    fn var_return(&mut self, var_data: &VarData, expected_type: &Type) {
        match &var_data.var_type {
            Type::Primitive(_) => {
                let actual_size = self.type_size(&var_data.var_type);
                let expected_size = self.type_size(expected_type);
                if expected_size > actual_size {
                    let src_word = self.get_word(&var_data.var_type);
                    self.emit_func_data(format!(
                        "    movsx rax, {} [rbp - {}]",
                        src_word, var_data.stack_pos
                    ));
                } else {
                    let sized_rax = self.reg_for_size("rax", &var_data.var_type).unwrap();
                    self.emit_func_data(format!(
                        "    mov {}, {} [rbp - {}]",
                        sized_rax,
                        self.get_word(&var_data.var_type),
                        var_data.stack_pos
                    ));
                }
            }
            Type::Pointer(_) => {
                self.emit_func_data(format!("    mov rax, [rbp - {}]", var_data.stack_pos));
            }
            Type::Enum(ty, _) => {
                self.emit_func_data(format!("    mov rax, [rbp - {}]", var_data.stack_pos));
            }
            _ => {
                // struct/array — load address
                self.emit_func_data(format!("    lea rax, [rbp - {}]", var_data.stack_pos));
            }
        }
    }

    fn gen_expr_var(&mut self, var_name: &String, expected_type: &Type) -> String {
        let var_data = self.lookup_var(var_name).clone();
        if var_data.global_flag {
            match var_data.var_type {
                Type::Primitive(_) | Type::Pointer(_) => {
                    let sized_rax = self.reg_for_size("rax", &var_data.var_type).unwrap();
                    self.emit_func_data(format!("    mov {}, [rel {}]", sized_rax, var_name));
                }
                _ => {
                    // struct/array — load address
                    self.emit_func_data(format!("    lea rax, [rel {}]", var_name));
                }
            }
            return "rax".to_string();
        }

        self.var_return(&var_data, expected_type);

        "rax".to_string()
    }

    // TODO: make this better
    fn var_return_addr(&mut self, var_data: &VarData, expected_type: &Type) {
        match &var_data.var_type {
            Type::Primitive(_) => {
                let actual_size = self.type_size(&var_data.var_type);
                let expected_size = self.type_size(expected_type);
                if expected_size > actual_size {
                    let src_word = self.get_word(&var_data.var_type);
                    self.emit_func_data(format!(
                        "    movsx rax, {} [rbp - {}]",
                        src_word, var_data.stack_pos
                    ));
                } else {
                    let sized_rax = self.reg_for_size("rax", &var_data.var_type).unwrap();
                    self.emit_func_data(format!(
                        "    mov {}, {} [rbp - {}]",
                        sized_rax,
                        self.get_word(&var_data.var_type),
                        var_data.stack_pos
                    ));
                }
            }
            Type::Pointer(_) => {
                self.emit_func_data(format!("    mov rax, [rbp - {}]", var_data.stack_pos));
            }
            Type::Enum(ty, _) => {
                self.emit_func_data(format!("    lea rax, [rbp - {}]", var_data.stack_pos));
            }
            _ => {
                // struct/array — load address
                self.emit_func_data(format!("    lea rax, [rbp - {}]", var_data.stack_pos));
            }
        }
    }

    // TODO: make this better
    pub fn gen_expr_var_addr(&mut self, var_name: &String, expected_type: &Type) -> String {
        let var_data = self.lookup_var(var_name).clone();
        if var_data.global_flag {
            match var_data.var_type {
                Type::Primitive(_) | Type::Pointer(_) => {
                    let sized_rax = self.reg_for_size("rax", &var_data.var_type).unwrap();
                    self.emit_func_data(format!("    mov {}, [rel {}]", sized_rax, var_name));
                }
                _ => {
                    // struct/array — load address
                    self.emit_func_data(format!("    lea rax, [rel {}]", var_name));
                }
            }
            return "rax".to_string();
        }
        self.var_return_addr(&var_data, expected_type);

        "rax".to_string()
    }

    fn gen_expr_binary(
        &mut self,
        data: (&BinOp, &Box<Expr>, &Box<Expr>),
        expected_type: &Type,
    ) -> String {
        let (op, left, right) = data;
        let left_reg = self.reg_for_size("rax", &expected_type).unwrap();
        let right_reg = self.reg_for_size("rbx", &expected_type).unwrap();

        // the and exception
        if *op == BinOp::And {
            let id = self.get_id();
            self.emit_func_data(format!("and_{id}:"));
            self.eval_expr(left, expected_type);
            self.emit_func_data(format!("    cmp {}, 0", left_reg));
            self.emit_func_data(format!("    je and_end_{}", id));
            self.eval_expr(right, expected_type);
            self.emit_func_data(format!("    cmp {}, 0", right_reg));
            self.emit_func_data(format!("and_end_{id}:"));

            return left_reg;
        }

        self.eval_expr(right, expected_type);
        self.push_result();
        self.eval_expr(left, expected_type);
        self.pop_into("rbx");

        self.gen_expr_binop(op, &left_reg, &right_reg, expected_type);

        left_reg
    }

    fn gen_expr_unary(&mut self, op: &UnaryOp, expr: &Box<Expr>, expected_type: &Type) -> String {
        match op {
            UnaryOp::Neg => {
                self.eval_expr(expr, expected_type);
                let sized = self.reg_for_size("rax", expected_type).unwrap();
                self.emit_func_data(format!("    neg {}", sized));
            }
            UnaryOp::Not => {
                self.eval_expr(expr, expected_type);
                let sized = self.reg_for_size("rax", expected_type).unwrap();
                self.emit_func_data(format!("    cmp {}, 0", sized));
                self.emit_func_data("    sete al".to_string());
                self.emit_func_data(format!("    movzx {}, al", sized));
            }
            UnaryOp::GetAddr => {
                self.gen_expr_addres_of(expr);
            }
            UnaryOp::BitNot => {
                todo!();
            }
        }
        "rax".to_string()
    }

    pub fn transform_generic_name(&self, name: &String, generics: &Vec<Type>) -> String {
        let mut new_generics = Vec::new();
        for i in generics {
            match i {
                Type::GenericType(name) => {}
                _ => new_generics.push(i),
            }
        }
        let mangled = format!(
            "{}__{}",
            name,
            generics
                .iter()
                .map(|t| type_name(t))
                .collect::<Vec<_>>()
                .join("_")
        );
        mangled
    }

    fn convert_generic_arg(
        &self,
        arg: &Declaration,
        arg_ty: &Type,
        generics: &Vec<Type>,
        index: usize,
        generic_map: &HashMap<String, Type>,
    ) -> Declaration {
        match arg_ty {
            Type::GenericInst(name, inner_types) => {
                let resolved_inner: Vec<Type> = inner_types
                    .iter()
                    .map(|t| match t {
                        Type::GenericType(g) => {
                            generic_map.get(g).cloned().unwrap_or_else(|| t.clone())
                        }
                        _ => self.resolve_generic_inst(t),
                    })
                    .collect();
                let normal_name = self.transform_generic_name(name, &resolved_inner);
                let ty = if self.structs.contains_key(&normal_name) {
                    Type::Struct(normal_name)
                } else if self.enums.contains_key(&normal_name) {
                    Type::Enum(normal_name, None)
                } else {
                    self::panic!("GenericInst not monomorphized: {}", normal_name)
                };
                Declaration {
                    name: arg.name.clone(),
                    ty,
                    initializer: arg.initializer.clone(),
                }
            }
            Type::GenericType(name) => {
                let ty = generic_map.get(name).unwrap();
                Declaration {
                    name: arg.name.clone(),
                    ty: ty.clone(),
                    initializer: arg.initializer.clone(),
                }
            }
            Type::Pointer(ty) => {
                let mut decl = self.convert_generic_arg(arg, ty, generics, index, generic_map);
                decl.ty = Type::Pointer(Box::new(decl.ty));
                decl
            }
            Type::Array(ty, size) => {
                let mut decl = self.convert_generic_arg(arg, ty, generics, index, generic_map);
                decl.ty = Type::Array(Box::new(decl.ty), *size);
                decl
            }
            _ => arg.clone(),
        }
    }

    fn convert_generic_args(
        &self,
        args: &Vec<Declaration>,
        generics: &Vec<Type>,
        generic_map: &HashMap<String, Type>,
    ) -> Vec<Declaration> {
        args.iter()
            .enumerate()
            .map(|(index, arg)| {
                self.convert_generic_arg(arg, &arg.ty, generics, index, generic_map)
            })
            .collect()
    }

    fn gen_call(
        &mut self,
        name: &String,
        args: &Vec<Expr>,
        func_data: &FuncData,
        overload_pos: usize,
        generics: &Vec<Type>,
    ) -> String {
        let args = args.clone();
        let mut name = name.clone();

        let mut is_rvo = false; // return value optimization

        let stack_pos_save = self.stack_pos;
        self.stack_pos = 0;
        for (index, generic) in func_data.generic.iter().enumerate() {
            self.generics
                .insert(generic.clone(), generics[index].clone());
        }

        match &self.ensure_monomorphized(&func_data.return_type) {
            Type::Struct(name) => {
                let struct_data = self.structs.get(name).unwrap();
                let pos = self.alloc(struct_data.byte_size);

                self.emit_func_data(format!("    lea rdi, [rbp - {}]", pos));
                self.emit_func_data(format!("    push rdi"));
                is_rvo = true;
            }
            Type::Enum(name, None) => {
                let enum_data = self.enums.get(name).unwrap();
                let pos = self.alloc(enum_data.size);

                self.emit_func_data(format!("    lea rdi, [rbp - {}]", pos));
                self.emit_func_data(format!("    push rdi"));
                is_rvo = true;
            }
            _ => {}
        }

        let new_args = self.convert_generic_args(&func_data.args, generics, &self.generics);
        for (index, arg) in args.iter().enumerate() {
            let arg_type = func_data.args[index].ty.clone();
            self.eval_expr(arg, &arg_type);
            self.emit_func_data("    push rax".to_string());
        }

        if func_data.generic.len() > 0 {
            let generic_data = self.generic_func.get(&name).unwrap().clone();
            name = self.transform_generic_name(&name, generics);
            if self.functions.get(&name).is_none() {
                let res_func_data = FuncData {
                    args: new_args.clone(),
                    generic: Vec::new(),
                    return_type: func_data.return_type.clone(),
                };
                self.functions.insert(name.clone(), vec![res_func_data]);
                match generic_data.ty {
                    StmtType::GenericInitFunc {
                        generic_types,
                        args,
                        ret_type,
                        data,
                        ..
                    } => {
                        let mut generic_data: HashMap<String, Type> = HashMap::new();
                        for i in 0..generic_data.len() {
                            let generic_var = generic_types[i].clone();
                            let generic_ty = generics[i].clone();
                            generic_data.insert(generic_var, generic_ty);
                        }

                        self.gen_func((&name, &new_args, &ret_type, &data, &generic_data));
                    }
                    _ => self::panic!("error"),
                };
            }
        }
        // pop into arg registers in reverse order
        for (index, _) in args.iter().enumerate().rev() {
            let mut arg_type = new_args[index].ty.clone();
            match &arg_type {
                Type::GenericInst(name, grg) => {
                    let mangled = self.transform_generic_name(name, generics);
                    if self.structs.get(&mangled).is_some() {
                        arg_type = Type::Struct(mangled);
                    } else if self.enums.get(&mangled).is_some() {
                        arg_type = Type::Enum(mangled, None);
                    }
                }
                _ => {}
            }
            let index = if is_rvo { index + 1 } else { index };
            let arg_reg = arg_pos(index, &arg_type);
            self.emit_func_data(format!("    pop {}", to_base_reg(&arg_reg)));
            // then size it down if needed
            self.reg_for_size(&to_base_reg(&arg_reg), &arg_type)
                .unwrap();
        }
        if is_rvo {
            self.emit_func_data(format!("    pop rdi"));
        }
        if self.functions.get(&name).unwrap().len() > 1 {
            self.emit_func_data(format!("    call {}___{}", name, overload_pos));
        } else {
            self.emit_func_data(format!("    call {}", name));
        }
        self.stack_pos = stack_pos_save;
        return "rax".to_string();
    }

    fn generic_to_ty(&self, ty: &Type, type_map: &HashMap<String, Type>) -> Type {
        match ty {
            Type::GenericType(name) => {
                return type_map.get(name).cloned().unwrap();
            }
            Type::Array(arr_ty, size) => {
                let res = self.generic_to_ty(arr_ty, type_map);
                return res;
            }
            Type::Pointer(ptr_ty) => {
                let res = self.generic_to_ty(ptr_ty, type_map);
                return res;
            }
            _ => return ty.clone(),
        }
    }

    fn resolve_generic(
        &self,
        expr_ty: &Type,
        field_ty: &Type,
        type_map: &mut HashMap<String, Type>,
    ) {
        match field_ty {
            Type::GenericType(param_name) => {
                type_map.insert(param_name.clone(), expr_ty.clone());
            }
            Type::Array(ty, size) => {
                self.resolve_generic(expr_ty, ty, type_map);
            }
            Type::Pointer(ty) => {
                self.resolve_generic(expr_ty, ty, type_map);
            }
            _ => {}
        }
    }

    fn gen_generic_struct(&mut self, fields: &Vec<(String, Expr)>, struct_name: &String) -> String {
        let struct_data = self.structs.get(struct_name).unwrap().clone();

        let mut type_map: HashMap<String, Type> = HashMap::new();
        for (index, (_, field)) in struct_data.elements.iter().enumerate() {
            let expr_ty = fields[index].1.get_type(self);
            self.resolve_generic(&expr_ty, &field.ty, &mut type_map);
        }

        let mut new_elements = IndexMap::new();
        let mut offset = 0;
        for (field_name, field_data) in struct_data.elements.iter() {
            let ty = self.generic_to_ty(&field_data.ty, &type_map);
            let new_field = StructField {
                ty: ty.clone(),
                offset: offset,
                name: field_data.name.clone(),
            };
            offset += self.type_size(&ty);
            new_elements.insert(field_name.clone(), new_field);
        }

        let type_args: Vec<String> = struct_data
            .generic_type
            .iter()
            .map(|param| type_map.get(param).map(type_name).unwrap_or(param.clone()))
            .collect();
        let name = format!("{}__{}", struct_data.name, type_args.join("_"));

        // Register if not already monomorphized
        if !self.structs.contains_key(&name) {
            let new_data = StructData {
                name: name.clone(),
                generic_type: Vec::new(),
                elements: new_elements,
                byte_size: offset,
            };
            self.structs.insert(name.clone(), new_data);
        }

        name
    }

    fn gen_expr_struct_init(
        &mut self,
        fields: &Vec<(String, Expr)>,
        struct_name: &String,
    ) -> String {
        let mut struct_data = self
            .structs
            .get(struct_name)
            .expect("Unknown struct")
            .clone();
        if struct_data.generic_type.len() > 0 {
            let name = self.gen_generic_struct(fields, struct_name);
            struct_data = self.structs.get(&name).unwrap().clone();
        }
        let base_pos = self.stack_pos;
        for (field_name, field_expr) in fields {
            let field = struct_data.elements.get(field_name).expect("Unknown field");
            let field_type = &field.ty;
            self.eval_expr(field_expr, field_type);
            let sized_reg = self.reg_for_size("rax", field_type).unwrap();
            let size_word = self.get_word(field_type);
            let field_pos = base_pos - field.offset;
            // can break code
            match field_type {
                Type::Array(..) => {}
                _ => {
                    self.emit_func_data(format!(
                        "    mov {} [rbp - {}], {}",
                        size_word, field_pos, sized_reg
                    ));
                }
            }
        }
        "rax".to_string()
    }

    fn gen_expr_struct_member(&mut self, base: &Box<Expr>, name: &String) -> String {
        let base_type = base.get_type(self);
        let base_type = self.resolve_generic_inst(&base_type);

        let struct_name = match &base_type {
            Type::Struct(n) => n.clone(),
            _ => self::panic!("member access on non-struct: {:?}", base_type),
        };

        let field = self
            .structs
            .get(&struct_name)
            .unwrap()
            .elements
            .get(name)
            .unwrap()
            .clone();
        let size_word = self.get_word(&field.ty);

        match &base.ty {
            ExprType::Deref(inner) => {
                // -> operator: eval inner to get pointer value, add offset, read
                self.eval_expr(inner, &Type::Pointer(Box::new(base_type.clone())));
                self.emit_func_data(format!("    add rax, {}", field.offset));
                let reg = self.reg_for_size("rax", &field.ty).unwrap();
                self.emit_func_data(format!("    mov {}, {} [rax]", reg, size_word));
            }
            ExprType::Variable(var_name) => {
                // . operator: compile-time offset
                let var = self.lookup_var(var_name);
                let reg = self.reg_for_size("rax", &field.ty).unwrap();
                let field_addr = var.stack_pos - field.offset;
                self.emit_func_data(format!(
                    "    mov {}, {} [rbp - {}]",
                    reg, size_word, field_addr
                ));
            }
            _ => {
                // chained a.b.c — runtime fallback
                self.eval_expr(base, &base_type);
                self.emit_func_data(format!("    add rax, {}", field.offset));
                let reg = self.reg_for_size("rax", &field.ty).unwrap();
                self.emit_func_data(format!("    mov {}, {} [rax]", reg, size_word));
            }
        }
        "rax".to_string()
    }

    fn gen_expr_deref(&mut self, expr: &Box<Expr>, expected_type: &Type) -> String {
        self.eval_expr(expr, expected_type);
        let size_word = self.get_word(expected_type);
        let sized_rax = self.reg_for_size("rax", expected_type).unwrap();

        match expected_type {
            Type::Primitive(TokenType::IntType)
            | Type::Primitive(TokenType::ShortType)
            | Type::Primitive(TokenType::CharType) => {
                self.emit_func_data(format!("    movsx rax, {} [rax]", size_word));
            }
            _ => {
                self.emit_func_data(format!("    mov {}, {} [rax]", sized_rax, size_word));
            }
        }
        "rax".to_string()
    }

    fn gen_expr_addres_of(&mut self, expr: &Box<Expr>) -> String {
        match &expr.ty {
            ExprType::Variable(name) => {
                let var = self.lookup_var(name);
                if var.global_flag {
                    self.emit_func_data(format!("    lea rax, [rel {}]", name));
                } else {
                    self.emit_func_data(format!("    lea rax, [rbp - {}]", var.stack_pos));
                }
                "rax".to_string()
            }

            ExprType::StructMember { base, name } => {
                self.member_addr(base, name);
                "rax".to_string()
            }

            ExprType::Index { base, index } => {
                let elem_type = expr.get_type(self);
                let elem_size = self.type_size(&elem_type);
                let base_type = base.get_type(self);

                // eval base first, push it
                self.eval_expr(base, &base_type);
                self.push_result();

                // eval index, scale it
                self.eval_expr(index, &Type::Primitive(TokenType::LongType));
                self.emit_func_data(format!("    imul rax, rax, {}", elem_size));

                // pop base, add scaled index
                self.pop_into("rbx");
                self.emit_func_data("    add rax, rbx".to_string());
                "rax".to_string()
            }

            ExprType::Deref(inner) => {
                // &*ptr == ptr
                let ptr_type = Type::Pointer(Box::new(expr.get_type(self)));
                self.eval_expr(inner, &ptr_type)
            }

            _ => self::panic!("Cannot take address of this expression: {:?}", expr),
        }
    }

    fn gen_expr_index(
        &mut self,
        base: &Box<Expr>,
        index: &Box<Expr>,
        expected_type: &Type,
    ) -> String {
        let arr_ty = &base.get_type(self);
        self.eval_expr(base, arr_ty);
        self.push_result();
        let index_reg = self.eval_expr(index, &Type::Primitive(TokenType::LongType));
        //runtime checking
        match arr_ty {
            Type::Array(ty, size) => {
                self.emit_func_data(format!("    cmp {}, {}", index_reg, size));
                self.emit_func_data(format!("    jge __bounds_fail__"));
                self.emit_func_data(format!("    cmp {}, 0", index_reg));
                self.emit_func_data(format!("    jl __bounds_fail__"));
            }
            _ => {}
        }

        let elem_size = self.type_size(expected_type);
        self.emit_func_data(format!("    imul rax, rax, {}", elem_size,));
        self.pop_into("rbx");
        self.emit_func_data(format!("    add rax, rbx"));
        let size_word = self.get_word(&expected_type);
        match &expected_type {
            Type::Primitive(TokenType::CharType)
            | Type::Primitive(TokenType::ShortType)
            | Type::Primitive(TokenType::IntType) => {
                self.emit_func_data(format!("    movsx rax, {} [rax]", size_word));
            }
            _ => {
                self.emit_func_data(format!("    mov rax, {} [rax]", size_word));
            }
        }
        "rax".to_string()
    }

    fn gen_array_init(&mut self, elements: &Vec<Expr>, expected_type: &Type) -> String {
        let elem_type = match expected_type {
            Type::Array(elem_ty, _) => *elem_ty.clone(),
            _ => self::panic!("gen_array_init called with non-array type"),
        };
        let elem_size = self.type_size(&elem_type);
        let base_pos = self.stack_pos;

        for (i, elem) in elements.iter().enumerate() {
            self.eval_expr(elem, &elem_type);
            let sized_reg = self.reg_for_size("rax", &elem_type).unwrap();
            let size_word = self.get_word(&elem_type);
            let offset = base_pos - (i * elem_size);

            self.emit_func_data(format!(
                "    mov {} [rbp - {}], {}",
                size_word, offset, sized_reg
            ));
        }
        self.emit_func_data(format!("    lea rax, [rbp - {}]", base_pos));
        "rax".to_string()
    }

    fn gen_size_of(&mut self, stmt: &Box<Stmt>) -> String {
        let ty = {
            match &stmt.ty {
                StmtType::Declaration(decl) => decl.ty.clone(),
                _ => self::panic!("bug"),
            }
        };
        let ty = self.ensure_monomorphized(&ty);
        let size = self.type_size(&ty);
        self.emit_func_data(format!("    mov rax, {}", size));
        "rax".to_string()
    }

    fn gen_string(&mut self, str: &String) -> String {
        let id = self.get_id();
        self.emit_data(format!("str_{}: db \"{}\", 0", id, str));
        self.emit_func_data(format!("    lea rax, [rel str_{}]", id));
        "rax".to_string()
    }

    fn gen_cast(&mut self, expr: &Box<Expr>, ty: &Type) -> String {
        self.eval_expr(expr, ty);
        let sized = self.reg_for_size("rax", ty).unwrap();
        if sized != "rax" {
            self.emit_func_data(format!("    movsx rax, {}", sized));
        }
        "rax".to_string()
    }

    pub fn resolve_generic_inst(&self, ty: &Type) -> Type {
        match ty {
            Type::GenericInst(_, _) => {
                let mangled = type_name(ty);
                if self.structs.contains_key(&mangled) {
                    Type::Struct(mangled)
                } else if self.enums.contains_key(&mangled) {
                    Type::Enum(mangled, None)
                } else {
                    self::panic!("GenericInst not yet monomorphized: {:?}", ty)
                }
            }
            Type::Pointer(inner) => Type::Pointer(Box::new(self.resolve_generic_inst(inner))),
            _ => ty.clone(),
        }
    }

    pub fn enum_get_size(&self, base: &String) -> usize {
        let mut size = 0;
        let enum_data = self.enums.get(base).unwrap();
        for (name, data) in enum_data.variants.iter() {
            let mut res_size = 0;
            for i in data.args.iter() {
                res_size += self.type_size(&i.ty);
            }
            if res_size > size {
                size = res_size;
            }
        }
        // accounting for tag
        size + TAG_SIZE
    }

    fn handle_generic_enum(
        &mut self,
        enum_data: &EnumData,
        values: &Vec<EnumExprField>,
        variant: &String,
    ) -> String {
        let mut type_map: HashMap<String, Type> = HashMap::new();
        for (name, field) in enum_data.variants.iter() {
            if field.name == *variant {
                for (index, enum_field) in field.args.iter().enumerate() {
                    let expr_ty = values[index].expr.get_type(self);
                    self.resolve_generic(&expr_ty, &enum_field.ty, &mut type_map);
                }
            }
        }

        let type_args: Vec<String> = enum_data
            .generic_type
            .iter()
            .map(|param| type_map.get(param).map(type_name).unwrap_or(param.clone()))
            .collect();
        let name = format!("{}__{}", enum_data.name, type_args.join("_"));
        name
    }

    // TODO: make this bettter
    pub fn gen_get_enum_addr(
        &mut self,
        base: &String,
        value: &Vec<EnumExprField>,
        variant: &String,
    ) -> String {
        let pos = self.stack_pos;
        let mut base = base.clone();
        let enum_data = self
            .enums
            .get(&base)
            .expect(&format!("no enum with name {}", base))
            .clone();
        if enum_data.generic_type.len() > 0 {
            base = self.handle_generic_enum(&enum_data, value, variant);
        }
        let variant_data = enum_data
            .variants
            .get(variant)
            .expect(&format!("in enum {} no field {}", base, variant));
        // if we have value its creating an object

        if value.is_empty() {
            self.emit_func_data(format!("    lea rax, {}", variant_data.tag));
            return "rax".to_string();
        }

        self.emit_func_data(format!("    mov rax, {}", variant_data.tag));
        self.emit_func_data(format!("    mov [rbp - {}], rax", pos));
        // this reserves space for tag
        self.stack_pos -= 8;
        for (index, var) in variant_data.args.clone().iter().enumerate() {
            let res = &value[index];
            let mut var_ty = var.ty.clone();
            match var.ty {
                Type::GenericType(_) => {
                    var_ty = res.expr.get_type(self);
                }
                _ => {}
            }
            self.eval_expr(&res.expr, &var_ty);
            let reg = self.reg_for_size("rax", &var_ty).unwrap();
            let word = self.get_word(&var_ty);
            match &var_ty {
                Type::Primitive(_) | Type::Array(..) | Type::Pointer(_) => {
                    self.emit_func_data(format!(
                        "    mov {} [rbp - {}], {}",
                        word,
                        self.stack_pos - var.offset,
                        reg
                    ));
                }
                _ => {}
            }
        }
        self.emit_func_data(format!("    lea rax, [rbp - {pos}]"));
        // returns space
        self.stack_pos += 8;

        return "rax".to_string();
    }

    pub fn gen_get_enum(
        &mut self,
        base: &String,
        value: &Vec<EnumExprField>,
        variant: &String,
    ) -> String {
        let pos = self.stack_pos;
        let mut base = base.clone();
        let enum_data = self
            .enums
            .get(&base)
            .expect(&format!("no enum with name {}", base))
            .clone();
        if enum_data.generic_type.len() > 0 {
            base = self.handle_generic_enum(&enum_data, value, variant);
        }
        let variant_data = enum_data
            .variants
            .get(variant)
            .expect(&format!("in enum {} no field {}", base, variant));
        // if we have value its creating an object

        if value.is_empty() {
            self.emit_func_data(format!("    mov rax, {}", variant_data.tag));
            return "rax".to_string();
        }

        self.emit_func_data(format!("    mov rax, {}", variant_data.tag));
        self.emit_func_data(format!("    mov [rbp - {}], rax", pos));
        // this reserves space for tag
        self.stack_pos -= 8;
        for (index, var) in variant_data.args.clone().iter().enumerate() {
            let res = &value[index];
            let mut var_ty = var.ty.clone();
            match var.ty {
                Type::GenericType(_) => {
                    var_ty = res.expr.get_type(self);
                }
                _ => {}
            }
            self.eval_expr(&res.expr, &var_ty);
            let reg = self.reg_for_size("rax", &var_ty).unwrap();
            let word = self.get_word(&var_ty);
            match &var_ty {
                Type::Primitive(_) | Type::Array(..) | Type::Pointer(_) => {
                    self.emit_func_data(format!(
                        "    mov {} [rbp - {}], {}",
                        word,
                        self.stack_pos - var.offset,
                        reg
                    ));
                }
                _ => {}
            }
        }
        self.emit_func_data(format!("    mov rax, [rbp - {pos}]"));
        // returns space
        self.stack_pos += 8;

        return "rax".to_string();
    }

    pub fn eval_expr(&mut self, expr: &Expr, expected_type: &Type) -> String {
        match &expr.ty {
            ExprType::ArrayInit { elements } => self.gen_array_init(elements, expected_type),
            ExprType::Number(num) => self.gen_expr_num(num, expected_type),

            ExprType::Variable(var) => self.gen_expr_var(var, expected_type),

            ExprType::Binary { op, left, right } => {
                let expr_ty = expr.get_type(self);
                self.gen_expr_binary((op, left, right), &expr_ty)
            }

            ExprType::Unary { op, expr: inner } => self.gen_expr_unary(op, inner, expected_type),

            ExprType::Call {
                name,
                args,
                generics,
            } => {
                let (func_data, overload_pos) = self.resolve_call(name, args, generics).unwrap();
                self.gen_call(&name, args, &func_data, overload_pos, generics)
            }

            ExprType::Deref(inner) => {
                let ty = expr.get_type(self);
                self.gen_expr_deref(inner, &ty)
            }

            ExprType::Index { base, index } => {
                let ty = expr.get_type(self);
                self.gen_expr_index(base, index, &ty)
            }

            ExprType::StructMember { base, name } => {
                let ty = expr.get_type(self);
                self.gen_expr_struct_member(base, name)
            }

            ExprType::Cast { expr, ty } => self.gen_cast(expr, ty),

            ExprType::StructInit {
                fields,
                struct_name_ty,
            } => self.gen_expr_struct_init(fields, struct_name_ty),

            ExprType::SizeOf { ty } => self.gen_size_of(ty),
            ExprType::Float(_) => self::panic!("floats not implemented"),
            ExprType::String { str } => self.gen_string(str),
            ExprType::GetEnum {
                base,
                value,
                variant,
            } => self.gen_get_enum(base, value, variant),
        }
    }
}
