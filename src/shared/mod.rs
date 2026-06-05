use crate::{
    Ir::{
        sem_analysis::Error,
        stmt::{LValue, Type},
    },
    tokenizer::TokenType,
};

pub fn substitute_type(ty: &Type, params: &Vec<String>, args: &Vec<Type>) -> Type {
    match ty {
        Type::GenericType(name) => {
            if let Some(pos) = params.iter().position(|p| p == name) {
                args[pos].clone()
            } else {
                ty.clone()
            }
        }
        Type::Pointer(inner) => Type::Pointer(Box::new(substitute_type(inner, params, args))),
        Type::Array(inner, size) => {
            Type::Array(Box::new(substitute_type(inner, params, args)), *size)
        }
        Type::GenericInst(name, inner_args) => {
            // substitute inside nested generics e.g. Option<Vec<T>>
            let new_args = inner_args
                .iter()
                .map(|a| substitute_type(a, params, args))
                .collect();
            Type::GenericInst(name.clone(), new_args)
        }
        _ => ty.clone(),
    }
}

pub fn align16(n: usize) -> usize {
    (n + 15) & !15
}

pub fn type_name(ty: &Type) -> String {
    match ty {
        Type::Primitive(token) => match token {
            TokenType::IntType => "int".to_string(),
            TokenType::LongType => "long".to_string(),
            TokenType::CharType => "char".to_string(),
            TokenType::ShortType => "short".to_string(),
            TokenType::Void => "void".to_string(),
            _ => format!("{:?}", token),
        },
        Type::Pointer(inner) => format!("{}__ptr", type_name(inner)),
        Type::Array(inner, size) => format!("{}__arr__{}", type_name(inner), size),
        Type::Struct(name) => name.clone(),
        Type::Enum(name, _) => name.clone(),
        Type::GenericType(name) => name.clone(),
        Type::GenericInst(name, types) => {
            let type_args = types
                .iter()
                .map(|t| type_name(t))
                .collect::<Vec<_>>()
                .join("_");
            format!("{}__{}", name, type_args)
        }
        Type::Unknown => "unknown".to_string(),
    }
}

pub fn to_base_reg(reg: &str) -> &str {
    match reg {
        "eax" | "ax" | "al" => "rax",
        "ebx" | "bx" | "bl" => "rbx",
        "ecx" | "cx" | "cl" => "rcx",
        "edx" | "dx" | "dl" => "rdx",
        "esi" | "si" | "sil" => "rsi",
        "edi" | "di" | "dil" => "rdi",
        _ => reg, // already 64-bit or r8-r15
    }
}

pub fn arg_pos(pos: usize, ty: &Type) -> String {
    let size = match ty {
        Type::Primitive(token) => match token {
            TokenType::CharType => 1,
            TokenType::ShortType => 2,
            TokenType::IntType => 4,
            TokenType::LongType => 8,
            _ => panic!("unsupported primitive type in arg_pos: {:?}", token),
        },
        Type::Unknown | Type::GenericType(_) | Type::GenericInst(..) => {
            panic!("unkown type: {:?}", ty)
        }
        Type::Pointer(_) | Type::Array(_, _) | Type::Struct(_) | Type::Enum(..) => 8,
    };

    match (pos, size) {
        (0, 8) => "rdi",
        (0, 4) => "edi",
        (0, 2) => "di",
        (0, 1) => "dil",
        (1, 8) => "rsi",
        (1, 4) => "esi",
        (1, 2) => "si",
        (1, 1) => "sil",
        (2, 8) => "rdx",
        (2, 4) => "edx",
        (2, 2) => "dx",
        (2, 1) => "dl",
        (3, 8) => "rcx",
        (3, 4) => "ecx",
        (3, 2) => "cx",
        (3, 1) => "cl",
        (4, 8) => "r8",
        (4, 4) => "r8d",
        (4, 2) => "r8w",
        (4, 1) => "r8b",
        (5, 8) => "r9",
        (5, 4) => "r9d",
        (5, 2) => "r9w",
        (5, 1) => "r9b",
        (6, 8) => "r10",
        (6, 4) => "r10d",
        (6, 2) => "r10w",
        (6, 1) => "r10b",
        (7, 8) => "r11",
        (7, 4) => "r11d",
        (7, 2) => "r11w",
        (7, 1) => "r11b",
        _ => panic!("arg_pos: unsupported pos={} size={}", pos, size),
    }
    .to_string()
}

pub fn lvalue_root(lvalue: &LValue) -> String {
    match lvalue {
        LValue::Variable(name) => name.clone(),
        LValue::Field { base, .. } => lvalue_root(base),
        LValue::Deref(inner) => lvalue_root(inner),
        LValue::Index { base, .. } => lvalue_root(base),
    }
}

pub fn numeric_rank(ty: &Type) -> Option<u8> {
    match ty {
        //Type::Primitive(TokenType::Bool)  => Some(0),
        Type::Primitive(TokenType::CharType) => Some(1),
        Type::Primitive(TokenType::ShortType) => Some(2),
        Type::Primitive(TokenType::IntType) => Some(3),
        Type::Primitive(TokenType::LongType) => Some(4),
        //Type::Primitive(TokenType::Float) => Some(4),
        _ => None,
    }
}

pub fn is_numeric(ty: &Type) -> bool {
    numeric_rank(ty).is_some()
}

pub fn is_arithmetic(ty: &Type) -> bool {
    matches!(
        ty,
        Type::Primitive(TokenType::CharType)
            | Type::Primitive(TokenType::IntType)
            | Type::Primitive(TokenType::LongType) //Type::Primitive(TokenType::Float)
    )
}

pub fn is_integer(ty: &Type) -> bool {
    matches!(
        ty,
        //Type::Primitive(TokenType::Bool)  |
        Type::Primitive(TokenType::CharType)
            | Type::Primitive(TokenType::IntType)
            | Type::Primitive(TokenType::LongType)
    )
}

pub fn coerce_numeric(a: &Type, b: &Type) -> Type {
    if numeric_rank(a) >= numeric_rank(b) {
        a.clone()
    } else {
        b.clone()
    }
}

pub fn check_types(left: &Type, right: &Type) -> bool {
    if left == right {
        return true;
    }
    if matches!(left, Type::GenericType(_)) || matches!(right, Type::GenericType(_)) {
        return true;
    }
    // only allow numeric coercion, no ptr<->long
    if numeric_rank(left).is_some() && numeric_rank(right).is_some() {
        return true;
    }
    // char array compatible with char*
    if let Type::Array(elem, _) = left {
        if **elem == Type::Primitive(TokenType::CharType)
            && *right == Type::Pointer(Box::new(Type::Primitive(TokenType::CharType)))
        {
            return true;
        }
    }
    // void* compatible with any pointer
    let is_void_ptr = |t: &Type| *t == Type::Pointer(Box::new(Type::Primitive(TokenType::Void)));
    if is_void_ptr(left) && matches!(right, Type::Pointer(_)) {
        return true;
    }
    if is_void_ptr(right) && matches!(left, Type::Pointer(_)) {
        return true;
    }
    // GenericInst compatible with same base type
    if let (Type::GenericType(l_name), Type::GenericType(r_name)) = (left, right) {
        return l_name == r_name;
    }
    false
}
