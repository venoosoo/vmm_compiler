use core::panic;
use std::backtrace;
use std::fs::File;
use std::io::Read;

use super::*;
use crate::Ir::expr::{Expr, ExprType};
use crate::Ir::stmt::*;
use crate::shared::type_name;
use crate::tokenizer;

impl<'a> Parser<'a> {
    pub fn parse_stmt(&mut self) -> Option<Stmt> {
        let token = self.peek(0).clone();
        self.line = token.line;
        self.col = token.col;
        match token.token {
            TokenType::If => return self.parse_if(),
            TokenType::While => return self.parse_while(),
            TokenType::For => return self.parse_for(),
            TokenType::OpenScope => return self.parse_scope(),
            TokenType::Return => return self.parse_ret(),
            TokenType::Asm => return self.parse_asm_stmt(),
            TokenType::Func => return self.parse_func_init(),
            TokenType::Struct => return self.parse_struct_init(),
            TokenType::Global => return self.parse_global(),
            TokenType::Enum => return self.parse_enum(),
            TokenType::Match => return self.parse_match(),
            TokenType::ExternFn => return self.parse_extern(),
            TokenType::Import => {
                return {
                    self.parse_import();

                    // the import shouldnt return any stmt
                    // but we need to return something to satisfy the func needs
                    Some(self.type_to_stmt(StmtType::Block(Vec::new())))
                };
            }
            ty if self.is_type(&token) => {
                let stmt = self.parse_declaration();
                self.expect(TokenType::Semi);
                return stmt;
            }
            _ => {
                if self.check_assignment_start() {
                    return self.parse_assignment();
                }
                return self.parse_expr_stmt();
            }
        };
    }

    fn parse_extern(&mut self) -> Option<Stmt> {
        self.expect(TokenType::ExternFn);
        self.consume(); //keyword
        let name = self.consume().value.unwrap();
        let generics = self.parse_generic();
        let args = self.parse_args();
        let mut ret_type = Type::Primitive(TokenType::Void);
        if self.peek(0).token == TokenType::Access {
            self.consume();
            let pre_ptr = self.parse_ptr();
            let ty = self.get_type();
            let ty = self.parse_generic_types(ty);
            let ty = self.parse_array(ty);
            let post_ptr = self.parse_ptr();
            let ty = self.apply_ptr(ty, pre_ptr + post_ptr);

            ret_type = ty;
        }
        let data = Box::new(self.type_to_stmt(StmtType::InitFunc {
            name,
            generic_types: HashMap::new(),
            args,
            ret_type,
            data: Box::new(self.type_to_stmt(StmtType::Block(Vec::new()))),
        }));
        return Some(self.type_to_stmt(StmtType::ExternFn(data)));
    }

    fn parse_match_field(&mut self) -> MatchLeftValue {
        let base = self.peek(0).value.clone().unwrap();
        if base == "_" {
            self.consume();
            return MatchLeftValue::Enum {
                base,
                value: "_".to_string(),
                args: Vec::new(),
            };
        }
        if self.peek(1).token == TokenType::Colon {
            self.consume();
            self.expect(TokenType::Colon);
            self.expect(TokenType::Colon);
            let value = self.consume().value.unwrap();
            let mut args: Vec<String> = Vec::new();
            if self.peek(0).token == TokenType::OpenParen {
                self.expect(TokenType::OpenParen);
                while self.peek(0).token != TokenType::CloseParen {
                    let name = self.consume().value.unwrap();
                    args.push(name);
                    if self.peek(0).token == TokenType::Coma {
                        self.consume();
                    }
                }
                self.expect(TokenType::CloseParen);
            }
            return MatchLeftValue::Enum { base, value, args };
        } else {
            let left = self.parse_expr();
            return MatchLeftValue::Expr { expr: left };
        }
    }

