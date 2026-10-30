use std::dbg;

use super::*;

use crate::{
    Ir::expr::*,
    shared::{gen_module_func_name, transform_module_name},
};

impl<'a> Parser<'a> {
    fn parse_struct_expr(&mut self, struct_name: &String) -> Option<Expr> {
        let mut fields = Vec::new();

        self.expect(TokenType::OpenScope);

        while self.peek(0).token != TokenType::CloseScope {
            let name_token = self.consume();
            if name_token.token != TokenType::Var {
                println!("name_token: {:?}", name_token);
                self::panic!("expected field name in struct init");
            }

            let field_name = self.unwrap_expect(name_token.value)?;
            self.expect(TokenType::Colon);
            let value = self.parse_expr()?;

            fields.push((field_name, value));
            if self.peek(0).token != TokenType::CloseScope {
                self.expect(TokenType::Coma);
            }
        }
        self.expect(TokenType::CloseScope);
        let expr_ty = ExprType::StructInit {
            fields,
            struct_name_ty: struct_name.clone(),
        };
        Some(Expr {
            ty: expr_ty,
            file: self.current_file.clone(),
            line: self.line,
            col: self.col,
        })
    }

    fn parse_init_array(&mut self) -> Option<Expr> {
        let mut elements = Vec::new();

        while self.peek(0).token != TokenType::CloseScope {
            elements.push(self.parse_expr()?);
            if self.peek(0).token == TokenType::Coma {
                self.consume();
            }
        }

        self.expect(TokenType::CloseScope);

        let expr_ty = ExprType::ArrayInit { elements };
        Some(Expr {
            ty: expr_ty,
            file: self.current_file.clone(),
            line: self.line,
            col: self.col,
        })
    }

    fn parse_primary(&mut self) -> Option<Expr> {
        match self.peek(0).token {
            TokenType::Var => {
                let token = self.consume();
                let token_value = token.value.unwrap();
                if self.is_struct(&token_value) && self.peek(0).token == TokenType::OpenScope {
                    self.parse_struct_expr(&token_value)
                } else {
                    let expr_ty = ExprType::Variable(token_value);
                    Some(Expr {
                        ty: expr_ty,
                        file: token.file.clone(),
                        line: token.line,
                        col: token.col,
                    })
                }
            }

            TokenType::Num => {
                let token = self.consume();
                let expr_ty = ExprType::Number(token.value.unwrap().parse().unwrap());
                Some(Expr {
                    ty: expr_ty,
                    file: token.file.clone(),
                    line: token.line,
                    col: token.col,
                })
            }
            TokenType::HexNum => {
                let token = self.consume();
                let token_value = &token.value.unwrap();
                let expr_ty = ExprType::Number(i64::from_str_radix(token_value, 16).unwrap());
                Some(Expr {
                    ty: expr_ty,
                    file: token.file,
                    line: token.line,
                    col: token.col,
                })
            }
            TokenType::OctalNum => {
                let token = self.consume();
                let token_value = &token.value.unwrap();

                let expr_ty = ExprType::Number(i64::from_str_radix(token_value, 8).unwrap());
                Some(Expr {
                    ty: expr_ty,
                    file: token.file.clone(),
                    line: token.line,
                    col: token.col,
                })
            }
            TokenType::Mul => {
                let token = self.consume();
                let rhs = self.parse_primary()?;
                let expr_ty = ExprType::Deref(Box::new(rhs));
                Some(Expr {
                    ty: expr_ty,
                    file: token.file.clone(),
                    line: token.line,
                    col: token.col,
                })
            }

            TokenType::Not => {
                let token = self.consume();
                let rhs = self.parse_primary()?;
                let expr_ty = ExprType::Unary {
                    op: UnaryOp::Not,
                    expr: Box::new(rhs),
                };
                Some(Expr {
                    ty: expr_ty,
                    file: token.file.clone(),
                    line: token.line,
                    col: token.col,
                })
            }
            TokenType::Sub => {
                let token = self.consume();
                let rhs = self.parse_primary()?;
                let expr_ty = ExprType::Unary {
                    op: UnaryOp::Neg,
                    expr: Box::new(rhs),
                };
                Some(Expr {
                    ty: expr_ty,
                    file: token.file.clone(),
                    line: token.line,
                    col: token.col,
                })
            }

            TokenType::OpenScope => self.parse_init_array(),

            TokenType::CharValue => {
                let token = self.consume();
                let s: i64 = token.value.unwrap().parse().unwrap();
                let expr_ty = ExprType::Number(s);
                Some(Expr {
                    ty: expr_ty,
                    file: token.file.clone(),
                    line: token.line,
                    col: token.col,
                })
            }

            TokenType::SizeOf => {
                let token = self.consume();
                self.expect(TokenType::OpenParen);
                // Use your unified type parsing logic!
                let pre_ptr = self.parse_ptr();
                let base_ty = self.get_type()?;
                let mut ty = self.parse_generic_types(base_ty)?;
                let post_ptr = self.parse_ptr();

                ty = self.apply_ptr(ty, pre_ptr + post_ptr);
                ty = self.parse_array(ty);

                self.expect(TokenType::CloseParen);

                // Store the actual Type instead of a Stmt
                let expr_ty = ExprType::SizeOf { ty };

                return Some(Expr {
                    ty: expr_ty,
                    file: token.file.clone(),
                    line: token.line,
                    col: token.col,
                });
            }

            TokenType::String => {
                let token = self.consume();
                let str_value = token.value.unwrap();
                let expr_ty = ExprType::String { str: str_value };
                return Some(Expr {
                    ty: expr_ty,
                    file: token.file.clone(),
                    line: token.line,
                    col: token.col,
                });
            }

            TokenType::OpenParen => {
                self.expect(TokenType::OpenParen);
                let expr = self.parse_expr()?;
                self.expect(TokenType::CloseParen);
                return Some(expr);
            }

            _ => {
                let token = self.consume();
                self.error_at(
                    format!("Unexpected token: {:?}", token.token,),
                    token.line,
                    token.col,
                );
                Some(Expr {
                    ty: ExprType::Number(0),
                    file: token.file.clone(),
                    line: token.line,
                    col: token.col,
                })
            }
        }
    }

