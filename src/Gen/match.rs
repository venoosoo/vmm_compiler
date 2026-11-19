use super::*;
use crate::Ir::{
    expr::{MatchField, MatchLeftValue},
    r#gen::Gen,
    stmt::Declaration,
};

impl Gen {
    pub fn gen_match(&mut self, expr: &Expr, variants: &Vec<MatchField>) -> Option<String> {
        let id = self.get_id();
        let expr_ty = &expr.get_type(self)?;
        let _reg = self.eval_expr(expr, expr_ty)?;
        let pos = self.alloc(8);
        self.emit_func_data(format!("    mov [rbp - {}], rax", pos));
        let expr_ty = expr.get_type(self)?;
        match expr_ty {
            Type::Enum(..) => {
                self.emit_func_data(format!("    mov rax, [rax]"));
            }
            Type::Pointer(..) => self.emit_func_data(format!("    mov rax, [rax]")),
            _ => {}
        }
        self.resolve_match_expr(pos, variants, id, &expr_ty);
        self.stack_pos -= 8;
        return Some("rax".to_string());
    }

    fn resolve_match_expr(
        &mut self,
        base_pos: usize,
        variants: &Vec<MatchField>,
        id: usize,
        expr_ty: &Type,
    ) {
        //match expr_ty
        for var in variants {
            self.gen_match_asm_checking(var, id, &expr_ty);
        }
        self.emit_func_data(format!("    jmp match_end_{id}"));
        for var in variants {
            self.gen_match_asm_func(var, id, base_pos, &expr_ty);
        }
        self.emit_func_data(format!("match_end_{}:", id));
    }

    fn gen_match_field(&mut self, variant: &MatchField, base_pos: usize, expr_ty: &Type) {
        match &variant.left {
            MatchLeftValue::Enum { base, value, args } => {
                if base == "_" || args.len() < 1 {
                    self.gen_stmt(&variant.right);
                    return;
                }
                let new_base: &String = {
                    match expr_ty {
                        Type::Enum(name, _) => name,
                        _ => base,
                    }
                };
                let enum_data = self.enums.borrow().get(new_base).unwrap().clone();
                let field_data = enum_data.variants.get(value).unwrap();
                for (index, arg) in args.iter().enumerate() {
                    let field = &field_data.args[index];
                    let decl = Declaration {
                        name: arg.clone(),
                        ty: field.ty.clone(),
                        initializer: None,
                    };
                    self.gen_declaration(&decl);
                    let new_var_pos = self.stack_pos;
                    // the tag size
                    let pos = base_pos;
                    let reg = self.reg_for_size("rax", &field.ty).unwrap();
                    self.gen_match_field_arg(expr_ty, &field, &reg, pos);
                    self.emit_func_data(format!("    mov [rbp - {new_var_pos}], {reg}"));
                }
                self.gen_stmt(&variant.right);
            }
            MatchLeftValue::Expr { .. } => {
                self.gen_stmt(&variant.right);
            }
        }
    }

    fn gen_match_asm_checking(&mut self, var: &MatchField, id: usize, expr_ty: &Type) {
        match &var.left {
            MatchLeftValue::Expr { expr } => match expr.ty {
                ExprType::Number(num) => {
                    self.emit_func_data(format!("    cmp rax, {num}"));
                    self.emit_func_data(format!("    je match_{}_{}", id, num));
                }
                _ => self::panic!("match field left value not supported"),
            },
            MatchLeftValue::Enum {
                base,
                value,
                args: _,
            } => {
                if base == "_" {
                    self.emit_func_data(format!("    jmp match_{id}_wildcard"));
                    return;
                }
                let new_base = {
                    match expr_ty {
                        Type::Enum(name, _) => name,
                        _ => base,
                    }
                };
                let enum_data = self.enums.borrow().get(new_base).cloned().unwrap();
                let field_data = enum_data.variants.get(value).unwrap();
                let tag = field_data.tag;
                self.emit_func_data(format!("    cmp rax, {}", tag));
                self.emit_func_data(format!("    je match_{}_{}", id, tag));
            }
        }
    }

    fn gen_match_asm_func(
        &mut self,
        variant: &MatchField,
        id: usize,
        base_pos: usize,
        expr_ty: &Type,
    ) {
        match &variant.left {
            MatchLeftValue::Expr { expr } => match expr.ty {
                ExprType::Number(num) => {
                    self.emit_func_data(format!("match_{}_{}:", id, num));
                }
                _ => self::panic!("not supported"),
            },
            MatchLeftValue::Enum {
                base,
                value,
                args: _,
            } => {
                if base == "_" {
                    self.emit_func_data(format!("match_{id}_wildcard:"));
                } else {
                    let new_base = {
                        match expr_ty {
                            Type::Enum(name, _) => name,
                            _ => base,
                        }
                    };
                    let enum_data = self.enums.borrow().get(new_base).cloned().unwrap();
                    let field_data = enum_data.variants.get(value).unwrap();
                    let tag = field_data.tag;
                    self.emit_func_data(format!("match_{id}_{tag}:"));
                }
            }
        }
        self.scopes.push(HashMap::new());
        self.gen_match_field(&variant, base_pos, expr_ty);
        self.emit_func_data(format!("    jmp match_end_{id}"));
        self.scopes.pop();
    }

    fn gen_match_field_arg(
        &mut self,
        var_ty: &Type,
        field: &StructField,
        reg: &String,
        pos: usize,
    ) {
        match var_ty {
            Type::Primitive(_) => match field.ty {
                Type::Primitive(_) | Type::Array(..) => {
                    self.emit_func_data(format!("    mov {reg}, [rbp - {pos}]"));
                }
                Type::Unknown => {
                    self::panic!("some error");
                }
                _ => {
                    self.emit_func_data(format!("    lea {reg}, [rbp - {pos}]"));
                }
            },
            Type::Enum(..) => {
                self.emit_func_data(format!("    mov rax, [rbp - {}]", pos));
                self.emit_func_data(format!("    add rax, {}", field.offset));
                self.emit_func_data(format!("    mov rax, [rax]"));
            }
            Type::Pointer(_) => {
                self.emit_func_data(format!("    mov rax, [rbp - {}]", pos));
                self.emit_func_data(format!("    add rax, {}", field.offset + TAG_SIZE));
                self.emit_func_data(format!("    mov rax, [rax]"));
            }
            _ => {
                self::panic!("match arg error: {:?}", var_ty);
            }
        }
    }
}