    fn parse_match(&mut self) -> Option<Stmt> {
        self.consume();
        let expr = self.parse_expr();
        self.expect(TokenType::OpenScope);
        let mut variants: Vec<MatchField> = Vec::new();
        while self.peek(0).token != TokenType::CloseScope {
            let left = self.parse_match_field();
            self.expect(TokenType::Eq);
            self.expect(TokenType::More);
            let stmt = self.parse_stmt().expect("in match expected stmt");
            let res = MatchField { left, right: stmt };
            variants.push(res);
            self.expect(TokenType::Coma);
        }
        self.expect(TokenType::CloseScope);
        return Some(self.type_to_stmt(StmtType::Match { expr, variants }));
    }

    fn parse_enum_field(&mut self, tag: usize) -> EnumVariant {
        let name = self.consume().value.unwrap();
        let mut args: Vec<StructField> = Vec::new();
        if self.peek(0).token == TokenType::Coma {
            return EnumVariant {
                name,
                args,
                tag,
                size: tag,
            };
        }
        self.expect(TokenType::OpenScope);
        let mut offset = 0;
        while self.peek(0).token != TokenType::CloseScope {
            let ty = self.get_type();
            let index = self.parse_ptr();
            let name = self.consume().value.unwrap();
            let ty = self.parse_array(ty);
            let ty = self.apply_ptr(ty, index);
            self.expect(TokenType::Semi);
            args.push(StructField {
                name,
                offset,
                ty: ty.clone(),
            });
            offset += self.size_of(&ty);
        }
        self.expect(TokenType::CloseScope);
        return EnumVariant {
            name,
            args,
            tag,
            size: tag + offset,
        };
    }

    pub fn parse_generic(&mut self) -> Vec<String> {
        let mut generic = Vec::new();
        if self.peek(0).token == TokenType::Less {
            self.consume();
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
        }
        self.expect(TokenType::More);
        generic
    }

    pub fn type_to_stmt(&self, stmt: StmtType) -> Stmt {
        Stmt {
            ty: stmt,
            line: self.line,
            file: self.current_file.clone(),
        }
    }

    fn parse_enum(&mut self) -> Option<Stmt> {
        self.consume();
        let name = self.consume().value.unwrap();
        let generic = self.parse_generic();
        self.expect(TokenType::OpenScope);
        let mut variants: HashMap<String, EnumVariant> = HashMap::new();
        let mut tag = 0;
        let mut max_size = 8; // the min would be the tag_size
        while self.peek(0).token != TokenType::CloseScope {
            let res = self.parse_enum_field(tag);
            tag += 1;
            if res.size > max_size {
                max_size = res.size
            };
            self.expect(TokenType::Coma);
            variants.insert(res.name.clone(), res);
        }
        self.expect(TokenType::CloseScope);
        self.types.insert(name.clone());
        self.enums_table.insert(
            name.clone(),
            EnumData {
                generic_type: generic.clone(),
                name: name.clone(),
                variants: variants.clone(),
                size: max_size,
            },
        );
        return Some(self.type_to_stmt(StmtType::InitEnum {
            name,
            variants,
            generic_types: generic,
        }));
    }

    fn parse_global(&mut self) -> Option<Stmt> {
        self.consume();
        let stmt = self.parse_declaration().unwrap();
        self.expect(TokenType::Semi);
        return Some(self.type_to_stmt(StmtType::GlobalDecl(Box::new(stmt))));
    }

    pub fn is_type(&self, token: &Token) -> bool {
        match token.token {
            TokenType::IntType => true,
            TokenType::CharType => true,
            TokenType::LongType => true,
            TokenType::ShortType => true,
            TokenType::Void => true,
            TokenType::Var => {
                if let Some(name) = &token.value {
                    self.types.contains(name)
                } else {
                    false
                }
            }
            _ => false,
        }
    }

    pub fn apply_ptr(&mut self, ty: Type, index: u32) -> Type {
        let mut ty = ty.clone();
        for i in 0..index {
            ty = Type::Pointer(Box::new(ty));
        }
        return ty;
    }