    fn expr_to_ident(&self, expr: Expr) -> String {
        match expr.ty {
            ExprType::Variable(var) => var,
            _ => self::panic!("in expr_to_ident got wrong type of expr: {:?}", expr),
        }
    }

    fn precedence(op: &BinOp) -> u8 {
        match op {
            BinOp::Mul | BinOp::Div | BinOp::Mod => 10,
            BinOp::Add | BinOp::Sub => 8,
            BinOp::ShiftLeft | BinOp::ShiftRight => 7,
            BinOp::BitAnd => 6,
            BinOp::BitXor => 5,
            BinOp::BitOr => 4,
            BinOp::Lt | BinOp::Lte | BinOp::Gt | BinOp::Gte => 3,
            BinOp::Eq | BinOp::Neq => 3,
            BinOp::And => 2,
            BinOp::Or => 1,
        }
    }

    fn parse_unary(&mut self) -> Option<Expr> {
        match self.peek(0).token {
            TokenType::Mul => {
                self.consume();
                let rhs = self.parse_unary()?;
                let expr_ty = ExprType::Deref(Box::new(rhs));
                Some(Expr {
                    ty: expr_ty,
                    file: self.current_file.clone(),
                    line: self.line,
                    col: self.col,
                })
            }
            TokenType::Address => {
                self.consume();
                let rhs = self.parse_unary()?;
                let expr_ty = ExprType::Unary {
                    op: UnaryOp::GetAddr,
                    expr: Box::new(rhs),
                };
                return Some(Expr {
                    ty: expr_ty,
                    file: self.current_file.clone(),
                    line: self.line,
                    col: self.col,
                });
            }
            TokenType::Sub => {
                self.consume();
                let rhs = self.parse_unary()?;
                let expr_ty = ExprType::Unary {
                    op: UnaryOp::Neg,
                    expr: Box::new(rhs),
                };
                Some(Expr {
                    ty: expr_ty,
                    file: self.current_file.clone(),
                    line: self.line,
                    col: self.col,
                })
            }
            TokenType::Not => {
                self.consume();
                let rhs = self.parse_unary()?;
                let expr_ty = ExprType::Unary {
                    op: UnaryOp::Not,
                    expr: Box::new(rhs),
                };
                return Some(Expr {
                    ty: expr_ty,
                    file: self.current_file.clone(),
                    line: self.line,
                    col: self.col,
                });
            }
            _ => self.parse_postfix_chain(),
        }
    }

