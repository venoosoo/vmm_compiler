use core::panic;
use std::collections::{HashMap, HashSet};
use std::path::PathBuf;

use crate::Ir::sem_analysis::{Error, SemanticError};
use crate::tokenizer::{Token, TokenType};

use crate::Ir::stmt::{EnumData, Stmt, StmtType, StructDef, Type};
use std::cell::{Cell, RefCell};
pub mod expr;
pub mod function;
pub mod generic;
pub mod stmt;

pub struct Parser<'a> {
    m_tokens: Vec<Token>,
    m_index: usize,

    expressions: Vec<Stmt>,
    struct_table: HashMap<String, StructDef>,
    types: HashSet<String>,
    enums_table: HashMap<String, EnumData>,
    base_dir: PathBuf,
    current_file: String,
    source_cache: RefCell<HashMap<String, Vec<String>>>,
    had_error: Cell<bool>,
    line: usize,
    col: usize,
    generic: HashSet<String>,
    imported_files: &'a mut HashSet<String>,
}

pub struct Program(Vec<Stmt>);

impl std::fmt::Display for Program {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        for (i, expr) in self.0.iter().enumerate() {
            writeln!(f, "[{}] {:?}", i, expr)?;
        }
        Ok(())
    }
}

impl<'a> Parser<'a> {
    pub fn new(
        m_tokens: Vec<Token>,
        base_dir: PathBuf,
        imported_files: &'a mut HashSet<String>,
        current_file: String,
    ) -> Self {
        Parser {
            m_tokens,
            m_index: 0,
            struct_table: HashMap::new(),
            expressions: Vec::new(),
            types: HashSet::new(),
            source_cache: RefCell::new(HashMap::new()),
            line: 1,
            col: 0,
            had_error: Cell::new(false),
            current_file,
            generic: HashSet::new(),
            enums_table: HashMap::new(),
            base_dir,
            imported_files,
        }
    }

    fn peek(&self, offset: usize) -> &Token {
        let pos: usize = self.m_index + offset;
        if self.m_index >= self.m_tokens.len() {
            self.error_at(format!("Unexpected EOF"), self.line, self.col);
            std::process::exit(1);
        }
        &self.m_tokens[pos]
    }

    fn get_source_line(&self, file: &str, line: usize) -> Option<String> {
        if !self.source_cache.borrow().contains_key(file) {
            let contents = std::fs::read_to_string(file).ok()?;
            let lines = contents.lines().map(String::from).collect();
            self.source_cache
                .borrow_mut()
                .insert(file.to_string(), lines);
        }
        self.source_cache
            .borrow()
            .get(file)?
            .get(line.saturating_sub(1))
            .cloned()
    }

    fn error_at(&self, msg: String, line: usize, col: usize) -> Option<()> {
        eprintln!("\x1b[31;1merror\x1b[0m: \x1b[1m{}\x1b[0m", msg);
        eprintln!(
            "  \x1b[34;1m-->\x1b[0m {}:{}:{}",
            self.current_file, line, col
        );

        if let Some(src_line) = self.get_source_line(&self.current_file, line) {
            let gutter = line.to_string();
            let pad = " ".repeat(gutter.len());
            eprintln!(" {}\x1b[34;1m|\x1b[0m", pad);
            eprintln!(
                "\x1b[34;1m{}\x1b[0m \x1b[34;1m|\x1b[0m {}",
                gutter, src_line
            );
            eprintln!(
                " {}\x1b[34;1m|\x1b[0m {}\x1b[31;1m^\x1b[0m",
                pad,
                " ".repeat(col.saturating_sub(2))
            );
        }

        self.had_error.set(true);
        return None;
    }

    pub fn consume_until(&mut self, ty: &[TokenType]) {
        while !ty.contains(&self.peek(0).token) {
            self.consume();
        }
    }

    pub fn expect(&mut self, ty: TokenType) -> Option<bool> {
        if self.peek(0).token != ty {
            let found = self.peek(0);
            self.error_at(
                format!("Syntax error: expected {:?}, got {:?}", ty, found.token),
                found.line,
                found.col,
            );
            return None;
        }

        let res = self.consume();
        self.line = res.line;
        self.col = res.col;
        Some(true)
    }

    fn consume(&mut self) -> Token {
        if self.m_index >= self.m_tokens.len() {
            panic!("Trying to consume more than m_src len");
        }
        let res = self.m_tokens.remove(0);
        self.col = res.col;
        self.current_file = res.file.clone();
        self.line = res.line;
        res
    }