    pub fn parse_ptr(&mut self) -> u32 {
        let mut index = 0;
        while self.m_index < self.m_tokens.len() && self.peek(0).token == TokenType::Mul {
            index += 1;
            self.consume();
        }
        index
    }
    pub fn parse_array(&mut self, mut ty: Type) -> Type {
        while self.m_index < self.m_tokens.len() && self.peek(0).token == TokenType::OpenBracket {
            self.consume();
            let size_token = self.consume();
            let mut size = 0;
            if size_token.token != TokenType::CloseBracket {
                size = size_token.value.unwrap().parse::<usize>().unwrap();
                self.expect(TokenType::CloseBracket);
            }
            ty = Type::Array(Box::new(ty), size);
        }
        ty
    }

    pub fn get_type(&mut self) -> Type {
        let token = self.consume();
        if token.token == TokenType::Var {
            let name = self.types.get(&token.value.unwrap()).unwrap();
            if self.struct_table.get(name).is_some() {
                return Type::Struct(name.to_string());
            } else if self.enums_table.get(name).is_some() {
                return Type::Enum(name.to_string(), None);
            } else if self.generic.get(name).is_some() {
                return Type::GenericType(name.clone());
            } else {
                return Type::Unknown;
            }
        } else {
            return Type::Primitive(token.token);
        };
    }

    pub fn parse_generic_types(&mut self, ty: Type) -> Type {
        if self.peek(0).token == TokenType::Less {
            self.expect(TokenType::Less);
            let mut res = Vec::new();
            while self.peek(0).token != TokenType::More {
                let pre_ptr = self.parse_ptr();
                let ty = self.get_type();
                let post_ptr = self.parse_ptr();
                let ty = self.parse_array(ty);
                let ty = self.apply_ptr(ty, pre_ptr + post_ptr);
                res.push(ty);
                if self.peek(0).token == TokenType::Coma {
                    self.expect(TokenType::Coma);
                }
            }
            self.expect(TokenType::More);
            return Type::GenericInst(type_name(&ty), res);
        } else {
            return ty;
        }
    }

    pub fn parse_declaration(&mut self) -> Option<Stmt> {
        let pre_ptr = self.parse_ptr();
        let ty = self.get_type();
        let ty = self.parse_generic_types(ty);
        let post_ptr = self.parse_ptr();
        let var_name = self.consume();
        let mut ty = self.parse_array(ty);
        ty = self.apply_ptr(ty, pre_ptr + post_ptr);
        let mut expr: Option<Expr> = None;
        if self.peek(0).token == TokenType::Eq {
            self.consume();
            let initializer = self.parse_expr();
            if let (Type::Array(inner, 0), ExprType::String { str: s }) = (&ty, &initializer.ty) {
                if **inner == Type::Primitive(TokenType::CharType) {
                    ty = Type::Array(Box::new(Type::Primitive(TokenType::CharType)), s.len() + 1);
                }
            }
            expr = Some(initializer);
        }
        return Some(self.type_to_stmt(StmtType::Declaration(Declaration {
            name: var_name.value.unwrap(),
            ty: ty,
            initializer: expr,
        })));
    }

    fn parse_import(&mut self) {
        self.consume();

        let saved = self.current_file.clone();

        let file_name = self.consume().value.unwrap();
        let full_path = self
            .base_dir
            .join(&file_name)
            .canonicalize()
            .expect(&format!("Cannot find import: {}", file_name));
        let canonical_str = full_path.to_str().unwrap().to_string();
        if self.imported_files.contains(&canonical_str) {
            return;
        }
        self.current_file = canonical_str.clone();
        self.imported_files.insert(canonical_str);
        let mut file = File::open(&full_path).expect(&format!("Cannot find import: {}", file_name));

        let mut content = String::new();
        file.read_to_string(&mut content).unwrap();

        let mut tokenizer = tokenizer::Tokenizer::new(content);
        tokenizer.tokenize();

        let mut parser = Parser::new(
            tokenizer.m_res,
            self.base_dir.clone(),
            self.imported_files,
            self.current_file.clone(),
        );
        parser.base_dir = full_path.parent().unwrap().to_path_buf();
        let imported_stmts = parser.parse();
        self.types.extend(parser.types);
        self.struct_table.extend(parser.struct_table);
        self.enums_table.extend(parser.enums_table);

        for stmt in imported_stmts {
            self.expressions.push(stmt);
        }
        self.current_file = full_path.join(saved).to_string_lossy().to_string();
    }

