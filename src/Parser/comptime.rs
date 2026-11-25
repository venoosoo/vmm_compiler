use crate::{
    Ir::{
        expr::{EnumExprField, Expr, ExprType, MatchField, MatchLeftValue},
        stmt::{
            CapturedValue, Comptime, Declaration, LValue, Macro, MacroDelimiter, MacroPattern,
            MacroRepetition, MacroSpecifiers, MacroTrigger,
        },
    },
    Parser::Parser,
    shared::{collect_expr_vars, get_macro_delimiter, macro_delimiter_tokens, macro_name_to_type},
};

use super::*;

impl<'a> Parser<'a> {
    pub fn parse_comptime(&mut self) -> Option<Stmt> {
        self.expect(TokenType::CompTime);

        if self.peek(0).token == TokenType::If {
            let stmt = self.parse_if()?;
            let ty = Comptime::ComptimeIf(Box::new(stmt));
            return Some(self.type_to_stmt(StmtType::Comptime(ty)));
        } else if self.peek(0).token == TokenType::OpenScope {
            self.expect(TokenType::OpenScope);

            let mut comptime_rules: Vec<Macro> = Vec::new();

            while self.peek(0).token != TokenType::CloseScope {
                let res = self.parse_comptime_macro()?;

                let Some(trigger) = Self::classify_macro_trigger(&res.pattern) else {
                    self.error_at(
                        "Macro pattern must start with a literal token or `$expr <token>`"
                            .to_string(),
                        self.line,
                        self.col,
                    );
                    return None;
                };

                match trigger {
                    MacroTrigger::Prefix(key) => {
                        self.prefix_macro_table
                            .entry(key)
                            .or_insert_with(Vec::new)
                            .push(res.clone());
                    }
                    MacroTrigger::Postfix(key) => {
                        self.postfix_macro_table
                            .entry(key)
                            .or_insert_with(Vec::new)
                            .push(res.clone());
                    }
                }

                comptime_rules.push(res);
            }

            self.expect(TokenType::CloseScope);

            let stmt_ty = StmtType::Comptime(Comptime::Macro(comptime_rules));
            return Some(self.type_to_stmt(stmt_ty));
        }

        None
    }

    pub fn match_macro_pattern(
        &mut self,
        patterns: &[MacroPattern],
        bindings: &mut HashMap<String, CapturedValue>,
    ) -> bool {
        for (i, pat) in patterns.iter().enumerate() {
            match pat {
                MacroPattern::Token(expected) => {
                    if self.peek(0).value.as_deref() != Some(expected.as_str()) {
                        return false;
                    }
                    self.consume();
                }

                MacroPattern::Capture { name, specifier } => {
                    let val = match specifier {
                        MacroSpecifiers::Expr => {
                            let Some(e) = self.parse_expr() else {
                                return false;
                            };
                            CapturedValue::Expr(e)
                        }
                        MacroSpecifiers::Ident => {
                            if self.peek(0).token != TokenType::Var {
                                return false;
                            }
                            let Some(id) = self.consume().value else {
                                return false;
                            };
                            CapturedValue::Ident(id)
                        }
                        MacroSpecifiers::Ty => {
                            let Some(ty) = self.parse_type() else {
                                return false;
                            };
                            CapturedValue::Ty(ty.1)
                        }
                        MacroSpecifiers::Stmt => {
                            let Some(s) = self.parse_stmt() else {
                                return false;
                            };
                            CapturedValue::Stmt(s)
                        }
                        MacroSpecifiers::Literal => {
                            let Some(lit) = self.parse_primary() else {
                                return false;
                            };
                            CapturedValue::Expr(lit)
                        }
                    };
                    bindings.insert(name.clone(), val);
                }

                MacroPattern::Group { delimiter, pattern } => {
                    let (open, close) = macro_delimiter_tokens(delimiter);
                    if self.peek(0).value.as_deref() != Some(open) {
                        return false;
                    }
                    self.consume(); // consume opening delimiter

                    if !self.match_macro_pattern(pattern, bindings) {
                        return false;
                    }

                    if self.peek(0).value.as_deref() != Some(close) {
                        return false;
                    }
                    self.consume(); // consume closing delimiter
                }

                MacroPattern::Repeat {
                    pattern,
                    separator,
                    repetition,
                } => {
                    let mut iterations = Vec::new();
                    loop {
                        let checkpoint = self.pos;
                        let mut iter_bindings = HashMap::new();

                        if !self.match_macro_pattern(pattern, &mut iter_bindings) {
                            self.pos = checkpoint;
                            break;
                        }
                        iterations.push(iter_bindings);

                        if *repetition == MacroRepetition::Optional {
                            break;
                        }

                        if let Some(sep) = separator {
                            if self.peek(0).value.as_deref() == Some(sep.as_str()) {
                                self.consume();
                            } else {
                                break;
                            }
                        }
                    }

                    if *repetition == MacroRepetition::OneOrMore && iterations.is_empty() {
                        return false;
                    }

                    bindings.insert(format!("__repeat_{}", i), CapturedValue::Repeat(iterations));
                }
            }
        }
        true
    }

