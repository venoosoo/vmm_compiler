use crate::Ir::{Stmt, stmt::Type};

#[derive(Debug, Clone, PartialEq)]
pub struct Expr {
    pub ty: ExprType,
    pub file: String,
    pub line: usize,
    pub col: usize,
}

#[derive(Debug, Clone, PartialEq)]
pub enum ExprType {
    Number(i64),
    Float(f64),
    Variable(String),

    Binary {
        op: BinOp,
        left: Box<Expr>,
        right: Box<Expr>,
    },

    Unary {
        op: UnaryOp,
        expr: Box<Expr>,
    },

    Call {
        name: String,
        generics: Vec<Type>,
        args: Vec<Expr>,
    },

    StructInit {
        struct_name_ty: String,
        fields: Vec<(String, Expr)>,
    },

    StructMember {
        base: Box<Expr>,
        name: String,
    },

    Deref(Box<Expr>),

    Index {
        base: Box<Expr>,
        index: Box<Expr>,
    },
    ArrayInit {
        elements: Vec<Expr>,
    },
    SizeOf {
        ty: Type,
    },
    String {
        str: String,
    },
    GetEnum {
        base: String,
        variant: String,
        value: Vec<EnumExprField>,
    },
    Cast {
        expr: Box<Expr>,
        ty: Type,
    },
}

#[derive(Debug, Clone, PartialEq)]
pub enum BinOp {
    Add,
    Sub,
    Mul,
    Div,
    Mod,
    Eq,
    Neq,
    Lt,
    Lte,
    Gt,
    Gte,
    And,
    Or,
    BitAnd,
    BitOr,
    BitXor,
    ShiftLeft,
    ShiftRight,
}

#[derive(Debug, Clone, PartialEq)]
pub enum UnaryOp {
    Neg,
    Not,
    GetAddr,
    BitNot,
}

#[derive(Debug, Clone, PartialEq)]
pub struct EnumExprField {
    pub name: String,
    pub expr: Expr,
}

pub trait Lookup {
    fn look_var(&self, name: &String) -> Option<Type>;
    fn look_unary(&self, op: &UnaryOp, expr: &Box<Expr>) -> Type;
    fn look_binary(&self, op: &BinOp, left: &Box<Expr>, right: &Box<Expr>) -> Type;
    fn look_struct_init(&self, struct_name: &String) -> Type;
    fn look_deref(&self, ptr_expr: &Box<Expr>) -> Type;
    fn look_addres_of(&self, var_expr: &Box<Expr>) -> Type;
    fn look_index(&self, base: &Box<Expr>, index: &Box<Expr>) -> Type;
    fn look_struct_member(&self, base: &Box<Expr>, name: &String) -> Type;
    fn look_call(&self, name: &String, arg: &Vec<Expr>, generics: &Vec<Type>) -> Type;
    fn look_array_init(&self, elements: &Vec<Expr>) -> Type;
    fn look_get_enum(&self, base: &String, variant: &String) -> Type;
}
