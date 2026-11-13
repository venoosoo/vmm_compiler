use crate::Ir::expr::{BinOp, ComptimeFn};

use super::*;

#[derive(Debug, PartialEq, Clone)]
pub enum ComptimeVal {
    Num(i64),
    Str(String),
}

impl Gen {
    pub fn gen_comptime(&mut self, comp_time: &Stmt) -> Option<()> {
        match &comp_time.ty {
            StmtType::If {
                condition,
                if_block,
                else_block,
            } => {
                let is_true = self.eval_comptime_expr(condition);

                if is_true {
                    self.gen_stmt(if_block);
                } else if let Some(else_b) = else_block {
                    self.gen_stmt(else_b);
                }
            }
            _ => panic!("comptime stmt is not if"),
        }

        Some(())
    }

    pub fn eval_comptime_expr(&self, expr: &Expr) -> bool {
        match self.eval_comptime_value(expr) {
            ComptimeVal::Num(n) => n != 0,
            ComptimeVal::Str(s) => !s.is_empty(),
        }
    }

    pub fn gen_comptime_fn(&mut self, comp_time: &ComptimeFn) -> Option<String> {
        match comp_time {
            ComptimeFn::SizeOf(ty) => {
                let ty = self.ensure_monomorphized(ty).unwrap();
                let size = self.type_size(&ty)?;
                self.emit_func_data(format!("    mov rax, {}", size));
                Some("rax".to_string())
            }
            ComptimeFn::TargetOs => {
                self.emit_data(format!("__target__os: db \"{}\"", self.target_os));
                self.emit_func_data(format!("    lea rax, [rel __target__os]",));
                Some("rax".to_string())
            }
        }
    }

    fn eval_comptime_value(&self, expr: &Expr) -> ComptimeVal {
        match &expr.ty {
            ExprType::Number(num) => ComptimeVal::Num(*num),

            ExprType::String { str } => ComptimeVal::Str(str.clone()),

            ExprType::ComptimeFn(comp_fn) => match comp_fn {
                ComptimeFn::SizeOf(ty) => {
                    let monomorphized = self.ensure_monomorphized(ty).unwrap();
                    let size = self.type_size(&monomorphized).unwrap();
                    ComptimeVal::Num(size as i64)
                }
                ComptimeFn::TargetOs => ComptimeVal::Str(self.target_os.clone()),
            },

            ExprType::Unary { op, expr: inner } => {
                let inner_val = self.eval_comptime_value(inner);
                if let ComptimeVal::Num(n) = inner_val {
                    let res = match op {
                        UnaryOp::Neg => -n,
                        UnaryOp::Not => {
                            if n == 0 {
                                1
                            } else {
                                0
                            }
                        }
                        UnaryOp::BitNot => !n,
                        _ => panic!("Unsupported unary op in comptime"),
                    };
                    ComptimeVal::Num(res)
                } else {
                    panic!("Cannot apply unary operator to string in comptime");
                }
            }

            ExprType::Binary { op, left, right } => {
                let l_val = self.eval_comptime_value(left);
                let r_val = self.eval_comptime_value(right);

                match (l_val, r_val) {
                    (ComptimeVal::Num(l), ComptimeVal::Num(r)) => {
                        let res = match op {
                            BinOp::Add => l + r,
                            BinOp::Sub => l - r,
                            BinOp::Mul => l * r,
                            BinOp::Div => l / r,
                            BinOp::Mod => l % r,

                            BinOp::Eq => {
                                if l == r {
                                    1
                                } else {
                                    0
                                }
                            }
                            BinOp::Neq => {
                                if l != r {
                                    1
                                } else {
                                    0
                                }
                            }
                            BinOp::Lt => {
                                if l < r {
                                    1
                                } else {
                                    0
                                }
                            }
                            BinOp::Lte => {
                                if l <= r {
                                    1
                                } else {
                                    0
                                }
                            }
                            BinOp::Gt => {
                                if l > r {
                                    1
                                } else {
                                    0
                                }
                            }
                            BinOp::Gte => {
                                if l >= r {
                                    1
                                } else {
                                    0
                                }
                            }

                            BinOp::And => {
                                if l != 0 && r != 0 {
                                    1
                                } else {
                                    0
                                }
                            }
                            BinOp::Or => {
                                if l != 0 || r != 0 {
                                    1
                                } else {
                                    0
                                }
                            }

                            BinOp::BitAnd => l & r,
                            BinOp::BitOr => l | r,
                            BinOp::BitXor => l ^ r,
                            BinOp::ShiftLeft => l << r,
                            BinOp::ShiftRight => l >> r,
                        };
                        ComptimeVal::Num(res)
                    }
                    (ComptimeVal::Str(l), ComptimeVal::Str(r)) => {
                        // Allow string comparison for things like `target_os() == "linux"`
                        let res = match op {
                            BinOp::Eq => {
                                if l == r {
                                    1
                                } else {
                                    0
                                }
                            }
                            BinOp::Neq => {
                                if l != r {
                                    1
                                } else {
                                    0
                                }
                            }
                            _ => panic!("Invalid binary operator for strings in comptime"),
                        };
                        ComptimeVal::Num(res)
                    }
                    _ => panic!(
                        "Type mismatch in comptime evaluation: cannot mix strings and numbers"
                    ),
                }
            }
            _ => panic!(
                "Expression type cannot be evaluated at compile time: {:?}",
                expr.ty
            ),
        }
    }
}
