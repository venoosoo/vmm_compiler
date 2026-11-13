use crate::Ir::expr::{BinOp, ComptimeFn, Expr, ExprType, UnaryOp};
use crate::Ir::stmt::{Stmt, StmtType};

use super::*;

#[derive(Debug, PartialEq, Clone)]
pub enum ComptimeVal {
    Num(i64),
    Str(String),
}

impl<'a> Analyzer<'a> {
    pub fn check_comptime(&mut self, comp_time: &Stmt) -> Option<()> {
        match &comp_time.ty {
            StmtType::If {
                condition,
                if_block,
                else_block,
            } => {
                self.check_comptime_value(condition);
                self.check_stmt(if_block);

                if let Some(else_b) = else_block {
                    self.check_stmt(else_b);
                }
            }
            _ => {
                self.print_error(self.type_to_error(SemanticError::CompTimeNotAnIf));
                return None;
            }
        }

        Some(())
    }

    pub fn eval_comptime_expr(&mut self, expr: &Expr) -> Option<bool> {
        match self.check_comptime_value(expr)? {
            ComptimeVal::Num(n) => Some(n != 0),
            ComptimeVal::Str(s) => {
                dbg!(&s);
                Some(!s.is_empty())
            }
        }
    }

    fn check_comptime_value(&mut self, expr: &Expr) -> Option<ComptimeVal> {
        match &expr.ty {
            ExprType::Number(_) => Some(ComptimeVal::Num(0)),
            ExprType::String { str } => Some(ComptimeVal::Str(str.clone())),

            ExprType::ComptimeFn(comp_fn) => match comp_fn {
                ComptimeFn::SizeOf(ty) => {
                    if let Some(monomorphized) = self.ensure_monomorphized(ty) {
                        let _ = self.type_size(&monomorphized);
                    }
                    Some(ComptimeVal::Num(0))
                }
                ComptimeFn::TargetOs => Some(ComptimeVal::Str(self.target_os.clone())),
            },

            ExprType::Unary { op, expr: inner } => {
                let inner_val = self.check_comptime_value(inner)?;

                if let ComptimeVal::Num(_) = inner_val {
                    match op {
                        UnaryOp::Neg | UnaryOp::Not => Some(ComptimeVal::Num(0)),
                        _ => {
                            self.print_error(
                                self.type_to_error(SemanticError::UnsuportedUnaryCompTime),
                            );
                            return None;
                        }
                    }
                } else {
                    self.print_error(self.type_to_error(SemanticError::InvalidUnaryCompTime));
                    return None;
                }
            }

            ExprType::Binary { op, left, right } => {
                let l_val = self.check_comptime_value(left)?;
                let r_val = self.check_comptime_value(right)?;

                match (l_val, r_val) {
                    (ComptimeVal::Num(num1), ComptimeVal::Num(num2)) => match op {
                        BinOp::Eq => Some(ComptimeVal::Num((num1 == num2) as i64)), 
                        BinOp::Neq => Some(ComptimeVal::Num((num1 != num2) as i64)),
                        _ => {
                            self.print_error(self.type_to_error(SemanticError::InvalidBinary {
                                op: op.clone(),
                                left: left.get_type(self)?,
                                right: right.get_type(self)?,
                            }));
                            Some(ComptimeVal::Num(0))
                        },
                    }
                    (ComptimeVal::Str(str1), ComptimeVal::Str(str2)) => match op {
                        BinOp::Eq => Some(ComptimeVal::Num((str1 == str2) as i64)), 
                        BinOp::Neq => Some(ComptimeVal::Num((str1 != str2) as i64)),
                        _ => {
                            self.print_error(self.type_to_error(SemanticError::InvalidBinary {
                                op: op.clone(),
                                left: left.get_type(self)?,
                                right: right.get_type(self)?,
                            }));
                            Some(ComptimeVal::Num(0))
                        }
                    },
                    _ => {
                        self.print_error(self.type_to_error(SemanticError::InvalidBinary {
                            op: op.clone(),
                            left: left.get_type(self)?,
                            right: right.get_type(self)?,
                        }));
                        return None;
                    }
                }
            }
            _ => {
                self.print_error(self.type_to_error(SemanticError::CompTimeNotCompTime));
                return None;
            }
        }
    }
    pub fn check_comp_time(&self, comp_time: &ComptimeFn) -> Option<Type> {
        match comp_time {
            ComptimeFn::SizeOf(ty) => {
                let ty = self.type_size(&ty);
                if ty.is_none() {
                    return None;
                } else {
                    return Some(Type::Primitive(TokenType::I64));
                }
            }
            ComptimeFn::TargetOs => {
                return Some(Type::Pointer(Box::new(Type::Primitive(TokenType::U8))));
            }
        }
    }
}
