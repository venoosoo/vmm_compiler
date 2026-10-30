use crate::Ir::stmt::{Declaration, StmtType};

use super::*;

impl<'a> Parser<'a> {
    pub fn parse_args(&mut self) -> Option<Vec<Declaration>> {
        let mut res: Vec<Declaration> = Vec::new();
        self.expect(TokenType::OpenParen);
        while self.peek(0).token != TokenType::CloseParen {
            let arg = match self.parse_declaration() {
                Some(val) => val,
                None => return Some(res),
            };
            match arg.ty {
                StmtType::Declaration(decl) => {
                    res.push(decl);
                }
                _ => self.error_at("strange args".to_string(), self.line, self.col),
            }
            if self.peek(0).token == TokenType::Coma {
                self.expect(TokenType::Coma);
            }
        }
        self.expect(TokenType::CloseParen);
        Some(res)
    }

    pub fn parse_func_init(&mut self) -> Option<Stmt> {
        self.expect(TokenType::Func);
        let name = self.consume().value.unwrap();
        let generics = self.parse_generic();
        let args = self.parse_args()?;
        let mut ret_type = Type::Primitive(TokenType::Void);
        if self.peek(0).token == TokenType::Access {
            self.expect(TokenType::Access);
            let pre_ptr = self.parse_ptr();
            let ty = self.get_type()?;
            let ty = self.parse_generic_types(ty)?;
            let ty = self.parse_array(ty);
            let post_ptr = self.parse_ptr();
            let ty = self.apply_ptr(ty, pre_ptr + post_ptr);

            ret_type = ty;
        }
        if self.peek(0).token != TokenType::OpenScope {
            self.error_at(
                format!(
                    "Unexpected token at function init: {:?}",
                    self.peek(0).token
                ),
                self.line,
                self.col,
            );
            self.consume();
        }
        let data = Box::new(
            self.parse_stmt()
                .expect(&format!("the func: {} is empty", name)),
        );
        if generics.len() > 0 {
            return Some(self.type_to_stmt(StmtType::GenericInitFunc {
                name,
                generic_types: generics,
                args,
                ret_type,
                data,
            }));
        } else {
            return Some(self.type_to_stmt(StmtType::InitFunc {
                generic_types: HashMap::new(),
                name,
                args,
                ret_type,
                data,
            }));
        }
    }
}
