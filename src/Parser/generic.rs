use crate::{Ir::expr::{Expr, ExprType}, shared::type_name};

use super::*;



impl<'a> Parser<'a> {
    pub fn parse_generic(&mut self) -> Vec<String> {
        let mut generic = Vec::new();
        if self.peek(0).token == TokenType::Less {
            self.expect(TokenType::Less);
            while self.peek(0).token != TokenType::More {
                let generic_ty_name = {
                    let token = self.consume();
                    if let Some(token_name) = token.value {
                        token_name
                    } else {
                        type_name(&Type::Primitive(token.token))
                    }
                };
                if self.peek(0).token == TokenType::Coma {
                    self.consume();
                }
                self.types.insert(generic_ty_name.clone());
                self.generic.insert(generic_ty_name.clone());
                generic.push(generic_ty_name);
            }
            self.expect(TokenType::More);
        }
        generic
    }
    pub fn parse_generic_types(&mut self, ty: Type) -> Option<Type> {
        if self.peek(0).token == TokenType::Less {
            self.expect(TokenType::Less);
            let mut res = Vec::new();
            while self.peek(0).token != TokenType::More {
                let pre_ptr = self.parse_ptr();
                let ty = self.get_type()?;
                let post_ptr = self.parse_ptr();
                let ty = self.parse_array(ty);
                let ty = self.apply_ptr(ty, pre_ptr + post_ptr);
                res.push(ty);
                if self.peek(0).token == TokenType::Coma {
                    self.expect(TokenType::Coma);
                }
            }
            self.expect(TokenType::More);
            return Some(Type::GenericInst(type_name(&ty), res));
        } else {
            return Some(ty);
        }
    }
    pub fn parse_generic_call(&mut self, expr: Expr) -> Option<Expr> {
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
    pub fn is_generic_call_lookahead(&mut self) -> bool {
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
                        // If the very next token is '(', it's a generic function call
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
}