# v-- compiler
A compiler for a custom systems programming language, written from scratch in Rust. Compiles `.vmm` source files directly to x86-64 NASM assembly, which can be assembled and linked into a native Linux executable.

The language is procedural and C-style at its core — manual memory, pointers, structs — but borrows some of Rust's ergonomics: pattern matching on enums with payloads, Option types, and exhaustive match expressions(in future).

> **Status(v0.1.0):** Work in progress. Core pipeline is functional — see [what's working](#whats-working) below.

---

## What it does

Takes `.vmm` source code like this:

```c
fn print_num(long n) {
    if n < 0 {
        asm {
            "sub rsp, 1"
            "mov byte [rsp], '-'"
            "mov rax, 1"
            "mov rdi, 1"
            "mov rsi, rsp"
            "mov rdx, 1"
            "syscall"
            "add rsp, 1"
        }
        n = -n;
    }
    if n >= 10 {
        long temp = n / 10;
        print_num(temp);
    }
    char c = (n % 10) + '0';
    asm {
        "mov rax, 1"
        "mov rdi, 1"
        "lea rsi, (c)"
        "mov rdx, 1"
        "syscall"
    }
}
```

And produces real x86-64 NASM assembly:

```nasm
print_num:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 8]
    pop rbx
    cmp rax, rbx
    setl al
    movzx rax, al
    cmp rax, 0
    je end_if_1
if_1:
    sub rsp, 1
    mov byte [rsp], '-'
    ...
```

---

## Pipeline

```
.vmm source file
    │
    ▼
 Tokenizer        — lexes keywords, operators, literals, identifiers
    │
    ▼
  Parser          — recursive descent, Pratt-style expression parsing
    │
    ▼
   IR / AST       — typed statement and expression tree
    │
    ▼
Semantic Analysis — type checking, scope resolution, function signatures
    │
    ▼
 Code Generator   — stack-machine expression eval, x86-64 NASM output
    │
    ▼
  main.asm        — assemble with nasm + ld
```

---

## What's working
- ✅ Primitive types: `int`, `char`, `short`, `long`, `void`
- ✅ Pointers and dereferencing (`*`, `&`)
- ✅ Arrays with bounds-checked index access
- ✅ Structs with `.` (stack) and `->` (pointer) field access
- ✅ String literals — `char[] name = "hello"` with automatic null termination and size inference
- ✅ Functions with typed arguments and return values
- ✅ Control flow: `if`/`else`, `while`, `for`
- ✅ Inline `asm {}` blocks with variable substitution via `(varname)`
- ✅ Arithmetic, comparison, logical operators
- ✅ Recursion
- ✅ Global variables
- ✅ File imports via `import "file.v"`
- ✅ `sizeof(Type)` operator
- ✅ Generic Structs, Enums, Functions

## In progress / planned

- 🔧 Standart libary, Strings, Data structures, etc...
- 🔧 Macro system
- 🔧 Floats support
- 🔧 Better match support / optimization
- 🔧 Better error reporting

---

## Standard library

The standard library lives in `std/` and is imported with `import "std/std.vmm"`.
it is work-in-progress, but has the esssentials like

- Memory managment: `malloc`, `free`, `memcpy`
- System/IO: `exit`, `syscall`, `print`, `println`, `strlen`
- Data Structures: `Vector`

---

## Language syntax

```c
// Imports
import "std/std.vmm"
import "std/vector.vmm"

// Functions
fn add(i32 a, i32 b) -> i32 {
    return a + b;
}

// Variables and types
i32 x = 42;
u8 c = 'A';          // characters are just bytes!
i64 big = 1000000;
void* ptr;

// Pointers
i32* p = &x;
i32 val = *p;

// Arrays
i32 arr[10];
arr[0] = 1;

// String literals (size inferred automatically, essentially u8*)
u8[] name = "hello";
u8 greeting[8] = "jackpot";

// Structs
struct Point {
    i32 x;
    i32 y;
}
Point p = Point { x: 1, y: 2 };    // stack allocated, use .
Point* hp = malloc(sizeof(Point)); // heap allocated, use ->
hp->x = 10;

// Control flow
if x > 10 {
    // ...
} else {
    // ...
}

while x > 0 {
    x = x - 1;
}

for (i32 i = 0; i < 10; i = i + 1) {
    // ...
}

// Enums
enum Colors {
    black,
    white,
    yellow,
    purple,
}

Colors white = Colors::white;

// Matches
match white {
    Colors::white => {
        // ...
    }
    _ => {
        // ... 
    }
}

// Globals
global i64 counter;

// Inline assembly (variables substituted via (varname))
asm {
    "lea rsi, (c)"
    "mov rdx, 1"
    "syscall"
}
```

---

## Build & run

**Requirements:** Rust, NASM, ld (Linux only)

```bash
# Build the compiler
cargo build --release

# Compile a .vmm file
./target/release/vcompiler --file your_program.vmm

# Assemble and link the output
nasm -f elf64 main.asm -o main.o
ld main.o -o main

# Run
./main
```

---

## Project structure

```
src/
├── main.rs                  — CLI entry point
├── Tokenizer/mod.rs         — lexer
├── Parser/
│   ├── expr.rs              — expression parsing (Pratt precedence climbing)
│   ├── stmt.rs              — statement parsing
│   └── function.rs          — function definition parsing
├── Ir/
│   ├── stmt.rs              — statement, type, and LValue definitions
│   ├── expr.rs              — expression definitions
│   ├── gen.rs               — VarData, FuncData, StructData, Addr types
│   └── sem_analysis.rs      — semantic error types and Analyzer struct
├── sem_analysis/
│   ├── mod.rs               — Analyzer impl, scope management, check_code
│   ├── sem_expr.rs          — expression type checking
│   └── sem_stmt.rs          — statement type checking
├── Shared/
|   ├── mod.rs               - shared function that doesnt rely on classes
└── Gen/
    ├── mod.rs               — Gen struct, reg_for_size, arg_pos, helpers
    ├── gen_expr.rs          — expression codegen (stack-machine eval)
    └── gen_stmt.rs          — statement codegen, lvalue resolution

std/
├── std.vmm                  — print, malloc, memcpy, syscall, strlen, exit...
└── vector.vmm               — generic Vector with push/pop/get
```

---

## Why

Because i can
