use std::{
    cell::{Cell, RefCell},
    collections::{HashMap, HashSet},
};

use crate::{
    Ir::{
        Stmt,
        expr::{BinOp, UnaryOp},
        r#gen::{FuncData, StructData},
        stmt::{EnumData, Type},
    },
    tokenizer::Token,
};

#[derive(Debug, Clone)]
pub struct Analyzer<'a> {
    pub stmts: &'a Vec<Stmt>,
    pub had_error: Cell<bool>,
    pub computing: RefCell<HashSet<String>>,
    pub scopes: Vec<HashMap<String, Type>>,
    pub generics: RefCell<HashMap<String, Type>>,
    pub global_vars: HashMap<String, Type>,
    pub functions: HashMap<String, Vec<FuncData>>,
    pub enums: RefCell<HashMap<String, EnumData>>,
    pub break_stack: Vec<String>,
    pub contniue_stack: Vec<String>,
    pub generic_func: HashMap<String, Stmt>,
    pub inside_struct: bool, // needed to check where we call private function
    pub structs: RefCell<HashMap<String, StructData>>,
    pub current_ret_type: Type,
    pub line: usize,
    pub current_file: String,
    pub col: usize,
}

#[derive(Debug, Clone)]
pub struct Error {
    pub ty: SemanticError,
    pub file: String,
    pub line: usize,
    pub col: usize,
}

#[derive(Debug, Clone)]
pub enum SemanticError {
    EmptyArray,
    UndeclaredVariable(String),
    UndeclaredFunction(String),
    UndeclaredStruct(String),
    UndeclaredField(String, String), // (struct_name, field_name)
    AlreadyDeclared(String),
    UnkownType(String),
    BreakOutsideOfLoop,
    PrivateFunctionOutsideCall(String),
    FunctionArgsMismatch {
        func_name: String,
        expected: usize,
        got: usize,
    },
    ContinueOutsideOfLoop,
    VoidVariable(String),
    ArrayTooLarge {
        arr_name: String,
        expected: usize,
        got: usize,
    },
    TypeMismatch {
        expected: Type,
        got: Type,
    },
    BadType(Token),
    StructCountMismatch {
        struct_name: String,
        expected: usize,
        got: usize,
    },
    StructTypeMismatch {
        struct_name: String,
        expected: Type,
        got: Type,
    },
    StructNameNotFound {
        struct_name: String,
        got: String,
    },
    ReturnTypeMismatch {
        expected: Type,
        got: Type,
    },
    ReturnOutsideFunction,
    NotAPointer(Type),
    NotIndexable(Type),
    NotAStruct(Type),
    InvalidArrayIndex(Type),
    NonArrayIndex(Type),
    MatchTypeMismatch {
        expected: Type,
        got: Type,
    },
    InvalidUnary {
        op: UnaryOp,
        ty: Type,
    },
    InvalidBinary {
        op: BinOp,
        left: Type,
        right: Type,
    },
    CastError {
        before: Type,
        after: Type,
    },
    MatchExprUnsuported(Type),
    DerefNonPointer(Type),
    CircularStruct(String),
    NoFoundFuncOverload(String),
    MissingReturn(String),
    FileDoesntExist(String),
}