    fn classify_macro_trigger(pattern: &[MacroPattern]) -> Option<MacroTrigger> {
        match pattern.first()? {
            MacroPattern::Token(tok) => Some(MacroTrigger::Prefix(tok.clone())),

            MacroPattern::Capture {
                specifier: MacroSpecifiers::Expr,
                ..
            } => {
                if let Some(MacroPattern::Token(op)) = pattern.get(1) {
                    Some(MacroTrigger::Postfix(op.clone()))
                } else {
                    None
                }
            }

            _ => None,
        }
    }

    fn parse_comptime_macro(&mut self) -> Option<Macro> {
        let pattern = self.parse_macro_rule()?;
        self.expect(TokenType::Access);

        let prev_in_macro = self.in_macro_body;
        self.in_macro_body = true;
        let code = self.parse_stmt()?;
        self.in_macro_body = prev_in_macro;

        Some(Macro {
            pattern,
            code: Box::new(code),
        })
    }

    pub fn parse_macro_stmt_repeat(&mut self) -> Option<Stmt> {
        let start_line = self.line;
        self.expect(TokenType::Dollar);
        self.consume(); // consume `(`

        let mut stmts = Vec::new();
        while self.peek(0).value.as_deref() != Some(")") {
            if self.peek(0).token == TokenType::EOF {
                self.error_at(
                    "Unclosed `$(` in macro statement repetition".to_string(),
                    start_line,
                    self.col,
                );
                return None;
            }
            stmts.push(self.parse_stmt()?);
        }

        self.consume(); // consume `)`

        let repetition = match self.consume().value.as_deref() {
            Some("*") => MacroRepetition::ZeroOrMore,
            Some("+") => MacroRepetition::OneOrMore,
            Some("?") => MacroRepetition::Optional,
            _ => {
                self.error_at(
                    "Expected `*`, `+`, or `?` after macro body repetition".to_string(),
                    self.line,
                    self.col,
                );
                return None;
            }
        };

        Some(Stmt {
            ty: StmtType::MacroRepeat {
                body: stmts,
                repetition,
            },
            line: start_line,
            file: self.current_file.clone(),
        })
    }

    fn parse_macro_rule(&mut self) -> Option<Vec<MacroPattern>> {
        let mut pattern = Vec::new();

        while self.peek(0).token != TokenType::Access {
            pattern.push(self.parse_macro_pattern()?);
        }

        Some(pattern)
    }

    fn parse_macro_pattern(&mut self) -> Option<MacroPattern> {
        if self.peek(0).token == TokenType::Dollar {
            return self.parse_macro_dollar();
        }
        if let Some(value) = self.peek(0).value.as_deref() {
            if let Some(delimiter) = get_macro_delimiter(value) {
                return self.parse_macro_group(delimiter);
            }
        }

        let Some(token) = self.consume().value else {
            self.error_at("Invalid macro token".to_string(), self.line, self.col);
            return None;
        };

        Some(MacroPattern::Token(token))
    }