    fn parse_struct_init(&mut self) -> Option<Stmt> {
        self.consume(); // 'struct'

        let struct_name = self.consume().value.unwrap();
        let generic = self.parse_generic();
        self.expect(TokenType::OpenScope);

        let mut fields: Vec<StructField> = Vec::new();
        let mut offset: usize = 0;

        while self.peek(0).token != TokenType::CloseScope {
            let base_token = self.consume();

            let mut ty = if self.is_type(&base_token) && base_token.token != TokenType::Var {
                Type::Primitive(base_token.token)
            } else if let Some(res) = self.get_custom_type(&base_token.value.clone().unwrap()) {
                res
            } else {
                panic!("Expected type in struct field");
            };

            let index = self.parse_ptr();
            let field_name = self.consume().value.unwrap();

            ty = self.parse_array(ty);
            ty = self.apply_ptr(ty, index);

            self.expect(TokenType::Semi);

            let field_size = self.size_of(&ty);

            fields.push(StructField {
                name: field_name,
                ty: ty.clone(),
                offset,
            });

            offset += field_size;
        }

        self.expect(TokenType::CloseScope);

        let struct_size = offset;

        let def = StructDef {
            name: struct_name.clone(),
            generic_type: generic,
            fields,
            size: struct_size,
        };

        // register struct in type table
        self.types.insert(struct_name.clone());
        self.struct_table.insert(struct_name.clone(), def.clone());
        Some(self.type_to_stmt(StmtType::InitStruct(def)))
    }

    fn check_assignment_start(&self) -> bool {
        let mut i = 0;

        // allow leading *
        while self.peek(i).token == TokenType::Mul {
            i += 1;
        }

        // must start with identifier
        if self.peek(i).token != TokenType::Var {
            return false;
        }

        i += 1;

        loop {
            match self.peek(i).token {
                TokenType::Dot => {
                    i += 1;
                    if self.peek(i).token != TokenType::Var {
                        return false;
                    }
                    i += 1;
                }
                TokenType::Access => {
                    i += 1;
                    if self.peek(i).token != TokenType::Var {
                        return false;
                    }
                    i += 1;
                }

                TokenType::OpenBracket => {
                    i += 1;

                    // skip until closing bracket
                    let mut depth = 1;
                    while depth > 0 {
                        match self.peek(i).token {
                            TokenType::OpenBracket => depth += 1,
                            TokenType::CloseBracket => depth -= 1,
                            _ => {}
                        }
                        i += 1;
                    }
                }

                TokenType::Eq => {
                    return true;
                }

                _ => {
                    return false;
                }
            }
        }
    }

    fn parse_assignment_no_semi(&mut self) -> Option<Stmt> {
        let mut pointer_depth = 0;
        while self.peek(0).token == TokenType::Mul {
            self.consume();
            pointer_depth += 1;
        }

        let var_name = self.consume().value.unwrap();
        let mut lvalue = LValue::Variable(var_name);

        loop {
            match self.peek(0).token {
                TokenType::Dot => {
                    self.consume();
                    let field = self.consume().value.unwrap();
                    lvalue = LValue::Field {
                        base: Box::new(lvalue),
                        name: field,
                    };
                }
                TokenType::Access => {
                    self.consume();
                    let field = self.consume().value.unwrap();
                    lvalue = LValue::Field {
                        base: Box::new(LValue::Deref(Box::new(lvalue))),
                        name: field,
                    };
                }

                TokenType::OpenBracket => {
                    self.consume();
                    let index = self.parse_expr();
                    self.expect(TokenType::CloseBracket);

                    lvalue = LValue::Index {
                        base: Box::new(lvalue),
                        index: Box::new(index),
                    };
                }

                _ => break,
            }
        }

        for _ in 0..pointer_depth {
            lvalue = LValue::Deref(Box::new(lvalue));
        }
        self.expect(TokenType::Eq);

        let value = self.parse_expr();

        Some(self.type_to_stmt(StmtType::Assignment {
            target: lvalue,
            value,
        }))
    }

