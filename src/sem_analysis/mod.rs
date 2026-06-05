use std::{cell::Cell, collections::HashMap, env::var};

use indexmap::IndexMap;

use crate::{
    Ir::{
        Stmt,
        expr::Expr,
        r#gen::{FuncData, StructData},
        sem_analysis::*,
        shared::TypeContext,
        stmt::{EnumData, EnumVariant, StmtType, StructField, Type},
    },
    shared::{check_types, substitute_type, type_name},
    tokenizer::TokenType,
};

pub mod sem_expr;
mod sem_stmt;

impl<'a> TypeContext for Analyzer<'a> {
    fn resolve_call(
        &mut self,
        name: &String,
        args: &Vec<Expr>,
        generics: &Vec<Type>,
    ) -> Option<(FuncData, usize)> {
        if generics.len() > 0 {
            let vec_func_data = self.get_function(name);
            if vec_func_data.len() < 1 {
                return None;
            }
            return Some((vec_func_data[0].clone(), 0));
        }
        let vec_func_data = self.get_function(name);
        if vec_func_data.len() < 1 {
            return None;
        }
        let (overload_pos, func_data) = vec_func_data
            .iter()
            .enumerate()
            .find(|(_, func)| {
                if func.args.len() != args.len() {
                    return false;
                }
                args.iter().enumerate().all(|(i, expr)| {
                    let expr_ty = expr.get_type(self);
                    let param_ty = &func.args[i].ty.clone();
                    let expr_ty = self.ensure_monomorphized(&expr_ty);
                    let param_ty = self.ensure_monomorphized(param_ty);
                    check_types(&expr_ty, &param_ty)
                })
            })
            .expect(&format!("no matching overload for function '{}'", name,));
        Some((func_data.clone(), overload_pos))
    }

    fn monomorphize_struct(&mut self, def: &StructData, type_args: &Vec<Type>) -> Type {
        let mangled = format!(
            "{}__{}",
            def.name,
            type_args
                .iter()
                .map(|t| type_name(t))
                .collect::<Vec<_>>()
                .join("_")
        );
        if self.structs.contains_key(&mangled) {
            return Type::Struct(mangled.clone()); // already done
        }

        // substitute types in fields and recompute offsets
        let mut offset = 0;
        let fields: Vec<StructField> = def
            .elements
            .iter()
            .map(|f| {
                let concrete_ty = substitute_type(&f.1.ty, &def.generic_type, type_args);
                let field_size = self.type_size(&concrete_ty);
                let field = StructField {
                    name: f.1.name.clone(),
                    ty: concrete_ty,
                    offset,
                };
                offset += field_size;
                field
            })
            .collect();
        self.structs.insert(
            mangled.clone(),
            StructData {
                generic_type: Vec::new(),
                name: mangled.clone(),
                elements: fields.iter().map(|f| (f.name.clone(), f.clone())).collect(),
                byte_size: offset, // total size
            },
        );
        return Type::Struct(mangled);
    }

    fn monomorphize_enum(&mut self, def: &EnumData, type_args: &Vec<Type>) -> Type {
        let mangled = format!(
            "{}__{}",
            def.name,
            type_args
                .iter()
                .map(|t| type_name(t))
                .collect::<Vec<_>>()
                .join("_")
        );

        if self.enums.contains_key(&mangled) {
            return Type::Enum(mangled.clone(), None); // already done
        }

        let mut new_variants = HashMap::new();
        for (var_name, variant) in def.variants.iter() {
            let new_args: Vec<StructField> = variant
                .args
                .iter()
                .map(|arg| StructField {
                    name: arg.name.clone(),
                    ty: substitute_type(&arg.ty, &def.generic_type, type_args),
                    // the tag offest
                    offset: arg.offset + 8,
                })
                .collect();
            new_variants.insert(
                var_name.clone(),
                EnumVariant {
                    name: variant.name.clone(),
                    tag: variant.tag,
                    args: new_args,
                    size: 0,
                },
            );
        }
        self.enums.insert(
            mangled.clone(),
            EnumData {
                name: mangled.clone(),
                generic_type: Vec::new(),
                variants: new_variants,
                size: 0,
            },
        );
        return Type::Enum(mangled, None);
    }

    fn ensure_monomorphized(&mut self, ty: &Type) -> Type {
        match ty {
            Type::GenericInst(name, type_args) => {
                let mangled = type_name(ty);
                // already done?
                if self.structs.contains_key(&mangled) {
                    return Type::Struct(mangled.clone());
                }
                if self.enums.contains_key(&mangled) {
                    return Type::Enum(mangled.clone(), None);
                }
                // find the generic definition and monomorphize
                if let Some(struct_def) = self.structs.get(name).cloned() {
                    return self.monomorphize_struct(&struct_def, type_args);
                } else if let Some(enum_def) = self.enums.get(name).cloned() {
                    return self.monomorphize_enum(&enum_def, type_args);
                } else {
                    panic!("unknown generic type: {}", name);
                }
            }
            Type::Pointer(inner) => {
                let ty = self.ensure_monomorphized(inner);
                Type::Pointer(Box::new(ty))
            }
            Type::Array(inner, size) => {
                let ty = self.ensure_monomorphized(inner);
                Type::Array(Box::new(ty), *size)
            }
            _ => ty.clone(),
        }
    }
}