    fn parse_macro_dollar(&mut self) -> Option<MacroPattern> {
        self.expect(TokenType::Dollar);
        if let Some(value) = self.peek(0).value.as_deref() {
            if let Some(delimiter) = get_macro_delimiter(value) {
                return self.parse_macro_repeat(delimiter);
            }
        }

        let Some(name) = self.consume().value else {
            self.error_at(
                "Invalid macro argument name".to_string(),
                self.line,
                self.col,
            );
            return None;
        };

        self.expect(TokenType::Colon);

        let Some(macro_ty_name) = self.consume().value else {
            self.error_at("Invalid macro type".to_string(), self.line, self.col);
            return None;
        };

        let Some(specifier) = macro_name_to_type(&macro_ty_name) else {
            self.error_at(
                format!("Invalid macro type: {}", macro_ty_name),
                self.line,
                self.col,
            );
            return None;
        };

        Some(MacroPattern::Capture { name, specifier })
    }

    fn parse_macro_group(&mut self, delimiter: MacroDelimiter) -> Option<MacroPattern> {
        let (_open, close) = macro_delimiter_tokens(&delimiter);

        self.consume(); // Opening delimiter

        let mut pattern = Vec::new();

        while self.peek(0).value.as_deref() != Some(close) {
            pattern.push(self.parse_macro_pattern()?);
        }

        self.consume(); // Closing delimiter

        Some(MacroPattern::Group { delimiter, pattern })
    }

    fn parse_macro_repeat(&mut self, delimiter: MacroDelimiter) -> Option<MacroPattern> {
        let (_, close) = macro_delimiter_tokens(&delimiter);

        self.consume(); // Opening delimiter

        let mut pattern = Vec::new();

        while self.peek(0).value.as_deref() != Some(close) {
            pattern.push(self.parse_macro_pattern()?);
        }

        self.consume(); // Closing delimiter

        let separator = if self.is_macro_repetition() {
            None
        } else {
            let Some(separator) = self.consume().value else {
                self.error_at(
                    "Invalid macro repetition separator".to_string(),
                    self.line,
                    self.col,
                );
                return None;
            };

            Some(separator)
        };

        let repetition = match self.consume().value.as_deref() {
            Some("*") => MacroRepetition::ZeroOrMore,
            Some("+") => MacroRepetition::OneOrMore,
            Some("?") => MacroRepetition::Optional,
            _ => {
                self.error_at(
                    "Expected *, + or ? after macro repetition".to_string(),
                    self.line,
                    self.col,
                );
                return None;
            }
        };

        Some(MacroPattern::Repeat {
            pattern,
            separator,
            repetition,
        })
    }

    fn is_macro_repetition(&self) -> bool {
        matches!(self.peek(0).value.as_deref(), Some("*" | "+" | "?"))
    }

    pub fn expand_macro_stmt(
        &mut self,
        code: &Stmt,
        bindings: &HashMap<String, CapturedValue>,
    ) -> Option<Stmt> {
        let hygiene_id = self.get_id();
        let mut renamed_locals = HashMap::new();
        self.substitute_stmt(code, bindings, &mut renamed_locals, hygiene_id)
    }

    pub fn expand_macro_expr(
        &mut self,
        code: &Stmt,
        bindings: &HashMap<String, CapturedValue>,
    ) -> Option<Expr> {
        let hygiene_id = self.get_id();
        let mut renamed_locals: HashMap<String, String> = HashMap::new();

        let expanded_stmt =
            self.substitute_stmt(code, bindings, &mut renamed_locals, hygiene_id)?;

        match expanded_stmt.ty {
            StmtType::ExprStmt(expr) => Some(expr),
            StmtType::Block(mut stmts) => {
                if let Some(last) = stmts.pop() {
                    if let StmtType::ExprStmt(expr) = last.ty {
                        return Some(expr);
                    }
                }
                self.error_at(
                    "Expression macro must end with an expression".to_string(),
                    code.line,
                    0,
                );
                None
            }
            _ => {
                self.error_at(
                    "Expected expression or block in expression macro".to_string(),
                    code.line,
                    0,
                );
                None
            }
        }
    }