    fn parse_assignment(&mut self) -> Option<Stmt> {
        let res = self.parse_assignment_no_semi();
        self.expect(TokenType::Semi);
        return res;
    }

    fn parse_scope(&mut self) -> Option<Stmt> {
        self.consume();
        let mut stmts: Vec<Stmt> = Vec::new();
        while self.peek(0).token != TokenType::CloseScope {
            let stmt = self.parse_stmt().unwrap();
            stmts.push(stmt);
        }
        self.consume();
        return Some(self.type_to_stmt(StmtType::Block(stmts)));
    }

    fn parse_if(&mut self) -> Option<Stmt> {
        self.consume();
        let condition = self.parse_expr();
        let if_block = Box::new(self.parse_stmt().unwrap()); // should be block
        let mut else_block: Option<Box<Stmt>> = None;
        if self.peek(0).token == TokenType::Else {
            self.consume();
            let else_data = Box::new(self.parse_stmt().unwrap());
            else_block = Some(else_data);
        }
        return Some(self.type_to_stmt(StmtType::If {
            condition,
            if_block,
            else_block,
        }));
    }

    fn parse_while(&mut self) -> Option<Stmt> {
        self.consume();
        let condition = self.parse_expr();
        let body = Box::new(self.parse_stmt().unwrap());
        return Some(self.type_to_stmt(StmtType::While { condition, body }));
    }

    fn parse_for(&mut self) -> Option<Stmt> {
        self.consume(); // the keyword itself
        self.consume(); // (

        let init = if self.is_type(&self.peek(0)) {
            Some(Box::new(self.parse_declaration().unwrap()))
        } else {
            None
        };
        self.expect(TokenType::Semi);
        let condition = if self.peek(0).token != TokenType::Semi {
            Some(self.parse_expr())
        } else {
            None
        };
        self.expect(TokenType::Semi);

        let update = if self.peek(0).token != TokenType::CloseParen {
            Some(Box::new(self.parse_assignment_no_semi().unwrap()))
        } else {
            None
        };

        self.consume(); // )
        let body = Box::new(self.parse_stmt().unwrap());
        return Some(self.type_to_stmt(StmtType::For {
            init,
            condition,
            update,
            body,
        }));
    }

    fn parse_asm_stmt(&mut self) -> Option<Stmt> {
        self.consume(); // the keyword itself
        let mut asm_code: Vec<String> = Vec::new();
        self.consume();
        while self.peek(0).token != TokenType::CloseScope {
            let str = self.consume();
            asm_code.push(str.value.unwrap());
        }
        self.consume();
        return Some(self.type_to_stmt(StmtType::AsmCode(asm_code)));
    }

    fn parse_ret(&mut self) -> Option<Stmt> {
        self.consume(); // the keyword itself
        let expr = if self.peek(0).token != TokenType::Semi {
            Some(self.parse_expr())
        } else {
            None
        };
        self.expect(TokenType::Semi);
        Some(self.type_to_stmt(StmtType::Return(expr)))
    }

    fn parse_expr_stmt(&mut self) -> Option<Stmt> {
        let expr = self.parse_expr();
        self.expect(TokenType::Semi);
        Some(self.type_to_stmt(StmtType::ExprStmt(expr)))
    }
}