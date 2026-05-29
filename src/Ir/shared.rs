use crate::Ir::{
    expr::Expr,
    r#gen::{FuncData, StructData},
    stmt::{EnumData, Type},
};

pub trait TypeContext {
    fn ensure_monomorphized(&mut self, ty: &Type) -> Type;
    fn monomorphize_enum(&mut self, def: &EnumData, type_args: &Vec<Type>) -> Type;
    fn monomorphize_struct(&mut self, def: &StructData, type_args: &Vec<Type>) -> Type;
    fn resolve_call(
        &mut self,
        name: &String,
        args: &Vec<Expr>,
        generics: &Vec<Type>,
    ) -> (FuncData, usize);
}