    fn substitute_stmt(
        &mut self,
        stmt: &Stmt,
        bindings: &HashMap<String, CapturedValue>,
        renamed: &mut HashMap<String, String>,
        hygiene_id: usize,
    ) -> Option<Stmt> {
        let new_ty = match &stmt.ty {
            StmtType::Block(stmts) => {
                let mut new_stmts = Vec::new();
                for s in stmts {
                    if let StmtType::MacroRepeat {
                        body: rep_stmts, ..
                    } = &s.ty
                    {
                        let iterations = self.find_repeat_for_stmts(rep_stmts, bindings, s.line)?;
                        for (iter_idx, iter_bindings) in iterations.iter().enumerate() {
                            let mut scoped_bindings = bindings.clone();
                            scoped_bindings.extend(iter_bindings.clone());

                            let mut iter_renamed = renamed.clone();
                            let iter_hygiene = hygiene_id * 1000 + iter_idx;

                            for rep_s in rep_stmts {
                                new_stmts.push(self.substitute_stmt(
                                    rep_s,
                                    &scoped_bindings,
                                    &mut iter_renamed,
                                    iter_hygiene,
                                )?);
                            }
                        }
                    } else {
                        new_stmts.push(self.substitute_stmt(s, bindings, renamed, hygiene_id)?);
                    }
                }
                StmtType::Block(new_stmts)
            }

            StmtType::ExprStmt(expr) => {
                StmtType::ExprStmt(self.substitute_expr(expr, bindings, renamed, hygiene_id)?)
            }

            StmtType::Declaration(decl) => {
                let fresh_name = format!("__mac_{}_{}", hygiene_id, decl.name);
                renamed.insert(decl.name.clone(), fresh_name.clone());

                let new_init = match &decl.initializer {
                    Some(init) => Some(self.substitute_expr(init, bindings, renamed, hygiene_id)?),
                    None => None,
                };

                StmtType::Declaration(Declaration {
                    name: fresh_name,
                    ty: self.substitute_type(&decl.ty, bindings),
                    initializer: new_init,
                })
            }

            StmtType::Assignment { target, value } => StmtType::Assignment {
                target: self.substitute_lvalue(target, bindings, renamed, hygiene_id)?,
                value: self.substitute_expr(value, bindings, renamed, hygiene_id)?,
            },

            StmtType::Return(opt_expr) => StmtType::Return(match opt_expr {
                Some(e) => Some(self.substitute_expr(e, bindings, renamed, hygiene_id)?),
                None => None,
            }),

            StmtType::If {
                condition,
                if_block,
                else_block,
            } => StmtType::If {
                condition: self.substitute_expr(condition, bindings, renamed, hygiene_id)?,
                if_block: Box::new(self.substitute_stmt(if_block, bindings, renamed, hygiene_id)?),
                else_block: match else_block {
                    Some(eb) => Some(Box::new(
                        self.substitute_stmt(eb, bindings, renamed, hygiene_id)?,
                    )),
                    None => None,
                },
            },

            StmtType::While { condition, body } => StmtType::While {
                condition: self.substitute_expr(condition, bindings, renamed, hygiene_id)?,
                body: Box::new(self.substitute_stmt(body, bindings, renamed, hygiene_id)?),
            },

            StmtType::For {
                init,
                condition,
                update,
                body,
            } => StmtType::For {
                init: match init {
                    Some(i) => Some(Box::new(
                        self.substitute_stmt(i, bindings, renamed, hygiene_id)?,
                    )),
                    None => None,
                },
                condition: match condition {
                    Some(c) => Some(self.substitute_expr(c, bindings, renamed, hygiene_id)?),
                    None => None,
                },
                update: match update {
                    Some(u) => Some(Box::new(
                        self.substitute_stmt(u, bindings, renamed, hygiene_id)?,
                    )),
                    None => None,
                },
                body: Box::new(self.substitute_stmt(body, bindings, renamed, hygiene_id)?),
            },

            other => other.clone(),
        };

        Some(Stmt {
            ty: new_ty,
            line: stmt.line,
            file: stmt.file.clone(),
        })
    }