    fn is_generic_call_lookahead(&mut self) -> bool {
        let mut i = 1;
        let mut depth = 1;

        loop {
            let kind = self.peek(i).token;
            match kind {
                TokenType::Less => depth += 1, // Handle nested generics like Map<String, Vector<u8>>
                TokenType::More => {
                    depth -= 1;
                    if depth == 0 {
                        // We found the closing '>'.
                        // If the very next token is '(', it's definitely a generic function call!
                        // (We also check for '{' in case you support generic struct initialization)
                        let next_kind = self.peek(i + 1).token;
                        return next_kind == TokenType::OpenParen
                            || next_kind == TokenType::OpenScope;
                    }
                }
                // If we hit a semicolon or EOF before finding '>', it's just a math expression
                TokenType::Semi => return false,
                _ => {}
            }
            i += 1;
        }
    }

    fn parse_struct_member(&mut self, expr: Expr) -> Expr {
        let name = self.consume().value.unwrap();

        Expr {
            ty: ExprType::StructMember {
                base: Box::new(expr),
                name,
            },
            file: self.current_file.clone(),
            line: self.line,
            col: self.col,
        }
    }

    fn parse_module_call(&mut self, expr: Expr) -> Expr {
        let mut names = match &expr.ty {
            ExprType::Variable(name) => vec![name.clone()],
            _ => panic!("expected a variable module name, got: {:?}", expr.ty),
        };

        self.expect(TokenType::BitNot);
        names.push(self.consume().value.unwrap());

        while self.peek(0).token == TokenType::Dot {
            self.expect(TokenType::Dot);
            names.push(self.consume().value.unwrap());
        }

        let name = transform_module_name(&names);
        let mut new_expr = expr;
        new_expr.ty = ExprType::Variable(name);
        return new_expr;
    }

    fn parse_enum_expr_field(&mut self) -> Option<EnumExprField> {
        let name = self.consume().value.unwrap();
        self.expect(TokenType::Colon);
        let expr = self.parse_expr()?;
        if self.peek(0).token == TokenType::Coma {
            self.expect(TokenType::Coma);
        }
        return Some(EnumExprField { name, expr });
    }