impl<'a> Analyzer<'a> {
    pub fn new(stmts: &'a Vec<Stmt>) -> Self {
        Self {
            stmts,
            generics: HashMap::new(),
            had_error: Cell::new(false),
            scopes: vec![HashMap::new()], // start with global scope
            functions: HashMap::new(),
            structs: HashMap::new(),
            current_file: String::new(),
            line: 0,
            col: 0,
            global_vars: HashMap::new(),
            enums: HashMap::new(),
            generic_func: HashMap::new(),
            current_ret_type: Type::Unknown,
            loop_depth: 0,
        }
    }

    // this is just copy from gen
    // TODO: make this a trait so and expand it for gen and analyzer
    pub fn type_size(&self, ty: &Type) -> usize {
        match ty {
            Type::Primitive(token) => match token {
                TokenType::CharType => 1,
                TokenType::ShortType => 2,
                TokenType::IntType => 4,
                TokenType::LongType => 8,
                _ => panic!("Unsupported primitive type: {:?}", token),
            },
            Type::Pointer(_) => 8,
            Type::Array(elem_type, count) => self.type_size(elem_type),
            Type::Struct(name) => {
                self.structs
                    .get(name)
                    .expect(&format!("Unknown struct: {}", name))
                    .byte_size
            }
            Type::GenericInst(..) => todo!(),
            Type::GenericType(_) => todo!(),
            Type::Enum(..) => 8,
            Type::Unknown => panic!("unkown type"),
        }
    }

    pub fn print_error(&self, err: Error) {
        println!("{:?}", err);
        self.had_error.set(true);
    }

    pub fn check_inits(&mut self) {
        for i in self.stmts.iter() {
            self.current_file = i.file.clone();
            self.line = i.line;
            match &i.ty {
                StmtType::GenericInitFunc {
                    name,
                    generic_types,
                    args,
                    ret_type,
                    data,
                } => {
                    let func_data = FuncData {
                        args: args.clone(),
                        generic: generic_types.clone(),
                        return_type: ret_type.clone(),
                    };
                    self.functions
                        .entry(name.clone())
                        .or_insert_with(Vec::new)
                        .push(func_data);
                    self.generic_func.insert(name.clone(), i.clone());
                }

                StmtType::InitFunc {
                    name,
                    args,
                    ret_type,
                    data,
                    generic_types,
                } => {
                    let func_data = FuncData {
                        args: args.clone(),
                        generic: Vec::new(),
                        return_type: ret_type.clone(),
                    };
                    self.functions
                        .entry(name.clone())
                        .or_insert_with(Vec::new)
                        .push(func_data);
                }
                StmtType::InitStruct(data) => {
                    let fields = {
                        let mut res = IndexMap::new();
                        for i in data.fields.iter() {
                            res.insert(i.name.clone(), i.clone());
                        }
                        res
                    };
                    let struct_data = StructData {
                        name: data.name.clone(),
                        generic_type: data.generic_type.clone(),
                        byte_size: data.size,
                        elements: fields,
                    };
                    self.structs.insert(data.name.clone(), struct_data);
                }
                StmtType::InitEnum {
                    name,
                    variants,
                    generic_types,
                } => {
                    // TODO: add size checking
                    let enum_data = EnumData {
                        name: name.clone(),
                        generic_type: generic_types.clone(),
                        variants: variants.clone(),
                        size: 0,
                    };
                    self.enums.insert(name.clone(), enum_data);
                }
                _ => {}
            }
        }
    }

    pub fn type_to_error(&self, error_ty: SemanticError) -> Error {
        Error {
            ty: error_ty,
            file: self.current_file.clone(),
            line: self.line,
            col: self.col,
        }
    }

    pub fn lookup(&self, expected_name: &String) -> Option<Type> {
        for i in self.scopes.iter() {
            for (name, ty) in i {
                if name == expected_name {
                    return Some(ty.clone());
                }
            }
        }
        if let Some(global_data) = self.global_vars.get(expected_name) {
            return Some(global_data.clone());
        }
        return None;
    }

    pub fn get_function(&mut self, name: &String) -> Vec<FuncData> {
        let func_data = self.functions.get(name);
        if func_data.is_some() {
            return func_data.unwrap().to_vec();
        } else {
            self.print_error(self.type_to_error(SemanticError::UndeclaredFunction(name.clone())));
            Vec::new()
        }
    }

    pub fn add_var(&mut self, name: String, ty: Type) {
        let map = self.scopes.last_mut().unwrap();
        map.insert(name, ty);
    }

    pub fn check_code(&mut self) {
        //first iteration to get all structs and func data
        self.check_inits();
        // checking of every stmt
        for i in self.stmts.iter() {
            self.check_stmt(i);
        }
    }
}