    fn substitute_expr(
        &mut self,
        expr: &Expr,
        bindings: &HashMap<String, CapturedValue>,
        renamed: &mut HashMap<String, String>,
        hygiene_id: usize,
    ) -> Option<Expr> {
        let new_ty = match &expr.ty {
            ExprType::Variable(name) => {
                if let Some(captured) = bindings.get(name) {
                    match captured {
                        CapturedValue::Expr(captured_expr) => return Some(captured_expr.clone()),
                        CapturedValue::Ident(id) => ExprType::Variable(id.clone()),
                        _ => {
                            self.error_at(
                                format!("Macro capture '{}' cannot be used as an expression", name),
                                expr.line,
                                expr.col,
                            );
                            return None;
                        }
                    }
                } else if let Some(hygienic_name) = renamed.get(name) {
                    ExprType::Variable(hygienic_name.clone())
                } else {
                    ExprType::Variable(name.clone())
                }
            }

            ExprType::Call {
                name,
                generics,
                args,
            } => {
                let resolved_name = match bindings.get(name) {
                    Some(CapturedValue::Ident(id)) => id.clone(),
                    _ => name.clone(),
                };
                let new_generics = generics
                    .iter()
                    .map(|ty| self.substitute_type(ty, bindings))
                    .collect();

                let new_args = self.expand_expr_list(args, bindings, renamed, hygiene_id)?;

                ExprType::Call {
                    name: resolved_name,
                    generics: new_generics,
                    args: new_args,
                }
            }

            ExprType::ArrayInit { elements } => ExprType::ArrayInit {
                elements: self.expand_expr_list(elements, bindings, renamed, hygiene_id)?,
            },

            ExprType::Match {
                expr: target,
                variants,
            } => {
                let new_target =
                    Box::new(self.substitute_expr(target, bindings, renamed, hygiene_id)?);
                let mut new_variants = Vec::with_capacity(variants.len());

                for field in variants {
                    let mut arm_renamed = renamed.clone();
                    let new_left = match &field.left {
                        MatchLeftValue::Enum { base, value, args } => {
                            let fresh_args = args
                                .iter()
                                .map(|arg| {
                                    let fresh = format!("__mac_{}_{}", hygiene_id, arg);
                                    arm_renamed.insert(arg.clone(), fresh.clone());
                                    fresh
                                })
                                .collect();
                            MatchLeftValue::Enum {
                                base: base.clone(),
                                value: value.clone(),
                                args: fresh_args,
                            }
                        }
                        MatchLeftValue::Expr { expr: pat_expr } => MatchLeftValue::Expr {
                            expr: self.substitute_expr(
                                pat_expr,
                                bindings,
                                &mut arm_renamed,
                                hygiene_id,
                            )?,
                        },
                    };
                    let new_right =
                        self.substitute_stmt(&field.right, bindings, &mut arm_renamed, hygiene_id)?;
                    new_variants.push(MatchField {
                        left: new_left,
                        right: new_right,
                    });
                }

                ExprType::Match {
                    expr: new_target,
                    variants: new_variants,
                }
            }

            ExprType::Binary { op, left, right } => ExprType::Binary {
                op: op.clone(),
                left: Box::new(self.substitute_expr(left, bindings, renamed, hygiene_id)?),
                right: Box::new(self.substitute_expr(right, bindings, renamed, hygiene_id)?),
            },

            ExprType::Unary { op, expr: inner } => ExprType::Unary {
                op: op.clone(),
                expr: Box::new(self.substitute_expr(inner, bindings, renamed, hygiene_id)?),
            },

            ExprType::StructMember { base, name } => ExprType::StructMember {
                base: Box::new(self.substitute_expr(base, bindings, renamed, hygiene_id)?),
                name: match bindings.get(name) {
                    Some(CapturedValue::Ident(id)) => id.clone(),
                    _ => name.clone(),
                },
            },

            ExprType::Index { base, index } => ExprType::Index {
                base: Box::new(self.substitute_expr(base, bindings, renamed, hygiene_id)?),
                index: Box::new(self.substitute_expr(index, bindings, renamed, hygiene_id)?),
            },

            ExprType::Deref(inner) => ExprType::Deref(Box::new(
                self.substitute_expr(inner, bindings, renamed, hygiene_id)?,
            )),

            ExprType::Cast { expr: inner, ty } => ExprType::Cast {
                expr: Box::new(self.substitute_expr(inner, bindings, renamed, hygiene_id)?),
                ty: self.substitute_type(ty, bindings),
            },

            ExprType::GetEnum {
                base,
                variant,
                value,
            } => {
                let mut new_vals = Vec::with_capacity(value.len());
                for field in value {
                    new_vals.push(EnumExprField {
                        name: field.name.clone(),
                        expr: self.substitute_expr(&field.expr, bindings, renamed, hygiene_id)?,
                    });
                }
                ExprType::GetEnum {
                    base: base.clone(),
                    variant: variant.clone(),
                    value: new_vals,
                }
            }

            other => other.clone(),
        };

        Some(Expr {
            ty: new_ty,
            file: expr.file.clone(),
            line: expr.line,
            col: expr.col,
        })
    }