    pub fn parse_postfix_chain(&mut self) -> Option<Expr> {
        let mut expr: Expr = self.parse_primary()?;
        loop {
            match self.peek(0).token {
                TokenType::OpenBracket => {
                    self.consume();
                    let index = self.parse_expr()?;
                    self.expect(TokenType::CloseBracket);
                    let expr_ty = ExprType::Index {
                        base: Box::new(expr),
                        index: Box::new(index),
                    };
                    expr = Expr {
                        ty: expr_ty,
                        file: self.current_file.clone(),
                        line: self.line,
                        col: self.col,
                    };
                }

                TokenType::As => {
                    self.consume();
                    let pre_ptr = self.parse_ptr();
                    let ty = self.get_type()?;
                    let post_ptr = self.parse_ptr();
                    let ty = self.apply_ptr(ty, pre_ptr + post_ptr);
                    let expr_ty = ExprType::Cast {
                        expr: Box::new(expr),
                        ty,
                    };
                    expr = Expr {
                        ty: expr_ty,
                        file: self.current_file.clone(),
                        line: self.line,
                        col: self.col,
                    };
                }
                TokenType::BitNot => {
                    expr = self.parse_module_call(expr);
                }

                TokenType::Dot => {
                    self.expect(TokenType::Dot);

                    let name = self.consume().value.expect("expected a name after '.'");

                    if self.peek(0).token == TokenType::BitNot {
                        // Previous expression is the first argument to the module call.
                        self.expect(TokenType::BitNot);

                        let module_name = name;
                        let func_name = self
                            .consume()
                            .value
                            .expect("expected a function name after '~'");

                        let name_ident = Expr {
                            ty: ExprType::Variable(gen_module_func_name(&module_name, &func_name)),
                            file: self.current_file.clone(),
                            line: self.line,
                            col: self.col,
                        };

                        let call = if self.peek(0).token == TokenType::Less {
                            self.parse_generic_call(name_ident)?
                        } else {
                            self.parse_call(name_ident)?
                        };

                        match call.ty {
                            ExprType::Call {
                                name,
                                generics,
                                mut args,
                            } => {
                                args.insert(0, expr);

                                expr = Expr {
                                    ty: ExprType::Call {
                                        name,
                                        generics,
                                        args,
                                    },
                                    file: self.current_file.clone(),
                                    line: self.line,
                                    col: self.col,
                                };
                            }
                            _ => unreachable!("expected a function call"),
                        }
                    } else if self.peek(0).token == TokenType::OpenParen
                        || self.peek(0).token == TokenType::Less
                    {
                        // vec.push(5) or vec.push<u32>(5)
                        let name_ident = Expr {
                            ty: ExprType::Variable(name),
                            file: self.current_file.clone(),
                            line: self.line,
                            col: self.col,
                        };

                        let call = if self.peek(0).token == TokenType::Less {
                            self.parse_generic_call(name_ident)?
                        } else {
                            self.parse_call(name_ident)?
                        };

                        match call.ty {
                            ExprType::Call {
                                name,
                                generics,
                                args,
                            } => {
                                let mut new_args = args;
                                new_args.insert(0, expr);

                                expr = Expr {
                                    ty: ExprType::Call {
                                        name,
                                        generics,
                                        args: new_args,
                                    },
                                    file: self.current_file.clone(),
                                    line: self.line,
                                    col: self.col,
                                };
                            }
                            _ => unreachable!("expected a function call"),
                        }
                    } else {
                        // vec.data or vec.data.length
                        expr = Expr {
                            ty: ExprType::StructMember {
                                base: Box::new(expr),
                                name,
                            },
                            file: self.current_file.clone(),
                            line: self.line,
                            col: self.col,
                        };
                    }
                }

                TokenType::Access => {
                    self.consume();
                    let name = self.consume().value.unwrap();
                    let base = Box::new(Expr {
                        ty: ExprType::Deref(Box::new(expr)),
                        file: self.current_file.clone(),
                        line: self.line,
                        col: self.col,
                    });
                    let expr_ty = ExprType::StructMember { base, name: name };
                    expr = Expr {
                        ty: expr_ty,
                        file: self.current_file.clone(),
                        line: self.line,
                        col: self.col,
                    };
                }

                TokenType::Less => {
                    if self.is_generic_call_lookahead() {
                        expr = self.parse_generic_call(expr)?;
                    } else {
                        break;
                    }
                }

                TokenType::OpenParen => {
                    expr = self.parse_call(expr)?;
                }

                TokenType::Colon => {
                    self.expect(TokenType::Colon);
                    self.expect(TokenType::Colon);
                    let value_name = self.consume().value.unwrap();
                    let mut variant_expr: Vec<EnumExprField> = Vec::new();
                    if self.peek(0).token == TokenType::OpenParen {
                        self.expect(TokenType::OpenParen);
                        while self.peek(0).token != TokenType::CloseParen {
                            let res = self.parse_enum_expr_field()?;
                            variant_expr.push(res);
                        }
                        self.expect(TokenType::CloseParen);
                    }
                    match &expr.ty {
                        ExprType::Variable(name) => {
                            let expr_ty = ExprType::GetEnum {
                                base: name.to_string(),
                                variant: value_name,
                                value: variant_expr,
                            };

                            expr = Expr {
                                ty: expr_ty,
                                file: self.current_file.clone(),
                                line: self.line,
                                col: self.col,
                            }
                        }
                        _ => self::panic!("really strange syntax error"),
                    }
                }
                _ => break,
            }
        }
        Some(expr)
    }

