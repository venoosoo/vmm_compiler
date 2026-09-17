use crate::Ir::stmt::{Declaration, StmtType, StructFunctionData};

use super::*;

impl<'a> Parser<'a> {
    pub fn parse_args(&mut self, allow_self: bool) -> (bool, Vec<Declaration>) {
        let mut res: Vec<Declaration> = Vec::new();
        self.expect(TokenType::OpenParen);
        let mut is_self = false;
        if self.peek(0).token == TokenType::SelfKeyword {
            if !allow_self {
                self.error_at(
                    "'self' can only be used in struct methods".to_string(),
                    self.peek(0).line,
                    self.peek(0).col,
                );
            } else {
                is_self = true;
                self.consume();
                if self.peek(0).token == TokenType::Coma {
                    self.consume();
                }
            }
        }
        while self.peek(0).token != TokenType::CloseParen {
            let arg = self.parse_declaration().unwrap();
            match arg.ty {
                StmtType::Declaration(decl) => {
                    res.push(decl);
                }
                _ => self::panic!("wrong args"),
            }
            if self.peek(0).token == TokenType::Coma {
                self.consume();
            }
        }
        self.consume();
        (is_self, res)
    }

    pub fn parse_func_init(
        &mut self,
        allow_self: bool,
        struct_name: Option<String>,
    ) -> Option<Stmt> {
        self.expect(TokenType::Func); //keyword
        let name = self.consume().value.unwrap();
        let generics = self.parse_generic();
        let (is_self, args) = self.parse_args(allow_self);
        let mut ret_type = Type::Primitive(TokenType::Void);
        if self.peek(0).token == TokenType::Access {
            self.expect(TokenType::Access);
            let pre_ptr = self.parse_ptr();
            let ty = self.get_type();
            let ty = self.parse_generic_types(ty);
            let ty = self.parse_array(ty);
            let post_ptr = self.parse_ptr();
            let ty = self.apply_ptr(ty, pre_ptr + post_ptr);

            ret_type = ty;
        }
        let data = Box::new(
            self.parse_stmt()
                .expect(&format!("the func: {} is empty", name)),
        );
        let struct_data: Option<StructFunctionData> = {
            if !allow_self {
                None
            } else {
                Some(StructFunctionData {
                    is_self,
                    is_struct: allow_self,
                    struct_name: struct_name
                        .expect("the struct function havent provided a struct name"),
                })
            }
        };
        if generics.len() > 0 {
            return Some(self.type_to_stmt(StmtType::GenericInitFunc {
                name,
                generic_types: generics,
                args,
                struct_data,
                ret_type,
                data,
            }));
        } else {
            return Some(self.type_to_stmt(StmtType::InitFunc {
                generic_types: HashMap::new(),
                name,
                args,
                struct_data,
                ret_type,
                data,
            }));
        }
    }
}