    pub fn unwrap_expect<T>(&self, smth: Option<T>) -> Option<T> {
        if smth.is_none() {
            self.error_at("Unexpected value".to_string(), self.line, self.col);
        }
        smth
    }

    fn is_struct(&self, var_name: &String) -> bool {
        if self.types.get(var_name).is_some() {
            return true;
        }
        return false;
    }

    pub fn parse(&mut self) -> Vec<Stmt> {
        self.reg_types();

        while !self.m_tokens.is_empty() {
            if let Some(stmt) = self.parse_stmt() {
                self.expressions.push(stmt);
            }
        }

        self.expressions.clone()
    }

    pub fn reg_types(&mut self) {
        let mut i = 0;
        while i < self.m_tokens.len() {
            let tok = &self.m_tokens[i];
            if tok.token == TokenType::Struct || tok.token == TokenType::Enum {
                if let Some(name_tok) = self.m_tokens.get(i + 1) {
                    if let Some(name) = &name_tok.value {
                        self.types.insert(name.clone());
                    }
                }
            }
            i += 1;
        }
    }

    fn size_of(&self, ty: &Type) -> usize {
        match ty {
            Type::Primitive(TokenType::I32) | Type::Primitive(TokenType::U32) => 4,
            Type::Primitive(TokenType::I8) | Type::Primitive(TokenType::U8) => 1,
            Type::Primitive(TokenType::I16) | Type::Primitive(TokenType::U16) => 2,
            Type::Primitive(TokenType::I64) | Type::Primitive(TokenType::U64) => 8,

            Type::Pointer(_) => 8, // assume 64-bit

            Type::Array(inner, count) => self.size_of(inner) * count,

            Type::Struct(name) => {
                self.struct_table
                    .get(name)
                    .expect(&format!("unkown struct: {}", name))
                    .size
            }
            Type::Enum(..) => 8,
            Type::GenericType(_) => 0,
            Type::GenericInst(..) => 0,
            _ => {
                println!("ty: {:?}", ty);
                panic!("Unknown type size")
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

    pub fn print_error(&self, err: Error) {
        eprintln!("\x1b[31;1merror\x1b[0m: \x1b[1m{}\x1b[0m", err.ty);

        eprintln!(
            "  \x1b[34;1m-->\x1b[0m {}:{}:{}",
            err.file, err.line, err.col
        );

        self.had_error.set(true);
    }

    fn get_custom_type(&mut self, name: &String) -> Option<Type> {
        if self.types.contains(name) {
            if self.struct_table.contains_key(name) {
                return Some(Type::Struct(name.clone()));
            } else if self.enums_table.contains_key(name) {
                return Some(Type::Enum(name.clone(), None));
            } else {
                return Some(Type::GenericType(name.clone()));
            }
        }
        None
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
    pub fn get_type(&mut self) -> Option<Type> {
        if self.peek(0).token == TokenType::Var {
            let token = self.consume();
            // i will make parser error system one day
            //dbg!(&token);
            let value = token.value.unwrap();
            let name = self.types.get(&value);
            let name = match name {
                Some(good_name) => good_name,
                None => {
                    self.print_error(self.type_to_error(SemanticError::UnkownType(value)));
                    return None;
                }
            };
            if self.struct_table.get(name).is_some() {
                return Some(Type::Struct(name.to_string()));
            } else if self.enums_table.get(name).is_some() {
                return Some(Type::Enum(name.to_string(), None));
            } else if self.generic.get(name).is_some() {
                return Some(Type::GenericType(name.clone()));
            } else {
                return Some(Type::Named(name.to_string()));
            }
        } else if self.is_type(self.peek(0)) {
            return Some(Type::Primitive(self.consume().token));
        } else {
            let token = self.peek(0);
            self.error_at(
                format!("unkown type: {:?}", token.token),
                token.line,
                token.col,
            );
            return None;
        };
    }
    pub fn is_type(&self, token: &Token) -> bool {
        match token.token {
            TokenType::I8
            | TokenType::I16
            | TokenType::I32
            | TokenType::I64
            | TokenType::U8
            | TokenType::U16
            | TokenType::U32
            | TokenType::U64 => true,
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
    pub fn type_to_stmt(&self, stmt: StmtType) -> Stmt {
        Stmt {
            ty: stmt,
            line: self.line,
            file: self.current_file.clone(),
        }
    }
}