    fn expand_expr_list(
        &mut self,
        exprs: &[Expr],
        bindings: &HashMap<String, CapturedValue>,
        renamed: &mut HashMap<String, String>,
        hygiene_id: usize,
    ) -> Option<Vec<Expr>> {
        let mut out = Vec::new();
        for e in exprs {
            if let ExprType::MacroRepeat {
                exprs: rep_exprs, ..
            } = &e.ty
            {
                let iterations = self.find_repeat_for_exprs(rep_exprs, bindings, e.line)?;
                for (iter_idx, iter_bindings) in iterations.iter().enumerate() {
                    let mut scoped_bindings = bindings.clone();
                    scoped_bindings.extend(iter_bindings.clone());
                    let mut iter_renamed = renamed.clone();
                    let iter_hygiene = hygiene_id * 1000 + iter_idx;

                    for rep_e in rep_exprs {
                        out.push(self.substitute_expr(
                            rep_e,
                            &scoped_bindings,
                            &mut iter_renamed,
                            iter_hygiene,
                        )?);
                    }
                }
            } else {
                out.push(self.substitute_expr(e, bindings, renamed, hygiene_id)?);
            }
        }
        Some(out)
    }

    fn find_repeat_for_stmts(
        &mut self,
        stmts: &[Stmt],
        bindings: &HashMap<String, CapturedValue>,
        line: usize,
    ) -> Option<Vec<HashMap<String, CapturedValue>>> {
        let mut used_vars = Vec::new();
        for s in stmts {
            Self::collect_stmt_vars(s, &mut used_vars);
        }
        self.lookup_repeat_by_vars(&used_vars, bindings, line)
    }

    fn find_repeat_for_exprs(
        &mut self,
        exprs: &[Expr],
        bindings: &HashMap<String, CapturedValue>,
        line: usize,
    ) -> Option<Vec<HashMap<String, CapturedValue>>> {
        let mut used_vars = Vec::new();
        for e in exprs {
            collect_expr_vars(e, &mut used_vars);
        }
        self.lookup_repeat_by_vars(&used_vars, bindings, line)
    }