    fn parse_generic_call(&mut self, expr: Expr) -> Option<Expr> {
        let mut generics = Vec::new();
        self.expect(TokenType::Less);
        while self.peek(0).token != TokenType::More {
            let bef_ptr = self.parse_ptr();
            let ty = self.get_type()?;
            let aft_ptr = self.parse_ptr();
            let ty = self.parse_array(ty);
            let ty = self.apply_ptr(ty, bef_ptr + aft_ptr);
            generics.push(ty);
            if self.peek(0).token == TokenType::Coma {
                self.consume();
            }
        }
        self.expect(TokenType::More);
        let mut args: Vec<Expr> = Vec::new();
        if self.peek(0).token != TokenType::CloseParen {
            self.expect(TokenType::OpenParen);
            loop {
                if self.peek(0).token == TokenType::CloseParen {
                    break;
                }
                args.push(self.parse_expr()?);
                if self.peek(0).token == TokenType::Coma {
                    self.expect(TokenType::Coma);
                }
            }
        }
        self.expect(TokenType::CloseParen);
        let expr_ty = ExprType::Call {
            generics,
            name: self.expr_to_ident(expr),
            args,
        };
        Some(Expr {
            ty: expr_ty,
            file: self.current_file.clone(),
            line: self.line,
            col: self.col,
        })
    }

    fn parse_call(&mut self, expr: Expr) -> Option<Expr> {
        self.expect(TokenType::OpenParen);
        let mut args: Vec<Expr> = Vec::new();
        if self.peek(0).token != TokenType::CloseParen {
            loop {
                args.push(self.parse_expr()?);
                if self.peek(0).token == TokenType::CloseParen {
                    break;
                }
                if self.peek(0).token != TokenType::Coma
                    && self.peek(0).token != TokenType::CloseParen
                {
                    // if user forgot to close ) in call we give him better error
                    // than a missing coma
                    break;
                } else {
                    self.expect(TokenType::Coma);
                }
            }
        }
        self.expect(TokenType::CloseParen);
        let expr_ty = ExprType::Call {
            generics: Vec::new(),
            name: self.expr_to_ident(expr),
            args,
        };
        Some(Expr {
            ty: expr_ty,
            file: self.current_file.clone(),
            line: self.line,
            col: self.col,
        })
    }

    fn is_bin_op(ty: TokenType) -> Option<BinOp> {
        match ty {
            TokenType::Add => Some(BinOp::Add),
            TokenType::Sub => Some(BinOp::Sub),
            TokenType::Mul => Some(BinOp::Mul),
            TokenType::Div => Some(BinOp::Div),
            TokenType::AsertEq => Some(BinOp::Eq),
            TokenType::NotEq => Some(BinOp::Neq),
            TokenType::LessThan => Some(BinOp::Lte),
            TokenType::Less => Some(BinOp::Lt),
            TokenType::More => Some(BinOp::Gt),
            TokenType::MoreThan => Some(BinOp::Gte),
            TokenType::And => Some(BinOp::And),
            TokenType::Or => Some(BinOp::Or),
            TokenType::Remainder => Some(BinOp::Mod),
            TokenType::Address => Some(BinOp::BitAnd),
            TokenType::BitOr => Some(BinOp::BitOr),
            TokenType::BitXor => Some(BinOp::BitXor),
            TokenType::LeftShift => Some(BinOp::ShiftLeft),
            TokenType::RightShift => Some(BinOp::ShiftRight),
            _ => None,
        }
    }

    pub fn parse_expr(&mut self) -> Option<Expr> {
        self.parse_binary(0)
    }

    fn parse_binary(&mut self, min_prec: u8) -> Option<Expr> {
        let mut left = self.parse_unary()?;
        if self.peek(0).token == TokenType::Semi {
            return Some(left);
        }
        loop {
            let op = match Parser::is_bin_op(self.peek(0).token) {
                Some(op) => op,
                None => break,
            };

            let prec = Parser::precedence(&op);

            if prec < min_prec {
                break;
            }

            self.consume();

            let right = self.parse_binary(prec + 1)?;

            let bin_ty = ExprType::Binary {
                op,
                left: Box::new(left),
                right: Box::new(right),
            };

            left = Expr {
                ty: bin_ty,
                file: self.current_file.clone(),
                line: self.line,
                col: self.col,
            };
        }

        Some(left)
    }
}