    fn lookup_repeat_by_vars(
        &mut self,
        used_vars: &[String],
        bindings: &HashMap<String, CapturedValue>,
        line: usize,
    ) -> Option<Vec<HashMap<String, CapturedValue>>> {
        let repeat_entries: Vec<&Vec<HashMap<String, CapturedValue>>> = bindings
            .values()
            .filter_map(|v| match v {
                CapturedValue::Repeat(iters) => Some(iters),
                _ => None,
            })
            .collect();

        for iters in &repeat_entries {
            if let Some(first_iter) = iters.first() {
                if used_vars.iter().any(|v| first_iter.contains_key(v)) {
                    return Some((*iters).clone());
                }
            }
        }

        if repeat_entries.iter().any(|iters| iters.is_empty()) {
            return Some(Vec::new());
        }

        self.error_at(
            "Macro repetition body does not reference any repeated capture variable".to_string(),
            line,
            0,
        );
        None
    }

    fn collect_stmt_vars(stmt: &Stmt, out: &mut Vec<String>) {
        match &stmt.ty {
            StmtType::Block(stmts) => stmts.iter().for_each(|s| Self::collect_stmt_vars(s, out)),
            StmtType::ExprStmt(e) | StmtType::Return(Some(e)) => collect_expr_vars(e, out),
            StmtType::Declaration(d) => {
                if let Some(init) = &d.initializer {
                    collect_expr_vars(init, out);
                }
            }
            StmtType::Assignment { value, .. } => collect_expr_vars(value, out),
            StmtType::If {
                condition,
                if_block,
                else_block,
            } => {
                collect_expr_vars(condition, out);
                Self::collect_stmt_vars(if_block, out);
                if let Some(eb) = else_block {
                    Self::collect_stmt_vars(eb, out);
                }
            }
            _ => {}
        }
    }

    fn substitute_lvalue(
        &mut self,
        lv: &LValue,
        bindings: &HashMap<String, CapturedValue>,
        renamed: &mut HashMap<String, String>,
        hygiene_id: usize,
    ) -> Option<LValue> {
        Some(match lv {
            LValue::Variable(name) => {
                if let Some(CapturedValue::Ident(id)) = bindings.get(name) {
                    LValue::Variable(id.clone())
                } else if let Some(hygienic) = renamed.get(name) {
                    LValue::Variable(hygienic.clone())
                } else {
                    LValue::Variable(name.clone())
                }
            }
            LValue::Field { base, name } => LValue::Field {
                base: Box::new(self.substitute_lvalue(base, bindings, renamed, hygiene_id)?),
                name: match bindings.get(name) {
                    Some(CapturedValue::Ident(id)) => id.clone(),
                    _ => name.clone(),
                },
            },
            LValue::Deref(inner) => LValue::Deref(Box::new(
                self.substitute_lvalue(inner, bindings, renamed, hygiene_id)?,
            )),
            LValue::Index { base, index } => LValue::Index {
                base: Box::new(self.substitute_lvalue(base, bindings, renamed, hygiene_id)?),
                index: Box::new(self.substitute_expr(index, bindings, renamed, hygiene_id)?),
            },
        })
    }

    fn substitute_type(&self, ty: &Type, bindings: &HashMap<String, CapturedValue>) -> Type {
        match ty {
            Type::Named(name) => {
                if let Some(CapturedValue::Ty(captured_ty)) = bindings.get(name) {
                    return captured_ty.clone();
                }
                ty.clone()
            }
            Type::Pointer(inner) => Type::Pointer(Box::new(self.substitute_type(inner, bindings))),
            Type::Array(inner, size) => {
                Type::Array(Box::new(self.substitute_type(inner, bindings)), *size)
            }
            Type::GenericInst(name, args) => Type::GenericInst(
                name.clone(),
                args.iter()
                    .map(|a| self.substitute_type(a, bindings))
                    .collect(),
            ),
            other => other.clone(),
        }
    }
}
