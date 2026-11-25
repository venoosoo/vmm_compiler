section .data
NULL dq 0
str_2: db "num_to_errno called with 0 (everything fine)", 0
malloc_list_head dq 0
str_9: db "malloc: out of memory", 0
str_35: db "unwrap result on error", 0
str_36: db "unwrap_result got wrong data", 0
str_38: db "unwrap result on error", 0
str_39: db "unwrap_result got wrong data", 0
str_63: db "trying to get element: ", 0
str_64: db ", but vector size is: ", 0
str_86: db "Parse Error: Trailing commas detected in array", 0
str_87: db "Parse Error: Expected ',' or ']' in array", 0
str_99: db "Parse Error: Expected ':' after key in object", 0
str_116: db "Parse Error: Trailing commas detected in object", 0
str_117: db "Parse Error: Expected ',' or '}' in object", 0
str_118: db "Parse Error: Unexpected end of file", 0
str_126: db "JSON Get Error: Expected ']' in path", 0
str_129: db "trying to get element: ", 0
str_130: db ", but vector size is: ", 0
str_137: db "the hashmap doesnt have the key: ", 0
str_140: db "JSON Error: Expected number", 0
str_142: db "JSON Error: Expected string", 0
str_144: db "JSON Error: Expected boolean", 0
str_146: db "JSON Error: Expected array", 0
str_148: db "JSON Error: Expected object", 0
str_155: db "null", 0
str_157: db "true", 0
str_158: db "false", 0
str_160: db "[]", 0
str_164: db "{}", 0
str_177: db "JSON Set Error: Expected ']'", 0
str_181: db "Error: Vector set out of bounds", 0
str_191: db "null", 0
str_193: db "true", 0
str_194: db "false", 0
str_195: db "array: [", 0
str_197: db "]", 0
str_198: db "some object value", 0
str_199: db "./vmake_conf.json", 0
str_200: db "name", 0
str_201: db "compiler", 0
str_202: db "linker", 0
str_203: db "assembler", 0
str_204: db "src", 0
str_207: db "CONFIG ERROR: src has non string values ", 0
str_208: db "ld_flags", 0
str_209: db "asm_flags", 0
str_213: db "/usr/bin/", 0
str_215: db "--file", 0
str_216: db "-o", 0
str_217: db "./build/", 0
str_218: db ".asm", 0
str_222: db "trying to get element: ", 0
str_223: db ", but vector size is: ", 0
str_226: db "Error build task failed", 0
str_227: db "wait4 failed, handle=", 0
str_228: db " errno=", 0
str_230: db "Error build task failed", 0
str_233: db "./build/", 0
str_234: db ".asm", 0
str_235: db "-o", 0
str_236: db "./build/", 0
str_237: db ".o", 0
str_240: db "Error: Assembler task failed", 0
str_241: db "-o", 0
str_242: db "./build/", 0
str_244: db "./build/", 0
str_245: db ".o", 0
str_248: db "Error: Linking failed", 0
str_249: db "Build successful! Executable created at: ", 0
str_250: db "vmake 0.2.0", 0
str_252: db "run", 0
str_254: db "-v", 0
str_256: db "-V", 0
str_258: db "--version", 0
str_260: db "init", 0
str_262: db "build", 0
str_263: db "vmake_conf.json", 0
str_264: db "unkown arg: ", 0
str_265: db "build", 0
str_268: db "error code: ", 0
str_269: db " while running: ", 0
str_272: db "trying to get element: ", 0
str_273: db ", but vector size is: ", 0
str_274: db "=== Build Configuration ===", 0
str_275: db "Name: ", 0
str_277: db "(none)", 0
str_278: db "Compiler: ", 0
str_280: db "(none)", 0
str_281: db "Assembler: ", 0
str_283: db "(none)", 0
str_284: db "Linker: ", 0
str_286: db "(none)", 0
str_287: db "", 0
str_288: db "Sources:", 0
str_290: db "  - ", 0
str_292: db "  (none)", 0
str_293: db "ASM Flags:", 0
str_295: db "  - ", 0
str_297: db "  (none)", 0
str_298: db "LD Flags:", 0
str_300: db "  - ", 0
str_302: db "  (none)", 0
str_303: db "===========================", 0
str_304: db "=== Config Line ===", 0
str_305: db "Key: ", 0
str_307: db "(none)", 0
str_308: db "Args:", 0
str_310: db "  - ", 0
str_312: db "  (none)", 0
str_313: db "===================", 0
section .bss
section .text
global _start
_start:
    mov rdi, [rsp]
    lea rsi, [rsp+8]
    call main
    mov rax, 0
    mov rdi, rax
    mov rax, 60
    syscall
std__exit___0:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 4], edi
    mov rax, 60
    mov rdi, [rbp - 4]
    syscall
    mov rsp, rbp
    pop rbp
    ret


std__syscall:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], r9
    mov [rbp - 16], r8
    mov [rbp - 24], rcx
    mov [rbp - 32], rdx
    mov [rbp - 40], rsi
    mov [rbp - 48], rdi
    mov rax, [rbp - 48]
    mov rdi, [rbp - 40]
    mov rsi, [rbp - 32]
    mov rdx, [rbp - 24]
    mov r10, [rbp - 16]
    mov r8,  [rbp - 8]
    mov r9, 0
    syscall
    mov [rbp - 56], rax
    mov rax, [rbp - 56]
    mov rsp, rbp
    pop rbp
    ret


std__write_bytes___0:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    mov rax, 0
    mov r9, rax
    mov rax, 0
    mov r8, rax
    mov rax, QWORD [rbp - 8]
    mov rcx, rax
    mov rax, [rbp - 16]
    mov rdx, rax
    mov rax, 1
    mov rsi, rax
    mov rax, 1
    mov rdi, rax
    call std__syscall
    mov rsp, rbp
    pop rbp
    ret


std__os_alloc_pages___0:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, 1
    neg rax
    mov r9, rax
    mov rax, 34
    mov r8, rax
    mov rax, 3
    mov rcx, rax
    mov rax, QWORD [rbp - 8]
    mov rdx, rax
    mov rax, 0
    mov rsi, rax
    mov rax, 9
    mov rdi, rax
    call std__syscall
    mov rsp, rbp
    pop rbp
    ret


std__num_to_errno:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, QWORD [rbp - 16]
    neg rax
    mov [rbp - 24], rax
    cmp rax, 0
    je match_1_0
    cmp rax, 1
    je match_1_1
    cmp rax, 2
    je match_1_2
    cmp rax, 3
    je match_1_3
    cmp rax, 4
    je match_1_4
    cmp rax, 5
    je match_1_5
    cmp rax, 6
    je match_1_6
    cmp rax, 7
    je match_1_7
    cmp rax, 8
    je match_1_8
    cmp rax, 9
    je match_1_9
    cmp rax, 10
    je match_1_10
    cmp rax, 11
    je match_1_11
    cmp rax, 12
    je match_1_12
    cmp rax, 13
    je match_1_13
    cmp rax, 14
    je match_1_14
    cmp rax, 15
    je match_1_15
    cmp rax, 16
    je match_1_16
    cmp rax, 17
    je match_1_17
    cmp rax, 18
    je match_1_18
    cmp rax, 19
    je match_1_19
    cmp rax, 20
    je match_1_20
    cmp rax, 21
    je match_1_21
    cmp rax, 22
    je match_1_22
    cmp rax, 23
    je match_1_23
    cmp rax, 24
    je match_1_24
    cmp rax, 25
    je match_1_25
    cmp rax, 26
    je match_1_26
    cmp rax, 27
    je match_1_27
    cmp rax, 28
    je match_1_28
    cmp rax, 29
    je match_1_29
    cmp rax, 30
    je match_1_30
    cmp rax, 31
    je match_1_31
    cmp rax, 32
    je match_1_32
    cmp rax, 33
    je match_1_33
    cmp rax, 34
    je match_1_34
    cmp rax, 35
    je match_1_35
    cmp rax, 36
    je match_1_36
    cmp rax, 37
    je match_1_37
    cmp rax, 38
    je match_1_38
    jmp match_end_1
match_1_0:
    lea rax, [rel str_2]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
    jmp match_end_1
match_1_1:
    mov QWORD [rbp - 32], 1
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_2:
    mov QWORD [rbp - 32], 2
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_3:
    mov QWORD [rbp - 32], 3
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_4:
    mov QWORD [rbp - 32], 4
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_5:
    mov QWORD [rbp - 32], 5
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_6:
    mov QWORD [rbp - 32], 6
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_7:
    mov QWORD [rbp - 32], 7
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_8:
    mov QWORD [rbp - 32], 8
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_9:
    mov QWORD [rbp - 32], 9
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_10:
    mov QWORD [rbp - 32], 10
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_11:
    mov QWORD [rbp - 32], 11
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_12:
    mov QWORD [rbp - 32], 12
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_13:
    mov QWORD [rbp - 32], 13
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_14:
    mov QWORD [rbp - 32], 14
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_15:
    mov QWORD [rbp - 32], 15
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_16:
    mov QWORD [rbp - 32], 16
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_17:
    mov QWORD [rbp - 32], 17
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_18:
    mov QWORD [rbp - 32], 18
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_19:
    mov QWORD [rbp - 32], 19
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_20:
    mov QWORD [rbp - 32], 20
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_21:
    mov QWORD [rbp - 32], 21
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_22:
    mov QWORD [rbp - 32], 22
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_23:
    mov QWORD [rbp - 32], 23
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_24:
    mov QWORD [rbp - 32], 24
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_25:
    mov QWORD [rbp - 32], 25
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_26:
    mov QWORD [rbp - 32], 26
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_27:
    mov QWORD [rbp - 32], 27
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_28:
    mov QWORD [rbp - 32], 28
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_29:
    mov QWORD [rbp - 32], 29
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_30:
    mov QWORD [rbp - 32], 30
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_31:
    mov QWORD [rbp - 32], 31
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_32:
    mov QWORD [rbp - 32], 32
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_33:
    mov QWORD [rbp - 32], 33
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_34:
    mov QWORD [rbp - 32], 34
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_35:
    mov QWORD [rbp - 32], 35
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_36:
    mov QWORD [rbp - 32], 36
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_37:
    mov QWORD [rbp - 32], 37
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_1_38:
    mov QWORD [rbp - 32], 38
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_1
match_end_1:


std__malloc___0:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov [rbp - 8], rdi
    mov rax, 8
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    mov r10, r10
    push rdx
    cqo
    idiv r10
    mov rax, rdx
    pop rdx
    mov QWORD [rbp - 16], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je end_if_3
if_3:
    mov rax, QWORD [rbp - 16]
    push rax
    mov rax, 8
    pop r10
    sub rax, r10
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    add rax, r10
    mov QWORD [rbp - 8], rax
end_if_3:
    mov rax, [rel malloc_list_head]
    mov QWORD [rbp - 24], rax
    mov rax, [rel NULL]
    mov QWORD [rbp - 32], rax
while_4:
    mov rax, 0
    push rax
    mov rax, [rbp - 24]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je end_while_4
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov QWORD [rbp - 40], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov QWORD [rbp - 48], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_5
if_5:
    mov rax, QWORD [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    cmp rax, r10
    setge al
    movzx rax, al
    cmp rax, 0
    je end_if_6
if_6:
    mov rax, 0
    push rax
    mov rax, 1
    imul rax, 8
    mov rcx, [rbp - 24]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 24
    push rax
    mov rax, [rbp - 24]
    pop r10
    add rax, r10
    mov rsp, rbp
    pop rbp
    ret
end_if_6:
end_if_5:
    mov rax, [rbp - 24]
    mov QWORD [rbp - 32], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 2
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov QWORD [rbp - 24], rax
    jmp while_4
end_while_4:
    mov rax, 24
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    add rax, r10
    mov QWORD [rbp - 40], rax
    mov rax, 4096
    mov QWORD [rbp - 48], rax
while_7:
    mov rax, QWORD [rbp - 40]
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_7
    mov rax, 4096
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    add rax, r10
    mov QWORD [rbp - 48], rax
    jmp while_7
end_while_7:
    mov rax, QWORD [rbp - 48]
    mov rdi, rax
    call std__os_alloc_pages___0
    mov QWORD [rbp - 56], rax
    mov rax, 0
    push rax
    mov rax, [rbp - 56]
    pop r10
    cmp rax, r10
    setle al
    movzx rax, al
    cmp rax, 0
    je end_if_8
if_8:
    lea rax, [rel str_9]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_8:
    mov rax, QWORD [rbp - 8]
    push rax
    mov rax, 0
    imul rax, 8
    mov rcx, [rbp - 56]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 0
    push rax
    mov rax, 1
    imul rax, 8
    mov rcx, [rbp - 56]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, QWORD [rbp - 40]
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    sub rax, r10
    mov QWORD [rbp - 64], rax
    mov rax, 32
    push rax
    mov rax, QWORD [rbp - 64]
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je else_10
if_10:
    mov rax, QWORD [rbp - 8]
    push rax
    mov rax, 24
    push rax
    mov rax, [rbp - 56]
    pop r10
    add rax, r10
    pop r10
    add rax, r10
    mov QWORD [rbp - 72], rax
    mov rax, 24
    push rax
    mov rax, QWORD [rbp - 64]
    pop r10
    sub rax, r10
    push rax
    mov rax, 0
    imul rax, 8
    mov rcx, [rbp - 72]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, 1
    imul rax, 8
    mov rcx, [rbp - 72]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 0
    push rax
    mov rax, 2
    imul rax, 8
    mov rcx, [rbp - 72]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, [rbp - 72]
    push rax
    mov rax, 2
    imul rax, 8
    mov rcx, [rbp - 56]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    jmp end_if_10
else_10:
    mov rax, 24
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    sub rax, r10
    push rax
    mov rax, 0
    imul rax, 8
    mov rcx, [rbp - 56]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 0
    push rax
    mov rax, 2
    imul rax, 8
    mov rcx, [rbp - 56]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
end_if_10:
    mov rax, 0
    push rax
    mov rax, [rbp - 32]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je else_11
if_11:
    mov rax, [rbp - 56]
    push rax
    mov rax, 2
    imul rax, 8
    mov rcx, [rbp - 32]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    jmp end_if_11
else_11:
    mov rax, [rbp - 56]
    mov QWORD [malloc_list_head], rax
end_if_11:
    mov rax, 24
    push rax
    mov rax, [rbp - 56]
    pop r10
    add rax, r10
    mov rsp, rbp
    pop rbp
    ret


std__malloc___1:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, QWORD [rbp - 8]
    mov rdi, rax
    call std__malloc___0
    mov rsp, rbp
    pop rbp
    ret


std__memcpy:
    push rbp
    mov rbp, rsp
    sub rsp, 96

    mov [rbp - 8], rdx
    mov [rbp - 16], rsi
    mov [rbp - 24], rdi
    mov rax, 8
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    mov r10, r10
    push rdx
    cqo
    idiv r10
    pop rdx
    mov QWORD [rbp - 32], rax
    mov rax, 8
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    mov r10, r10
    push rdx
    cqo
    idiv r10
    mov rax, rdx
    pop rdx
    mov QWORD [rbp - 40], rax
    mov rax, [rbp - 24]
    mov QWORD [rbp - 48], rax
    mov rax, [rbp - 16]
    mov QWORD [rbp - 56], rax
    mov rax, 0
    mov QWORD [rbp - 64], rax
for_start_12:
    mov rax, QWORD [rbp - 32]
    push rax
    mov rax, QWORD [rbp - 64]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_12
    mov rax, [rbp - 56]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, 8
    mov rcx, [rbp - 48]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 64]
    pop r10
    add rax, r10
    mov QWORD [rbp - 64], rax
    jmp for_start_12
for_end_12:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je end_if_13
if_13:
    mov rax, [rbp - 24]
    mov QWORD [rbp - 72], rax
    mov rax, [rbp - 16]
    mov QWORD [rbp - 80], rax
    mov rax, 8
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    imul rax, r10
    mov QWORD [rbp - 88], rax
    mov rax, 0
    mov QWORD [rbp - 96], rax
for_start_14:
    mov rax, QWORD [rbp - 40]
    push rax
    mov rax, QWORD [rbp - 96]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_14
    mov rax, [rbp - 80]
    push rax
    mov rax, QWORD [rbp - 96]
    push rax
    mov rax, QWORD [rbp - 88]
    pop r10
    add rax, r10
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    push rax
    mov rax, QWORD [rbp - 96]
    push rax
    mov rax, QWORD [rbp - 88]
    pop r10
    add rax, r10
    imul rax, 1
    mov rcx, [rbp - 72]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 96]
    pop r10
    add rax, r10
    mov QWORD [rbp - 96], rax
    jmp for_start_14
for_end_14:
end_if_13:
    mov rax, [rbp - 24]
    mov rsp, rbp
    pop rbp
    ret


std__free:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_15
if_15:
    mov rsp, rbp
    pop rbp
    ret
end_if_15:
    mov rax, 24
    push rax
    mov rax, [rbp - 8]
    pop r10
    sub rax, r10
    mov QWORD [rbp - 16], rax
    mov rax, 1
    push rax
    mov rax, 1
    imul rax, 8
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rsp, rbp
    pop rbp
    ret


std__atoi:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rdi
    mov rax, 0
    mov QWORD [rbp - 16], rax
    mov rax, 0
    mov QWORD [rbp - 24], rax
    mov rax, 0
    mov QWORD [rbp - 32], rax
while_16:
    mov rax, 32
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_while_16
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    jmp while_16
end_while_16:
    mov rax, 45
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_17
if_17:
    mov rax, 1
    mov QWORD [rbp - 32], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
end_if_17:
while_18:
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_while_18
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    mov BYTE [rbp - 33], al
    mov rax, 48
    push rax
    mov al, BYTE [rbp - 33]
    pop r10
    cmp al, r10b
    setl al
    cmp rax, 0
    je end_if_19
if_19:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_20
if_20:
    mov rax, QWORD [rbp - 16]
    neg rax
    mov rsp, rbp
    pop rbp
    ret
end_if_20:
    mov rax, QWORD [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret
end_if_19:
    mov rax, 57
    push rax
    mov al, BYTE [rbp - 33]
    pop r10
    cmp al, r10b
    setg al
    cmp rax, 0
    je end_if_21
if_21:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_22
if_22:
    mov rax, QWORD [rbp - 16]
    neg rax
    mov rsp, rbp
    pop rbp
    ret
end_if_22:
    mov rax, QWORD [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret
end_if_21:
    mov rax, 48
    push rax
    mov al, BYTE [rbp - 33]
    movzx rax, al
    pop r10
    sub rax, r10
    mov QWORD [rbp - 41], rax
    mov rax, QWORD [rbp - 41]
    push rax
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    imul rax, r10
    pop r10
    add rax, r10
    mov QWORD [rbp - 16], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    jmp while_18
end_while_18:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_23
if_23:
    mov rax, QWORD [rbp - 16]
    neg rax
    mov rsp, rbp
    pop rbp
    ret
end_if_23:
    mov rax, QWORD [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret


std__print_newline:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov rax, 10
    push rax
    mov rax, 0
    imul rax, 1
    lea rcx, [rbp - 1]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 1
    mov rsi, rax
    lea rax, [rbp - 1]
    mov rdi, rax
    call std__write_bytes___0
    mov rsp, rbp
    pop rbp
    ret


std__print_char:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 1], dil
    mov al, BYTE [rbp - 1]
    push rax
    mov rax, 0
    imul rax, 1
    lea rcx, [rbp - 2]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 1
    mov rsi, rax
    lea rax, [rbp - 2]
    mov rdi, rax
    call std__write_bytes___0
    mov rsp, rbp
    pop rbp
    ret


std__println_char:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 1], dil
    mov al, BYTE [rbp - 1]
    mov dil, al
    call std__print_char
    call std__print_newline
    mov rsp, rbp
    pop rbp
    ret


std__write_number:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    mov rax, 24
    mov QWORD [rbp - 48], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_24
if_24:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    sub rax, r10
    mov QWORD [rbp - 48], rax
    mov rax, 48
    push rax
    mov rax, QWORD [rbp - 48]
    imul rax, 1
    lea rcx, [rbp - 40]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
end_if_24:
while_25:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je end_while_25
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    sub rax, r10
    mov QWORD [rbp - 48], rax
    mov rax, 48
    push rax
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    mov r10, r10
    push rdx
    xor rdx, rdx
    div r10
    mov rax, rdx
    pop rdx
    pop r10
    add rax, r10
    push rax
    mov rax, QWORD [rbp - 48]
    imul rax, 1
    lea rcx, [rbp - 40]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    mov r10, r10
    push rdx
    xor rdx, rdx
    div r10
    pop rdx
    mov QWORD [rbp - 16], rax
    jmp while_25
end_while_25:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_26
if_26:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    sub rax, r10
    mov QWORD [rbp - 48], rax
    mov rax, 45
    push rax
    mov rax, QWORD [rbp - 48]
    imul rax, 1
    lea rcx, [rbp - 40]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
end_if_26:
    lea rax, [rbp - 40]
    mov QWORD [rbp - 56], rax
    mov rax, QWORD [rbp - 48]
    push rax
    mov rax, 24
    pop r10
    sub rax, r10
    mov rsi, rax
    mov rax, QWORD [rbp - 48]
    push rax
    mov rax, [rbp - 56]
    pop r10
    add rax, r10
    mov rdi, rax
    call std__write_bytes___0
    mov rsp, rbp
    pop rbp
    ret


std__print_num:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je else_27
if_27:
    mov rax, 1
    mov rsi, rax
    mov rax, QWORD [rbp - 8]
    push rax
    mov rax, 0
    pop r10
    sub rax, r10
    mov rdi, rax
    call std__write_number
    jmp end_if_27
else_27:
    mov rax, 0
    mov rsi, rax
    mov rax, QWORD [rbp - 8]
    mov rdi, rax
    call std__write_number
end_if_27:
    mov rsp, rbp
    pop rbp
    ret


std__print_num_u:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, 0
    mov rsi, rax
    mov rax, QWORD [rbp - 8]
    mov rdi, rax
    call std__write_number
    mov rsp, rbp
    pop rbp
    ret


std__print___0:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, 0
    mov QWORD [rbp - 16], rax
while_28:
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 16]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_while_28
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    mov QWORD [rbp - 16], rax
    jmp while_28
end_while_28:
    mov rax, QWORD [rbp - 16]
    mov rsi, rax
    mov rax, [rbp - 8]
    mov rdi, rax
    call std__write_bytes___0
    mov rsp, rbp
    pop rbp
    ret


std__print___1:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, QWORD [rbp - 8]
    mov rdi, rax
    call std__print_num
    mov rsp, rbp
    pop rbp
    ret


std__print___2:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 4], edi
    mov eax, DWORD [rbp - 4]
    movsxd rax, eax
    mov rdi, rax
    call std__print___1
    mov rsp, rbp
    pop rbp
    ret


std__print___3:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 2], di
    mov ax, WORD [rbp - 2]
    movsx rax, ax
    mov rdi, rax
    call std__print___1
    mov rsp, rbp
    pop rbp
    ret


std__print___4:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 1], dil
    mov al, BYTE [rbp - 1]
    movsx rax, al
    mov rdi, rax
    call std__print___1
    mov rsp, rbp
    pop rbp
    ret


std__print___5:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, QWORD [rbp - 8]
    mov rdi, rax
    call std__print_num_u
    mov rsp, rbp
    pop rbp
    ret


std__print___6:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 4], edi
    mov eax, DWORD [rbp - 4]
    mov eax, eax
    mov rdi, rax
    call std__print___5
    mov rsp, rbp
    pop rbp
    ret


std__print___7:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 2], di
    mov ax, WORD [rbp - 2]
    movzx rax, ax
    mov rdi, rax
    call std__print___5
    mov rsp, rbp
    pop rbp
    ret


std__print___8:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 1], dil
    mov al, BYTE [rbp - 1]
    movzx rax, al
    mov rdi, rax
    call std__print___5
    mov rsp, rbp
    pop rbp
    ret


std__println___0:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, [rbp - 8]
    mov rdi, rax
    call std__print___0
    call std__print_newline
    mov rsp, rbp
    pop rbp
    ret


std__println___1:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, QWORD [rbp - 8]
    mov rdi, rax
    call std__print___1
    call std__print_newline
    mov rsp, rbp
    pop rbp
    ret


std__println___2:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 4], edi
    mov eax, DWORD [rbp - 4]
    movsxd rax, eax
    mov rdi, rax
    call std__println___1
    mov rsp, rbp
    pop rbp
    ret


std__println___3:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 2], di
    mov ax, WORD [rbp - 2]
    movsx rax, ax
    mov rdi, rax
    call std__println___1
    mov rsp, rbp
    pop rbp
    ret


std__println___4:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 1], dil
    mov al, BYTE [rbp - 1]
    movsx rax, al
    mov rdi, rax
    call std__println___1
    mov rsp, rbp
    pop rbp
    ret


std__println___5:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, QWORD [rbp - 8]
    mov rdi, rax
    call std__print___5
    call std__print_newline
    mov rsp, rbp
    pop rbp
    ret


std__println___6:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 4], edi
    mov eax, DWORD [rbp - 4]
    mov eax, eax
    mov rdi, rax
    call std__println___5
    mov rsp, rbp
    pop rbp
    ret


std__println___7:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 2], di
    mov ax, WORD [rbp - 2]
    movzx rax, ax
    mov rdi, rax
    call std__println___5
    mov rsp, rbp
    pop rbp
    ret


std__println___8:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 1], dil
    mov al, BYTE [rbp - 1]
    movzx rax, al
    mov rdi, rax
    call std__println___5
    mov rsp, rbp
    pop rbp
    ret


std__errno_to_num:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    lea rax, [rbp - 8]
    mov [rbp - 16], rax
    mov rax, [rax]
    cmp rax, 1
    je match_29_1
    cmp rax, 2
    je match_29_2
    cmp rax, 3
    je match_29_3
    cmp rax, 4
    je match_29_4
    cmp rax, 5
    je match_29_5
    cmp rax, 6
    je match_29_6
    cmp rax, 7
    je match_29_7
    cmp rax, 8
    je match_29_8
    cmp rax, 9
    je match_29_9
    cmp rax, 10
    je match_29_10
    cmp rax, 11
    je match_29_11
    cmp rax, 12
    je match_29_12
    cmp rax, 13
    je match_29_13
    cmp rax, 14
    je match_29_14
    cmp rax, 15
    je match_29_15
    cmp rax, 16
    je match_29_16
    cmp rax, 17
    je match_29_17
    cmp rax, 18
    je match_29_18
    cmp rax, 19
    je match_29_19
    cmp rax, 20
    je match_29_20
    cmp rax, 21
    je match_29_21
    cmp rax, 22
    je match_29_22
    cmp rax, 23
    je match_29_23
    cmp rax, 24
    je match_29_24
    cmp rax, 25
    je match_29_25
    cmp rax, 26
    je match_29_26
    cmp rax, 27
    je match_29_27
    cmp rax, 28
    je match_29_28
    cmp rax, 29
    je match_29_29
    cmp rax, 30
    je match_29_30
    cmp rax, 31
    je match_29_31
    cmp rax, 32
    je match_29_32
    cmp rax, 33
    je match_29_33
    cmp rax, 34
    je match_29_34
    cmp rax, 35
    je match_29_35
    cmp rax, 36
    je match_29_36
    cmp rax, 37
    je match_29_37
    cmp rax, 38
    je match_29_38
    jmp match_29_wildcard
    jmp match_end_29
match_29_1:
    mov rax, 1
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_2:
    mov rax, 2
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_3:
    mov rax, 3
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_4:
    mov rax, 4
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_5:
    mov rax, 5
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_6:
    mov rax, 6
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_7:
    mov rax, 7
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_8:
    mov rax, 8
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_9:
    mov rax, 9
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_10:
    mov rax, 10
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_11:
    mov rax, 11
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_12:
    mov rax, 12
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_13:
    mov rax, 13
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_14:
    mov rax, 14
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_15:
    mov rax, 15
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_16:
    mov rax, 16
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_17:
    mov rax, 17
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_18:
    mov rax, 18
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_19:
    mov rax, 19
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_20:
    mov rax, 20
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_21:
    mov rax, 21
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_22:
    mov rax, 22
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_23:
    mov rax, 23
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_24:
    mov rax, 24
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_25:
    mov rax, 25
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_26:
    mov rax, 26
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_27:
    mov rax, 27
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_28:
    mov rax, 28
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_29:
    mov rax, 29
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_30:
    mov rax, 30
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_31:
    mov rax, 31
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_32:
    mov rax, 32
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_33:
    mov rax, 33
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_34:
    mov rax, 34
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_35:
    mov rax, 35
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_36:
    mov rax, 36
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_37:
    mov rax, 37
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_38:
    mov rax, 38
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_29_wildcard:
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_29
match_end_29:


std__Err__u64_Errno:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, 1
    mov [rbp - 32], rax
    lea rax, [rbp - 16]
    lea r11, [rbp - 24]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


std__Ok__u64_Errno:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, 0
    mov [rbp - 32], rax
    mov rax, QWORD [rbp - 16]
    mov QWORD [rbp - 24], rax
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


std__handle_error__u64:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, QWORD [rbp - 16]
    neg rax
    mov QWORD [rbp - 24], rax
and_30:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je and_end_30
    mov rax, 38
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    cmp rax, r10
    setle al
    movzx rax, al
    cmp r10, 0
and_end_30:
    cmp rax, 0
    je else_31
if_31:
    mov rax, QWORD [rbp - 16]
    mov rsi, rax
    lea rdi, [rbp - 40]
    call std__num_to_errno
    mov QWORD [rbp - 32], rax
    lea rax, [rbp - 32]
    mov rax, [rax]
    mov rsi, rax
    lea rdi, [rbp - 48]
    call std__Err__u64_Errno
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp end_if_31
else_31:
    mov rax, QWORD [rbp - 16]
    mov rsi, rax
    lea rdi, [rbp - 40]
    call std__Ok__u64_Errno
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
end_if_31:


std__io__open___0:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov [rbp - 8], rdi
    mov [rbp - 16], rcx
    mov [rbp - 24], rdx
    mov [rbp - 32], rsi
    mov rax, 0
    mov r9, rax
    mov rax, 0
    mov r8, rax
    mov rax, QWORD [rbp - 16]
    mov rcx, rax
    mov rax, QWORD [rbp - 24]
    mov rdx, rax
    mov rax, [rbp - 32]
    mov rsi, rax
    mov rax, 2
    mov rdi, rax
    call std__syscall
    mov QWORD [rbp - 40], rax
    mov rax, QWORD [rbp - 40]
    mov rsi, rax
    lea rdi, [rbp - 56]
    call std__handle_error__u64
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


std__io__write___0:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov [rbp - 8], rdi
    mov [rbp - 16], rcx
    mov [rbp - 24], rdx
    mov [rbp - 28], esi
    mov rax, 0
    mov r9, rax
    mov rax, 0
    mov r8, rax
    mov rax, QWORD [rbp - 16]
    mov rcx, rax
    mov rax, [rbp - 24]
    mov rdx, rax
    mov eax, DWORD [rbp - 28]
    mov eax, eax
    mov rsi, rax
    mov rax, 1
    mov rdi, rax
    call std__syscall
    mov QWORD [rbp - 36], rax
    mov rax, QWORD [rbp - 36]
    mov rsi, rax
    lea rdi, [rbp - 52]
    call std__handle_error__u64
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


std__io__read___0:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov [rbp - 8], rdi
    mov [rbp - 16], rcx
    mov [rbp - 24], rdx
    mov [rbp - 28], esi
    mov rax, 0
    mov r9, rax
    mov rax, 0
    mov r8, rax
    mov rax, QWORD [rbp - 16]
    mov rcx, rax
    mov rax, [rbp - 24]
    mov rdx, rax
    mov eax, DWORD [rbp - 28]
    mov eax, eax
    mov rsi, rax
    mov rax, 0
    mov rdi, rax
    call std__syscall
    mov QWORD [rbp - 36], rax
    mov rax, QWORD [rbp - 36]
    mov rsi, rax
    lea rdi, [rbp - 52]
    call std__handle_error__u64
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


std__Err__u32_Errno:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, 1
    mov [rbp - 32], rax
    lea rax, [rbp - 16]
    lea r11, [rbp - 24]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


std__Ok__u32_Errno:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    mov [rbp - 12], esi
    mov rax, 0
    mov [rbp - 28], rax
    mov eax, DWORD [rbp - 12]
    mov DWORD [rbp - 20], eax
    lea rax, [rbp - 28]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


std__handle_error__u32:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rdi
    mov [rbp - 12], esi
    mov eax, DWORD [rbp - 12]
    neg rax
    mov QWORD [rbp - 20], rax
and_32:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 20]
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je and_end_32
    mov rax, 38
    push rax
    mov rax, QWORD [rbp - 20]
    pop r10
    cmp rax, r10
    setle al
    movzx rax, al
    cmp r10, 0
and_end_32:
    cmp rax, 0
    je else_33
if_33:
    mov eax, DWORD [rbp - 12]
    mov eax, eax
    mov rsi, rax
    lea rdi, [rbp - 36]
    call std__num_to_errno
    mov QWORD [rbp - 28], rax
    lea rax, [rbp - 28]
    mov rax, [rax]
    mov rsi, rax
    lea rdi, [rbp - 44]
    call std__Err__u32_Errno
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp end_if_33
else_33:
    mov eax, DWORD [rbp - 12]
    mov esi, eax
    lea rdi, [rbp - 36]
    call std__Ok__u32_Errno
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
end_if_33:


std__io__close___0:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rdi
    mov [rbp - 12], esi
    mov rax, 0
    mov r9, rax
    mov rax, 0
    mov r8, rax
    mov rax, 0
    mov rcx, rax
    mov rax, 0
    mov rdx, rax
    mov eax, DWORD [rbp - 12]
    mov eax, eax
    mov rsi, rax
    mov rax, 3
    mov rdi, rax
    call std__syscall
    mov QWORD [rbp - 20], rax
    mov rax, QWORD [rbp - 20]
    mov esi, eax
    lea rdi, [rbp - 36]
    call std__handle_error__u32
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


std__io__mkdir___0:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rdi
    mov [rbp - 16], rdx
    mov [rbp - 24], rsi
    mov rax, 0
    mov r9, rax
    mov rax, 0
    mov r8, rax
    mov rax, 0
    mov rcx, rax
    mov rax, QWORD [rbp - 16]
    mov rdx, rax
    mov rax, [rbp - 24]
    mov rsi, rax
    mov rax, 83
    mov rdi, rax
    call std__syscall
    mov DWORD [rbp - 28], eax
    mov eax, DWORD [rbp - 28]
    mov esi, eax
    lea rdi, [rbp - 44]
    call std__handle_error__u32
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


std__unwrap__u64_Errno:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    mov rax, [rbp - 8]
    mov [rbp - 16], rax
    mov rax, [rax]
    cmp rax, 0
    je match_34_0
    cmp rax, 1
    je match_34_1
    jmp match_end_34
match_34_0:
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 24], rax
    mov rax, QWORD [rbp - 24]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_34
match_34_1:
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 32], rax
    lea rax, [rel str_35]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
    jmp match_end_34
match_end_34:
    lea rax, [rel str_36]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0


std__io__input:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rdx
    mov [rbp - 16], rsi
    mov [rbp - 24], rdi
    mov rax, [rbp - 24]
    mov rdi, rax
    call std__print___0
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    sub rax, r10
    mov rcx, rax
    mov rax, [rbp - 16]
    mov rdx, rax
    mov rax, 0
    mov esi, eax
    lea rdi, [rbp - 56]
    call std__io__read___0
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 40], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 32], rdx
    lea rax, [rbp - 40]
    mov rdi, rax
    call std__unwrap__u64_Errno
    mov QWORD [rbp - 48], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 48]
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rsp, rbp
    pop rbp
    ret


proc__fork:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rdi
    mov rax, 0
    mov r9, rax
    mov rax, 0
    mov r8, rax
    mov rax, 0
    mov rcx, rax
    mov rax, 0
    mov rdx, rax
    mov rax, 0
    mov rsi, rax
    mov rax, 57
    mov rdi, rax
    call std__syscall
    mov QWORD [rbp - 16], rax
    mov rax, QWORD [rbp - 16]
    mov rsi, rax
    lea rdi, [rbp - 32]
    call std__handle_error__u64
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


proc__execve:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov [rbp - 8], rdi
    mov [rbp - 16], rcx
    mov [rbp - 24], rdx
    mov [rbp - 32], rsi
    mov rax, 0
    mov r9, rax
    mov rax, 0
    mov r8, rax
    mov rax, [rbp - 16]
    mov rcx, rax
    mov rax, [rbp - 24]
    mov rdx, rax
    mov rax, [rbp - 32]
    mov rsi, rax
    mov rax, 59
    mov rdi, rax
    call std__syscall
    mov QWORD [rbp - 40], rax
    mov rax, QWORD [rbp - 40]
    mov rsi, rax
    lea rdi, [rbp - 56]
    call std__handle_error__u64
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


proc__wait4___0:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, 0
    mov DWORD [rbp - 20], eax
    mov rax, 0
    mov r9, rax
    mov rax, 0
    mov r8, rax
    mov rax, 0
    mov rcx, rax
    lea rax, [rbp - 20]
    mov rdx, rax
    mov rax, QWORD [rbp - 16]
    mov rsi, rax
    mov rax, 61
    mov rdi, rax
    call std__syscall
    mov QWORD [rbp - 28], rax
    mov rax, QWORD [rbp - 28]
    mov rsi, rax
    lea rdi, [rbp - 60]
    call std__handle_error__u64
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 44], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 36], rdx
    mov eax, DWORD [rbp - 20]
    movsxd rax, eax
    mov rsi, rax
    lea rdi, [rbp - 60]
    call std__Ok__u64_Errno
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


std__unwrap__u64_Errno__1:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    lea rax, [rbp - 16]
    mov [rbp - 24], rax
    mov rax, [rax]
    cmp rax, 0
    je match_37_0
    cmp rax, 1
    je match_37_1
    jmp match_end_37
match_37_0:
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 32], rax
    mov rax, QWORD [rbp - 32]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_37
match_37_1:
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 40], rax
    lea rax, [rel str_38]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
    jmp match_end_37
match_end_37:
    lea rax, [rel str_39]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0


proc__run_cmd___0:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    lea rdi, [rbp - 48]
    call proc__fork
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 32], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 24], rdx
    lea rax, [rbp - 32]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call std__unwrap__u64_Errno__1
    mov QWORD [rbp - 40], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je else_40
if_40:
    mov rax, 0
    push rax
    mov rax, 0
    imul rax, 8
    lea rcx, [rbp - 48]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    lea rax, [rbp - 48]
    mov rcx, rax
    mov rax, [rbp - 8]
    mov rdx, rax
    mov rax, [rbp - 16]
    mov rsi, rax
    lea rdi, [rbp - 64]
    call proc__execve
    mov rax, 1
    mov edi, eax
    call std__exit___0
    jmp end_if_40
else_40:
    mov rax, QWORD [rbp - 40]
    mov rsi, rax
    lea rdi, [rbp - 72]
    call proc__wait4___0
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 56], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 48], rdx
    lea rax, [rbp - 56]
    mov rdi, rax
    call std__unwrap__u64_Errno
    mov QWORD [rbp - 64], rax
    mov rax, QWORD [rbp - 64]
    mov rsp, rbp
    pop rbp
    ret
end_if_40:


proc__run_cmd_no_wait___0:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    lea rdi, [rbp - 48]
    call proc__fork
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 32], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 24], rdx
    lea rax, [rbp - 32]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call std__unwrap__u64_Errno__1
    mov QWORD [rbp - 40], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je else_41
if_41:
    mov rax, 0
    push rax
    mov rax, 0
    imul rax, 8
    lea rcx, [rbp - 48]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    lea rax, [rbp - 48]
    mov rcx, rax
    mov rax, [rbp - 8]
    mov rdx, rax
    mov rax, [rbp - 16]
    mov rsi, rax
    lea rdi, [rbp - 64]
    call proc__execve
    mov rax, 1
    mov edi, eax
    call std__exit___0
    jmp end_if_41
else_41:
    mov rax, QWORD [rbp - 40]
    mov rsp, rbp
    pop rbp
    ret
end_if_41:


string__to_string___0:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


string__to_string___1:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    mov rsp, rbp
    pop rbp
    ret


string__to_string___2:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov rax, [rbp + 16]
    mov [rbp - 24], rax
    mov rax, [rbp + 24]
    mov [rbp - 16], rax
    mov rax, [rbp + 32]
    mov [rbp - 8], rax
    mov rax, QWORD [rbp - 24]
    mov rsp, rbp
    pop rbp
    ret


string__to_string___3:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rdi
    mov rax, 32
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 16], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_42
if_42:
    mov rax, 48
    push rax
    mov rax, 0
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 0
    push rax
    mov rax, 1
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret
end_if_42:
    mov rax, 0
    mov QWORD [rbp - 24], rax
while_43:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je end_while_43
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    mov r10, r10
    push rdx
    xor rdx, rdx
    div r10
    mov rax, rdx
    pop rdx
    mov QWORD [rbp - 32], rax
    mov rax, 48
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    add al, r10b
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    mov r10, r10
    push rdx
    xor rdx, rdx
    div r10
    pop rdx
    mov QWORD [rbp - 8], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    jmp while_43
end_while_43:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 0
    mov QWORD [rbp - 32], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    sub rax, r10
    mov QWORD [rbp - 40], rax
while_44:
    mov rax, QWORD [rbp - 40]
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_44
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 32]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    mov BYTE [rbp - 41], al
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    push rax
    mov rax, QWORD [rbp - 32]
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov al, BYTE [rbp - 41]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    add rax, r10
    mov QWORD [rbp - 32], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    sub rax, r10
    mov QWORD [rbp - 40], rax
    jmp while_44
end_while_44:
    mov rax, [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret


string__strlen:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, 0
    mov QWORD [rbp - 16], rax
while_45:
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 16]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_while_45
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    mov QWORD [rbp - 16], rax
    jmp while_45
end_while_45:
    mov rax, QWORD [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret


string__to_string___4:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rdi
    mov rax, 32
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 16], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_46
if_46:
    mov rax, 48
    push rax
    mov rax, 0
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 0
    push rax
    mov rax, 1
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret
end_if_46:
    mov rax, 0
    mov QWORD [rbp - 24], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_if_47
if_47:
    mov rax, 1
    mov QWORD [rbp - 24], rax
    mov rax, QWORD [rbp - 8]
    push rax
    mov rax, 0
    pop r10
    sub rax, r10
    mov QWORD [rbp - 8], rax
end_if_47:
    mov rax, 0
    mov QWORD [rbp - 32], rax
while_48:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je end_while_48
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    mov r10, r10
    push rdx
    cqo
    idiv r10
    mov rax, rdx
    pop rdx
    mov QWORD [rbp - 40], rax
    mov rax, 48
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    add al, r10b
    push rax
    mov rax, QWORD [rbp - 32]
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    mov r10, r10
    push rdx
    cqo
    idiv r10
    pop rdx
    mov QWORD [rbp - 8], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    add rax, r10
    mov QWORD [rbp - 32], rax
    jmp while_48
end_while_48:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je end_if_49
if_49:
    mov rax, 45
    push rax
    mov rax, QWORD [rbp - 32]
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    add rax, r10
    mov QWORD [rbp - 32], rax
end_if_49:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 32]
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 0
    mov QWORD [rbp - 40], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    sub rax, r10
    mov QWORD [rbp - 48], rax
while_50:
    mov rax, QWORD [rbp - 48]
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_50
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    mov BYTE [rbp - 49], al
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 48]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov al, BYTE [rbp - 49]
    push rax
    mov rax, QWORD [rbp - 48]
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    add rax, r10
    mov QWORD [rbp - 40], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    sub rax, r10
    mov QWORD [rbp - 48], rax
    jmp while_50
end_while_50:
    mov rax, [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret


string__to_string___5:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 4], edi
    mov eax, DWORD [rbp - 4]
    movsxd rax, eax
    mov rdi, rax
    call string__to_string___4
    mov rsp, rbp
    pop rbp
    ret


string__new___0:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    mov rax, [rbp - 8]
    mov rdi, rax
    call string__strlen
    mov QWORD [rbp - 16], rax
    mov rax, 24
    mov rdi, rax
    call std__malloc___1
    mov QWORD [rbp - 24], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    mov rdi, rax
    call std__malloc___1
    mov QWORD [rbp - 32], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    mov rdx, rax
    mov rax, [rbp - 8]
    mov rsi, rax
    mov rax, [rbp - 32]
    mov rdi, rax
    call std__memcpy
    mov rax, [rbp - 32]
    mov rsi, [rbp - 24]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, QWORD [rbp - 16]
    mov rsi, [rbp - 24]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    mov rsi, [rbp - 24]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, [rbp - 24]
    mov rsp, rbp
    pop rbp
    ret


string__new___1:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov rax, 24
    mov rdi, rax
    call std__malloc___1
    mov QWORD [rbp - 8], rax
    mov rax, 16
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 16], rax
    mov rax, 0
    push rax
    mov rax, 15
    imul rax, 1
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, [rbp - 16]
    mov rsi, [rbp - 8]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, 0
    mov rsi, [rbp - 8]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rax, 16
    mov rsi, [rbp - 8]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


string__new_value:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rdi
    mov rax, 16
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 16], rax
    mov rax, [rbp - 16]
    mov QWORD [rbp - 40], rax
    mov rax, 0
    mov QWORD [rbp - 32], rax
    mov rax, 16
    mov QWORD [rbp - 24], rax
    lea rax, [rbp - 40]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov r10, [rax + 16]
    mov [r11 + 16], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


string__from_c_string:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, 24
    mov rdi, rax
    call std__malloc___1
    mov QWORD [rbp - 16], rax
    mov rax, [rbp - 8]
    mov rdi, rax
    call string__strlen
    mov rsi, [rbp - 16]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__malloc___0
    mov rsi, [rbp - 16]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rdx, rax
    mov rax, [rbp - 8]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__memcpy
    mov rax, [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret


vector__new__u8__ptr:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov rax, 8
    mov DWORD [rbp - 4], eax
    mov rax, 8
    mov QWORD [rbp - 12], rax
    mov rax, QWORD [rbp - 12]
    push rax
    mov eax, DWORD [rbp - 4]
    pop r10
    imul eax, r10d
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 20], rax
    mov rax, 32
    mov rdi, rax
    call std__malloc___1
    mov QWORD [rbp - 28], rax
    mov rax, [rbp - 20]
    mov rsi, [rbp - 28]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, 0
    mov rsi, [rbp - 28]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rax, QWORD [rbp - 12]
    mov rsi, [rbp - 28]
    add rsi, 16
    mov QWORD [rsi], rax
    mov eax, DWORD [rbp - 4]
    mov rsi, [rbp - 28]
    add rsi, 24
    mov QWORD [rsi], rax
    mov rax, [rbp - 28]
    mov rsp, rbp
    pop rbp
    ret


vector__push__u8__ptr:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_56
if_56:
    mov rax, 2
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    imul rax, r10
    mov QWORD [rbp - 24], rax
    mov rax, [rbp - 16]
    add rax, 24
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    imul rax, r10
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 32], rax
    mov rax, [rbp - 16]
    add rax, 24
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    imul rax, r10
    mov rdx, rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    mov rsi, rax
    mov rax, [rbp - 32]
    mov rdi, rax
    call std__memcpy
    mov rax, [rbp - 32]
    mov rsi, [rbp - 16]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, QWORD [rbp - 24]
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
end_if_56:
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    imul rax, rax, 8
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    mov rax, [rbp - 16]
    add rax, 24
    mov rax, QWORD [rax]
    mov rdx, rax
    lea rax, [rbp - 8]
    mov rsi, rax
    mov rax, [rbp - 24]
    mov rdi, rax
    call std__memcpy
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rsp, rbp
    pop rbp
    ret


string__split:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 1], sil
    mov [rbp - 9], rdi
    call vector__new__u8__ptr
    mov QWORD [rbp - 17], rax
    mov rax, 0
    mov QWORD [rbp - 25], rax
    mov rax, [rbp - 9]
    mov QWORD [rbp - 33], rax
while_51:
    mov rax, 0
    push rax
    mov rax, [rbp - 9]
    push rax
    mov rax, QWORD [rbp - 25]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_while_51
    mov al, BYTE [rbp - 1]
    push rax
    mov rax, [rbp - 9]
    push rax
    mov rax, QWORD [rbp - 25]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_52
if_52:
    mov rax, [rbp - 33]
    push rax
    mov rax, QWORD [rbp - 25]
    push rax
    mov rax, [rbp - 9]
    pop r10
    add rax, r10
    pop r10
    sub rax, r10
    mov QWORD [rbp - 41], rax
and_53:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 41]
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je and_end_53
    mov rax, 10
    push rax
    mov rax, [rbp - 33]
    push rax
    mov rax, 0
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp r10, 0
and_end_53:
    cmp rax, 0
    je end_if_54
if_54:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 41]
    pop r10
    add rax, r10
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 49], rax
    mov rax, 0
    mov QWORD [rbp - 57], rax
while_55:
    mov rax, QWORD [rbp - 41]
    push rax
    mov rax, QWORD [rbp - 57]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_55
    mov rax, [rbp - 33]
    push rax
    mov rax, QWORD [rbp - 57]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    push rax
    mov rax, QWORD [rbp - 57]
    imul rax, 1
    mov rcx, [rbp - 49]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 57]
    pop r10
    add rax, r10
    mov QWORD [rbp - 57], rax
    jmp while_55
end_while_55:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 41]
    imul rax, 1
    mov rcx, [rbp - 49]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, [rbp - 49]
    mov rsi, rax
    mov rax, [rbp - 17]
    mov rdi, rax
    call vector__push__u8__ptr
end_if_54:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 25]
    push rax
    mov rax, [rbp - 9]
    pop r10
    add rax, r10
    pop r10
    add rax, r10
    mov QWORD [rbp - 33], rax
end_if_52:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 25]
    pop r10
    add rax, r10
    mov QWORD [rbp - 25], rax
    jmp while_51
end_while_51:
    mov rax, 0
    mov QWORD [rbp - 41], rax
while_57:
    mov rax, 0
    push rax
    mov rax, [rbp - 33]
    push rax
    mov rax, QWORD [rbp - 41]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_while_57
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 41]
    pop r10
    add rax, r10
    mov QWORD [rbp - 41], rax
    jmp while_57
end_while_57:
and_58:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 41]
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je and_end_58
    mov rax, 10
    push rax
    mov rax, [rbp - 33]
    push rax
    mov rax, 0
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp r10, 0
and_end_58:
    cmp rax, 0
    je end_if_59
if_59:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 41]
    pop r10
    add rax, r10
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 49], rax
    mov rax, 0
    mov QWORD [rbp - 57], rax
while_60:
    mov rax, QWORD [rbp - 41]
    push rax
    mov rax, QWORD [rbp - 57]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_60
    mov rax, [rbp - 33]
    push rax
    mov rax, QWORD [rbp - 57]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    push rax
    mov rax, QWORD [rbp - 57]
    imul rax, 1
    mov rcx, [rbp - 49]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 57]
    pop r10
    add rax, r10
    mov QWORD [rbp - 57], rax
    jmp while_60
end_while_60:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 41]
    imul rax, 1
    mov rcx, [rbp - 49]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, [rbp - 49]
    mov rsi, rax
    mov rax, [rbp - 17]
    mov rdi, rax
    call vector__push__u8__ptr
end_if_59:
    mov rax, [rbp - 17]
    mov rsp, rbp
    pop rbp
    ret


vector__get_element__u8__ptr:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    mov rax, QWORD [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setle al
    movzx rax, al
    cmp rax, 0
    je end_if_62
if_62:
    lea rax, [rel str_63]
    mov rdi, rax
    call std__print___0
    mov rax, QWORD [rbp - 8]
    mov rdi, rax
    call std__print___1
    lea rax, [rel str_64]
    mov rdi, rax
    call std__print___0
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__println___1
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_62:
    mov rax, QWORD [rbp - 8]
    imul rax, rax, 8
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    mov rax, [rbp - 24]
    mov rax, QWORD [rax]
    mov rsp, rbp
    pop rbp
    ret


string__get_file_name:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    mov rax, 47
    mov sil, al
    mov rax, [rbp - 8]
    mov rdi, rax
    call string__split
    mov QWORD [rbp - 16], rax
    mov rax, 0
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_61
if_61:
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
end_if_61:
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    sub rax, r10
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call vector__get_element__u8__ptr
    mov QWORD [rbp - 24], rax
    mov rax, 46
    mov sil, al
    mov rax, [rbp - 24]
    mov rdi, rax
    call string__split
    mov QWORD [rbp - 32], rax
    mov rax, 0
    mov rsi, rax
    mov rax, [rbp - 32]
    mov rdi, rax
    call vector__get_element__u8__ptr
    mov rsp, rbp
    pop rbp
    ret


string__strcmp___0:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je end_if_65
if_65:
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret
end_if_65:
    mov rax, 0
    mov QWORD [rbp - 24], rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    mov QWORD [rbp - 32], rax
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    mov QWORD [rbp - 40], rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    mov QWORD [rbp - 48], rax
while_66:
    mov rax, QWORD [rbp - 48]
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_66
    mov rax, [rbp - 32]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    mov BYTE [rbp - 49], al
    mov rax, [rbp - 40]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    mov BYTE [rbp - 50], al
    mov al, BYTE [rbp - 50]
    push rax
    mov al, BYTE [rbp - 49]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_if_67
if_67:
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret
end_if_67:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    jmp while_66
end_while_66:
    mov rax, 1
    mov rsp, rbp
    pop rbp
    ret


string__strcmp___1:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    push rax
    mov rax, 0
    push rax
    mov rax, [rbp - 16]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    pop r10
    cmp rax, 0
    setne al
    cmp r10, 0
    setne r10b
    or al, r10b
    movzx rax, al
    cmp rax, 0
    je end_if_68
if_68:
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret
end_if_68:
    mov rax, 0
    mov QWORD [rbp - 24], rax
while_69:
    mov rax, 0
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_while_69
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_if_70
if_70:
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret
end_if_70:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    jmp while_69
end_while_69:
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_if_71
if_71:
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret
end_if_71:
    mov rax, 1
    mov rsp, rbp
    pop rbp
    ret


string__free:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__free
    mov rax, [rbp - 8]
    mov rdi, rax
    call std__free
    mov rsp, rbp
    pop rbp
    ret


string__realloc:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, 1
    push rax
    mov rax, 2
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    imul rax, r10
    pop r10
    add rax, r10
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 16], rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    mov rdx, rax
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call std__memcpy
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__free
    mov rax, [rbp - 16]
    mov rsi, [rbp - 8]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, 2
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    imul rax, r10
    mov rsi, [rbp - 8]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, 0
    mov rsi, [rbp - 8]
    add rsi, 0
    push rax
    mov rax, 1
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    imul rax, 1
    mov rcx, [rsi]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rsp, rbp
    pop rbp
    ret


string__push___0:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 1], sil
    mov [rbp - 9], rdi
    mov rax, [rbp - 9]
    add rax, 8
    mov rax, QWORD [rax]
    mov QWORD [rbp - 17], rax
    mov rax, [rbp - 9]
    add rax, 16
    mov rax, QWORD [rax]
    push rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 17]
    pop r10
    add rax, r10
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je end_if_72
if_72:
    mov rax, [rbp - 9]
    mov rdi, rax
    call string__realloc
end_if_72:
    mov al, BYTE [rbp - 1]
    mov rsi, [rbp - 9]
    add rsi, 0
    push rax
    mov rax, QWORD [rbp - 17]
    imul rax, 1
    mov rcx, [rsi]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 17]
    pop r10
    add rax, r10
    mov rsi, [rbp - 9]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rsp, rbp
    pop rbp
    ret


string__push___1:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 1], dil
    mov rax, [rbp + 16]
    mov [rbp - 25], rax
    mov rax, [rbp + 24]
    mov [rbp - 17], rax
    mov rax, [rbp + 32]
    mov [rbp - 9], rax
    mov al, BYTE [rbp - 1]
    mov sil, al
    lea rax, [rbp - 25]
    mov rdi, rax
    call string__push___0
    mov rsp, rbp
    pop rbp
    ret


string__concat:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
while_73:
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je end_while_73
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__realloc
    jmp while_73
end_while_73:
    mov rax, 1
    push rax
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rdx, rax
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    mov rsi, rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rdi, rax
    call std__memcpy
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rsp, rbp
    pop rbp
    ret


string__clear:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, 0
    mov rsi, [rbp - 8]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rsp, rbp
    pop rbp
    ret


string__to_c_string:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    mov rsp, rbp
    pop rbp
    ret


std__print___9:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, 0
    mov QWORD [rbp - 16], rax
for_start_74:
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_74
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 16]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    mov dil, al
    call std__print_char
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    mov QWORD [rbp - 16], rax
    jmp for_start_74
for_end_74:
    mov rsp, rbp
    pop rbp
    ret


std__println___9:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, [rbp - 8]
    mov rdi, rax
    call std__print___9
    call std__print_newline
    mov rsp, rbp
    pop rbp
    ret


hashmap__hash64:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    mov rax, 0
    mov QWORD [rbp - 16], rax
    mov rax, 31
    mov QWORD [rbp - 24], rax
    mov rax, 0
    mov QWORD [rbp - 32], rax
while_75:
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 32]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_while_75
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 32]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    push rax
    mov rax, QWORD [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    imul rax, r10
    pop r10
    add rax, r10
    mov QWORD [rbp - 16], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    add rax, r10
    mov QWORD [rbp - 32], rax
    jmp while_75
end_while_75:
    mov rax, QWORD [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret


json__parse_string:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__parse_string_normal
    mov QWORD [rbp - 24], rax
    mov rax, 3
    mov [rbp - 40], rax
    mov rax, [rbp - 24]
    mov QWORD [rbp - 32], rax
    lea rax, [rbp - 40]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 40], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 32], rdx
    mov rax, 3
    mov [rbp - 56], rax
    mov rax, [rbp - 24]
    mov QWORD [rbp - 48], rax
    lea rax, [rbp - 56]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


json__parse_string_normal:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rdi
    mov rax, 1
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 8]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    mov QWORD [rbp - 16], rax
while_76:
    mov rax, 34
    push rax
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_while_76
    mov rax, 1
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 8]
    add rsi, 16
    mov QWORD [rsi], rax
    jmp while_76
end_while_76:
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    mov QWORD [rbp - 24], rax
    mov rax, QWORD [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    sub rax, r10
    mov QWORD [rbp - 32], rax
    mov rax, 1
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 8]
    add rsi, 16
    mov QWORD [rsi], rax
    call string__new___1
    mov QWORD [rbp - 40], rax
    mov rax, 0
    mov QWORD [rbp - 48], rax
while_77:
    mov rax, QWORD [rbp - 32]
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_77
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 48]
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    mov sil, al
    mov rax, [rbp - 40]
    mov rdi, rax
    call string__push___0
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    add rax, r10
    mov QWORD [rbp - 48], rax
    jmp while_77
end_while_77:
    mov rax, 0
    mov sil, al
    mov rax, [rbp - 40]
    mov rdi, rax
    call string__push___0
    mov rax, [rbp - 40]
    mov rsp, rbp
    pop rbp
    ret


json__skip_white_space:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
while_78:
and_79:
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je and_end_79
    mov rax, 32
    push rax
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    push rax
    mov rax, 10
    push rax
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    pop r10
    cmp rax, 0
    setne al
    cmp r10, 0
    setne r10b
    or al, r10b
    movzx rax, al
    cmp r10, 0
and_end_79:
    cmp rax, 0
    je end_while_78
    mov rax, 1
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 8]
    add rsi, 16
    mov QWORD [rsi], rax
    jmp while_78
end_while_78:
    mov rsp, rbp
    pop rbp
    ret


json__next_token:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 8], rdi
    mov rax, [rbp - 8]
    mov rdi, rax
    call json__skip_white_space
    mov rax, 1
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 8]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, [rbp - 8]
    mov rdi, rax
    call json__skip_white_space
    mov rsp, rbp
    pop rbp
    ret


vector__new__JsonValue:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov rax, 16
    mov DWORD [rbp - 4], eax
    mov rax, 8
    mov QWORD [rbp - 12], rax
    mov rax, QWORD [rbp - 12]
    push rax
    mov eax, DWORD [rbp - 4]
    pop r10
    imul eax, r10d
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 20], rax
    mov rax, 32
    mov rdi, rax
    call std__malloc___1
    mov QWORD [rbp - 28], rax
    mov rax, [rbp - 20]
    mov rsi, [rbp - 28]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, 0
    mov rsi, [rbp - 28]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rax, QWORD [rbp - 12]
    mov rsi, [rbp - 28]
    add rsi, 16
    mov QWORD [rsi], rax
    mov eax, DWORD [rbp - 4]
    mov rsi, [rbp - 28]
    add rsi, 24
    mov QWORD [rsi], rax
    mov rax, [rbp - 28]
    mov rsp, rbp
    pop rbp
    ret


vector__push__JsonValue:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rdx
    mov [rbp - 16], rsi
    mov [rbp - 24], rdi
    mov rax, [rbp - 24]
    add rax, 16
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_82
if_82:
    mov rax, 2
    push rax
    mov rax, [rbp - 24]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    imul rax, r10
    mov QWORD [rbp - 32], rax
    mov rax, [rbp - 24]
    add rax, 24
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    imul rax, r10
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 40], rax
    mov rax, [rbp - 24]
    add rax, 24
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    imul rax, r10
    mov rdx, rax
    mov rax, [rbp - 24]
    mov rax, QWORD [rax]
    mov rsi, rax
    mov rax, [rbp - 40]
    mov rdi, rax
    call std__memcpy
    mov rax, [rbp - 40]
    mov rsi, [rbp - 24]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, QWORD [rbp - 32]
    mov rsi, [rbp - 24]
    add rsi, 16
    mov QWORD [rsi], rax
end_if_82:
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, QWORD [rax]
    imul rax, rax, 16
    push rax
    mov rax, [rbp - 24]
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov QWORD [rbp - 32], rax
    mov rax, [rbp - 24]
    add rax, 24
    mov rax, QWORD [rax]
    mov rdx, rax
    lea rax, [rbp - 16]
    mov rsi, rax
    mov rax, [rbp - 32]
    mov rdi, rax
    call std__memcpy
    mov rax, 1
    push rax
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 24]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rsp, rbp
    pop rbp
    ret


json__parse_array:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__skip_white_space
    call vector__new__JsonValue
    mov QWORD [rbp - 24], rax
    mov rax, 93
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_80
if_80:
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, 4
    mov [rbp - 40], rax
    mov rax, [rbp - 24]
    mov QWORD [rbp - 32], rax
    lea rax, [rbp - 40]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
end_if_80:
while_81:
    mov rax, 1
    cmp rax, 0
    je end_while_81
    mov rax, [rbp - 16]
    mov rsi, rax
    lea rdi, [rbp - 56]
    call json__parse_object
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 40], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 32], rdx
    lea rax, [rbp - 40]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rdx, rax
    mov rax, [r10]
    mov rsi, rax
    mov rax, [rbp - 24]
    mov rdi, rax
    call vector__push__JsonValue
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__skip_white_space
    mov rax, 93
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je else_83
if_83:
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    jmp end_while_81
    jmp end_if_83
else_83:
    mov rax, 44
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je else_84
if_84:
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__skip_white_space
    mov rax, 93
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_85
if_85:
    lea rax, [rel str_86]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_85:
    jmp end_if_84
else_84:
    lea rax, [rel str_87]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_84:
end_if_83:
    jmp while_81
end_while_81:
    mov rax, 4
    mov [rbp - 40], rax
    mov rax, [rbp - 24]
    mov QWORD [rbp - 32], rax
    lea rax, [rbp - 40]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


json__parse_number:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, 0
    mov QWORD [rbp - 24], rax
    mov rax, 0
    mov QWORD [rbp - 32], rax
    mov rax, 45
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_88
if_88:
    mov rax, 1
    mov QWORD [rbp - 32], rax
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
end_if_88:
while_89:
    mov rax, 1
    cmp rax, 0
    je end_while_89
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    mov BYTE [rbp - 33], al
and_90:
    mov rax, 48
    push rax
    mov al, BYTE [rbp - 33]
    pop r10
    cmp al, r10b
    setge al
    cmp rax, 0
    je and_end_90
    mov rax, 57
    push rax
    mov al, BYTE [rbp - 33]
    pop r10
    cmp al, r10b
    setle al
    cmp r10, 0
and_end_90:
    cmp rax, 0
    je else_91
if_91:
    mov rax, 48
    push rax
    mov al, BYTE [rbp - 33]
    movzx rax, al
    pop r10
    sub rax, r10
    mov QWORD [rbp - 41], rax
    mov rax, QWORD [rbp - 41]
    push rax
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    imul rax, r10
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    jmp end_if_91
else_91:
    jmp end_while_89
end_if_91:
    jmp while_89
end_while_89:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_92
if_92:
    mov rax, QWORD [rbp - 24]
    push rax
    mov rax, 0
    pop r10
    sub rax, r10
    mov QWORD [rbp - 24], rax
end_if_92:
    mov rax, 2
    mov [rbp - 48], rax
    mov rax, QWORD [rbp - 24]
    mov QWORD [rbp - 40], rax
    lea rax, [rbp - 48]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


hashmap__new__String__ptr_JsonValue:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov rax, 16
    mov QWORD [rbp - 8], rax
    mov rax, QWORD [rbp - 8]
    push rax
    mov rax, 8
    pop r10
    imul rax, r10
    mov rdi, rax
    call std__malloc___1
    mov QWORD [rbp - 16], rax
    mov rax, 0
    mov QWORD [rbp - 24], rax
while_95:
    mov rax, QWORD [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_95
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, 8
    mov rcx, [rbp - 16]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    jmp while_95
end_while_95:
    mov rax, 24
    mov rdi, rax
    call std__malloc___1
    mov QWORD [rbp - 32], rax
    mov rax, [rbp - 16]
    mov rsi, [rbp - 32]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, QWORD [rbp - 8]
    mov rsi, [rbp - 32]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, 0
    mov rsi, [rbp - 32]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rax, [rbp - 32]
    mov rsp, rbp
    pop rbp
    ret


hashmap__check_hashmap_pos__String__ptr_JsonValue:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdx
    mov [rbp - 16], rsi
    mov [rbp - 24], rdi
    mov rax, [rbp - 24]
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 16]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov QWORD [rbp - 32], rax
    mov rax, 0
    push rax
    mov rax, [rbp - 32]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_100
if_100:
    mov rax, 1
    mov rsp, rbp
    pop rbp
    ret
end_if_100:
    mov rax, [rbp - 8]
    mov rsi, rax
    mov rax, [rbp - 32]
    add rax, 8
    mov rax, QWORD [rax]
    mov rdi, rax
    call string__strcmp___1
    cmp al, 0
    je else_101
if_101:
    mov rax, 2
    mov rsp, rbp
    pop rbp
    ret
    jmp end_if_101
else_101:
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret
end_if_101:


hashmap__hash_map_move__String__ptr_JsonValue:
    push rbp
    mov rbp, rsp
    sub rsp, 112

    mov eax, [rbp + 16]
    mov DWORD [rbp - 4], eax
    mov [rbp - 12], r9
    mov [rbp - 20], r8
    mov [rbp - 28], rcx
    mov [rbp - 36], rdx
    mov [rbp - 44], rsi
    mov [rbp - 52], rdi
    mov rax, 1
    push rax
    mov rax, [rbp - 52]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    sub rax, r10
    push rax
    mov rax, QWORD [rbp - 12]
    pop r10
    and rax, r10
    mov QWORD [rbp - 12], rax
    mov rax, [rbp - 36]
    mov rdx, rax
    mov rax, QWORD [rbp - 12]
    mov rsi, rax
    mov rax, [rbp - 52]
    mov rdi, rax
    call hashmap__check_hashmap_pos__String__ptr_JsonValue
    mov BYTE [rbp - 53], al
    mov rax, 1
    push rax
    mov al, BYTE [rbp - 53]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_102
if_102:
    mov rax, 48
    mov rdi, rax
    call std__malloc___1
    mov QWORD [rbp - 61], rax
    mov rax, [rbp - 44]
    mov rsi, [rbp - 61]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, [rbp - 36]
    mov rsi, [rbp - 61]
    add rsi, 8
    mov QWORD [rsi], rax
    lea rax, [rbp - 28]
    mov rsi, [rbp - 61]
    add rsi, 20
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rsi + 0], rdx
    mov rdx, [rcx + 8]
    mov [rsi + 8], rdx
    mov eax, DWORD [rbp - 4]
    mov rsi, [rbp - 61]
    add rsi, 16
    mov DWORD [rsi], eax
    mov rax, [rbp - 61]
    mov rsi, [rbp - 52]
    add rsi, 0
    push rax
    mov rax, QWORD [rbp - 12]
    imul rax, 8
    mov rcx, [rsi]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    mov rsp, rbp
    pop rbp
    ret
end_if_102:
    mov rax, [rbp - 52]
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 12]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov QWORD [rbp - 61], rax
    mov rax, 2
    push rax
    mov al, BYTE [rbp - 53]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_103
if_103:
    mov rax, [rbp - 36]
    push rax
    mov rax, [rbp - 61]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je end_if_104
if_104:
    mov rax, [rbp - 61]
    add rax, 8
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__free
    mov rax, [rbp - 36]
    mov rsi, [rbp - 61]
    add rsi, 8
    mov QWORD [rsi], rax
end_if_104:
    mov rax, [rbp - 44]
    mov rsi, [rbp - 61]
    add rsi, 0
    mov QWORD [rsi], rax
    lea rax, [rbp - 28]
    mov rsi, [rbp - 61]
    add rsi, 20
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rsi + 0], rdx
    mov rdx, [rcx + 8]
    mov [rsi + 8], rdx
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret
end_if_103:
    mov rax, [rbp - 61]
    add rax, 16
    mov eax, DWORD [rax]
    push rax
    mov eax, DWORD [rbp - 4]
    pop r10
    cmp eax, r10d
    setg al
    movzx eax, al
    cmp rax, 0
    je else_105
if_105:
    mov rax, [rbp - 61]
    mov rax, QWORD [rax]
    mov QWORD [rbp - 69], rax
    mov rax, [rbp - 61]
    add rax, 8
    mov rax, QWORD [rax]
    mov QWORD [rbp - 77], rax
    mov rax, [rbp - 61]
    add rax, 20
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 93], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 85], rdx
    mov rax, [rbp - 61]
    add rax, 16
    mov eax, DWORD [rax]
    mov DWORD [rbp - 97], eax
    mov rax, [rbp - 44]
    mov rsi, [rbp - 61]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, [rbp - 36]
    mov rsi, [rbp - 61]
    add rsi, 8
    mov QWORD [rsi], rax
    lea rax, [rbp - 28]
    mov rsi, [rbp - 61]
    add rsi, 20
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rsi + 0], rdx
    mov rdx, [rcx + 8]
    mov [rsi + 8], rdx
    mov eax, DWORD [rbp - 4]
    mov rsi, [rbp - 61]
    add rsi, 16
    mov DWORD [rsi], eax
    mov rax, 1
    push rax
    mov eax, DWORD [rbp - 97]
    pop r10
    add eax, r10d
    push rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 12]
    pop r10
    add rax, r10
    mov r9, rax
    lea rax, [rbp - 93]
    mov r10, rax
    mov rax, [r10 + 8]
    mov r8, rax
    mov rax, [r10]
    mov rcx, rax
    mov rax, [rbp - 77]
    mov rdx, rax
    mov rax, [rbp - 69]
    mov rsi, rax
    mov rax, [rbp - 52]
    mov rdi, rax
    call hashmap__hash_map_move__String__ptr_JsonValue
    mov rax, 1
    mov rsp, rbp
    pop rbp
    ret
    jmp end_if_105
else_105:
    mov rax, 1
    push rax
    mov eax, DWORD [rbp - 4]
    pop r10
    add eax, r10d
    push rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 12]
    pop r10
    add rax, r10
    mov r9, rax
    lea rax, [rbp - 28]
    mov r10, rax
    mov rax, [r10 + 8]
    mov r8, rax
    mov rax, [r10]
    mov rcx, rax
    mov rax, [rbp - 36]
    mov rdx, rax
    mov rax, [rbp - 44]
    mov rsi, rax
    mov rax, [rbp - 52]
    mov rdi, rax
    call hashmap__hash_map_move__String__ptr_JsonValue
    mov rsp, rbp
    pop rbp
    ret
end_if_105:


hashmap__hash_map_move_pair__String__ptr_JsonValue:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdx
    mov [rbp - 16], rsi
    mov [rbp - 24], rdi
    mov rax, 1
    push rax
    mov rax, [rbp - 24]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    sub rax, r10
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    and rax, r10
    mov QWORD [rbp - 8], rax
    mov rax, [rbp - 24]
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 8]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov QWORD [rbp - 32], rax
    mov rax, 0
    push rax
    mov rax, [rbp - 32]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_111
if_111:
    mov rax, [rbp - 16]
    mov rsi, [rbp - 24]
    add rsi, 0
    push rax
    mov rax, QWORD [rbp - 8]
    imul rax, 8
    mov rcx, [rsi]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rsp, rbp
    pop rbp
    ret
end_if_111:
    mov rax, [rbp - 32]
    add rax, 16
    mov eax, DWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov eax, DWORD [rax]
    pop r10
    cmp eax, r10d
    setg al
    movzx eax, al
    cmp rax, 0
    je else_112
if_112:
    mov rax, [rbp - 16]
    mov rsi, [rbp - 24]
    add rsi, 0
    push rax
    mov rax, QWORD [rbp - 8]
    imul rax, 8
    mov rcx, [rsi]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, [rbp - 32]
    add rax, 16
    mov eax, DWORD [rax]
    pop r10
    add eax, r10d
    mov rsi, [rbp - 32]
    add rsi, 16
    mov DWORD [rsi], eax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    add rax, r10
    mov rdx, rax
    mov rax, [rbp - 32]
    mov rsi, rax
    mov rax, [rbp - 24]
    mov rdi, rax
    call hashmap__hash_map_move_pair__String__ptr_JsonValue
    jmp end_if_112
else_112:
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov eax, DWORD [rax]
    pop r10
    add eax, r10d
    mov rsi, [rbp - 16]
    add rsi, 16
    mov DWORD [rsi], eax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    add rax, r10
    mov rdx, rax
    mov rax, [rbp - 16]
    mov rsi, rax
    mov rax, [rbp - 24]
    mov rdi, rax
    call hashmap__hash_map_move_pair__String__ptr_JsonValue
end_if_112:
    mov rsp, rbp
    pop rbp
    ret


hashmap__hashmap_check_resize__String__ptr_JsonValue:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov [rbp - 8], rdi
    mov rax, 65
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    imul rax, r10
    push rax
    mov rax, 100
    push rax
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    imul rax, r10
    pop r10
    cmp rax, r10
    setle al
    movzx rax, al
    cmp rax, 0
    je end_if_107
if_107:
    mov rsp, rbp
    pop rbp
    ret
end_if_107:
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    mov QWORD [rbp - 16], rax
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    mov QWORD [rbp - 24], rax
    mov rax, 2
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    imul rax, r10
    mov QWORD [rbp - 32], rax
    mov rax, QWORD [rbp - 32]
    push rax
    mov rax, 8
    pop r10
    imul rax, r10
    mov rdi, rax
    call std__malloc___1
    mov QWORD [rbp - 40], rax
    mov rax, 0
    mov QWORD [rbp - 48], rax
while_108:
    mov rax, QWORD [rbp - 32]
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_108
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 48]
    imul rax, 8
    mov rcx, [rbp - 40]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    add rax, r10
    mov QWORD [rbp - 48], rax
    jmp while_108
end_while_108:
    mov rax, [rbp - 40]
    mov rsi, [rbp - 8]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, QWORD [rbp - 32]
    mov rsi, [rbp - 8]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, 0
    mov QWORD [rbp - 48], rax
while_109:
    mov rax, QWORD [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_109
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 48]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov QWORD [rbp - 56], rax
    mov rax, 0
    push rax
    mov rax, [rbp - 56]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je end_if_110
if_110:
    mov rax, 0
    mov rsi, [rbp - 56]
    add rsi, 16
    mov DWORD [rsi], eax
    mov rax, [rbp - 56]
    add rax, 8
    mov rax, QWORD [rax]
    mov rdi, rax
    call hashmap__hash64
    mov QWORD [rbp - 64], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    sub rax, r10
    push rax
    mov rax, QWORD [rbp - 64]
    pop r10
    and rax, r10
    mov QWORD [rbp - 72], rax
    mov rax, QWORD [rbp - 72]
    mov rdx, rax
    mov rax, [rbp - 56]
    mov rsi, rax
    mov rax, [rbp - 8]
    mov rdi, rax
    call hashmap__hash_map_move_pair__String__ptr_JsonValue
end_if_110:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    add rax, r10
    mov QWORD [rbp - 48], rax
    jmp while_109
end_while_109:
    mov rax, [rbp - 24]
    mov rdi, rax
    call std__free
    mov rsp, rbp
    pop rbp
    ret


hashmap__insert__String__ptr_JsonValue:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rcx
    mov [rbp - 16], rdx
    mov [rbp - 24], rsi
    mov [rbp - 32], rdi
    mov rax, [rbp - 24]
    mov rdi, rax
    call string__to_string___1
    mov QWORD [rbp - 40], rax
    mov rax, [rbp - 40]
    mov rdi, rax
    call hashmap__hash64
    mov QWORD [rbp - 48], rax
    mov rax, 1
    push rax
    mov rax, [rbp - 32]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    sub rax, r10
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    and rax, r10
    mov QWORD [rbp - 56], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 56]
    mov r9, rax
    lea rax, [rbp - 16]
    mov r10, rax
    mov rax, [r10 + 8]
    mov r8, rax
    mov rax, [r10]
    mov rcx, rax
    mov rax, [rbp - 40]
    mov rdx, rax
    mov rax, [rbp - 24]
    mov rsi, rax
    mov rax, [rbp - 32]
    mov rdi, rax
    call hashmap__hash_map_move__String__ptr_JsonValue
    mov BYTE [rbp - 57], al
    mov al, BYTE [rbp - 57]
    cmp al, 0
    je end_if_106
if_106:
    mov rax, 1
    push rax
    mov rax, [rbp - 32]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 32]
    add rsi, 8
    mov QWORD [rsi], rax
end_if_106:
    mov rax, [rbp - 32]
    mov rdi, rax
    call hashmap__hashmap_check_resize__String__ptr_JsonValue
    mov rsp, rbp
    pop rbp
    ret


json__parse_object:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__skip_white_space
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_if_93
if_93:
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    mov [rbp - 24], rax
    cmp rax, 123
    je match_94_123
    cmp rax, 91
    je match_94_91
    cmp rax, 34
    je match_94_34
    cmp rax, 116
    je match_94_116
    cmp rax, 102
    je match_94_102
    cmp rax, 110
    je match_94_110
    jmp match_94_wildcard
    jmp match_end_94
match_94_123:
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    call hashmap__new__String__ptr_JsonValue
    mov QWORD [rbp - 32], rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__skip_white_space
    mov rax, 125
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_96
if_96:
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, 5
    mov [rbp - 48], rax
    mov rax, [rbp - 32]
    mov QWORD [rbp - 40], rax
    lea rax, [rbp - 48]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
end_if_96:
while_97:
    mov rax, 1
    cmp rax, 0
    je end_while_97
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__parse_string_normal
    mov QWORD [rbp - 40], rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__skip_white_space
    mov rax, 58
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_if_98
if_98:
    lea rax, [rel str_99]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_98:
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__skip_white_space
    mov rax, [rbp - 16]
    mov rsi, rax
    lea rdi, [rbp - 72]
    call json__parse_object
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 56], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 48], rdx
    lea rax, [rbp - 56]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rcx, rax
    mov rax, [r10]
    mov rdx, rax
    mov rax, [rbp - 40]
    mov rsi, rax
    mov rax, [rbp - 32]
    mov rdi, rax
    call hashmap__insert__String__ptr_JsonValue
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__skip_white_space
    mov rax, 125
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je else_113
if_113:
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    jmp end_while_97
    jmp end_if_113
else_113:
    mov rax, 44
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je else_114
if_114:
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__skip_white_space
    mov rax, 125
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_115
if_115:
    lea rax, [rel str_116]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_115:
    jmp end_if_114
else_114:
    lea rax, [rel str_117]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_114:
end_if_113:
    jmp while_97
end_while_97:
    mov rax, 5
    mov [rbp - 48], rax
    mov rax, [rbp - 32]
    mov QWORD [rbp - 40], rax
    lea rax, [rbp - 48]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 48], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 40], rdx
    lea rax, [rbp - 48]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_94
match_94_91:
    mov rax, [rbp - 16]
    mov rsi, rax
    lea rdi, [rbp - 40]
    call json__parse_array
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_94
match_94_34:
    mov rax, [rbp - 16]
    mov rsi, rax
    lea rdi, [rbp - 40]
    call json__parse_string
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_94
match_94_116:
    mov rax, 4
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, 1
    mov [rbp - 40], rax
    mov rax, 1
    mov BYTE [rbp - 32], al
    lea rax, [rbp - 40]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_94
match_94_102:
    mov rax, 5
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, 1
    mov [rbp - 40], rax
    mov rax, 0
    mov BYTE [rbp - 32], al
    lea rax, [rbp - 40]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_94
match_94_110:
    mov rax, 4
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
    mov QWORD [rbp - 40], 0
    lea rax, [rbp - 40]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_94
match_94_wildcard:
    mov rax, [rbp - 16]
    mov rsi, rax
    lea rdi, [rbp - 40]
    call json__parse_number
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_94
match_end_94:
end_if_93:
    lea rax, [rel str_118]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0


json__parse:
    push rbp
    mov rbp, rsp
    sub rsp, 4192

    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    mov rax, 0
    mov rcx, rax
    mov rax, 0
    mov rdx, rax
    mov rax, [rbp - 16]
    mov rsi, rax
    lea rdi, [rbp - 4152]
    call std__io__open___0
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call std__unwrap__u64_Errno__1
    mov QWORD [rbp - 4120], rax
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    mov rax, 4096
    mov rcx, rax
    lea rax, [rbp - 4112]
    mov rdx, rax
    mov rax, QWORD [rbp - 4120]
    mov esi, eax
    lea rdi, [rbp - 4160]
    call std__io__read___0
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call std__unwrap__u64_Errno__1
    mov QWORD [rbp - 4128], rax
    lea rax, [rbp - 4112]
    mov QWORD [rbp - 4152], rax
    mov rax, QWORD [rbp - 4128]
    mov QWORD [rbp - 4144], rax
    mov rax, 0
    mov QWORD [rbp - 4136], rax
    lea rax, [rbp - 4152]
    mov rsi, rax
    lea rdi, [rbp - 4184]
    call json__parse_object
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 4168], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 4160], rdx
    lea rax, [rbp - 4168]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


vector__get_element__JsonValue:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rdi
    mov [rbp - 16], rdx
    mov [rbp - 24], rsi
    mov rax, QWORD [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setle al
    movzx rax, al
    cmp rax, 0
    je end_if_128
if_128:
    lea rax, [rel str_129]
    mov rdi, rax
    call std__print___0
    mov rax, QWORD [rbp - 16]
    mov rdi, rax
    call std__print___1
    lea rax, [rel str_130]
    mov rdi, rax
    call std__print___0
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__println___1
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_128:
    mov rax, QWORD [rbp - 16]
    imul rax, rax, 16
    push rax
    mov rax, [rbp - 24]
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov QWORD [rbp - 32], rax
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


hashmap__get_move__String__ptr_JsonValue:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rcx
    mov [rbp - 16], rdx
    mov [rbp - 24], rsi
    mov [rbp - 32], rdi
    mov rax, 1
    push rax
    mov rax, [rbp - 32]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    sub rax, r10
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    and rax, r10
    mov QWORD [rbp - 16], rax
    mov rax, [rbp - 32]
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 16]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov QWORD [rbp - 40], rax
    mov rax, [rbp - 40]
    add rax, 16
    mov eax, DWORD [rax]
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    push rax
    mov rax, 0
    push rax
    mov rax, [rbp - 40]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    pop r10
    cmp rax, 0
    setne al
    cmp r10, 0
    setne r10b
    or al, r10b
    movzx rax, al
    cmp rax, 0
    je end_if_136
if_136:
    lea rax, [rel str_137]
    mov rdi, rax
    call std__print___0
    mov rax, [rbp - 24]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_136:
    mov rax, [rbp - 24]
    mov rsi, rax
    mov rax, [rbp - 40]
    add rax, 8
    mov rax, QWORD [rax]
    mov rdi, rax
    call string__strcmp___1
    cmp al, 0
    je else_138
if_138:
    mov rax, QWORD [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret
    jmp end_if_138
else_138:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    add rax, r10
    mov rcx, rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    mov rdx, rax
    mov rax, [rbp - 24]
    mov rsi, rax
    mov rax, [rbp - 32]
    mov rdi, rax
    call hashmap__get_move__String__ptr_JsonValue
    mov rsp, rbp
    pop rbp
    ret
end_if_138:


hashmap__get__String__ptr_JsonValue:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov [rbp - 8], rdi
    mov [rbp - 16], rdx
    mov [rbp - 24], rsi
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__to_string___1
    mov QWORD [rbp - 32], rax
    mov rax, [rbp - 32]
    mov rdi, rax
    call hashmap__hash64
    mov QWORD [rbp - 40], rax
    mov rax, 1
    push rax
    mov rax, [rbp - 24]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    sub rax, r10
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    and rax, r10
    mov QWORD [rbp - 48], rax
    mov rax, 0
    mov rcx, rax
    mov rax, QWORD [rbp - 48]
    mov rdx, rax
    mov rax, [rbp - 32]
    mov rsi, rax
    mov rax, [rbp - 24]
    mov rdi, rax
    call hashmap__get_move__String__ptr_JsonValue
    mov QWORD [rbp - 56], rax
    mov rax, [rbp - 24]
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 56]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov QWORD [rbp - 64], rax
    mov rax, [rbp - 64]
    add rax, 20
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 80], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 72], rdx
    mov rax, [rbp - 32]
    mov rdi, rax
    call std__free
    lea rax, [rbp - 80]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


json__get:
    push rbp
    mov rbp, rsp
    sub rsp, 112

    mov [rbp - 8], rdi
    mov [rbp - 16], rcx
    mov [rbp - 24], rdx
    mov [rbp - 32], rsi
    mov rax, 0
    mov QWORD [rbp - 40], rax
while_119:
    mov rax, 0
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_while_119
    mov rax, 46
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_120
if_120:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    add rax, r10
    mov QWORD [rbp - 40], rax
end_if_120:
    mov rax, 0
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_121
if_121:
    jmp end_while_119
end_if_121:
    mov rax, 91
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je else_122
if_122:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    add rax, r10
    mov QWORD [rbp - 40], rax
    mov rax, 0
    mov QWORD [rbp - 48], rax
while_123:
and_124:
    mov rax, 48
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setge al
    cmp rax, 0
    je and_end_124
    mov rax, 57
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setle al
    cmp r10, 0
and_end_124:
    cmp rax, 0
    je end_while_123
    mov rax, 48
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    movzx rax, al
    pop r10
    sub rax, r10
    push rax
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    imul rax, r10
    pop r10
    add rax, r10
    mov QWORD [rbp - 48], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    add rax, r10
    mov QWORD [rbp - 40], rax
    jmp while_123
end_while_123:
    mov rax, 93
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je else_125
if_125:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    add rax, r10
    mov QWORD [rbp - 40], rax
    jmp end_if_125
else_125:
    lea rax, [rel str_126]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_125:
    lea rax, [rbp - 32]
    mov [rbp - 56], rax
    mov rax, [rax]
    cmp rax, 4
    je match_127_4
    jmp match_127_wildcard
    jmp match_end_127
match_127_4:
    mov rax, [rbp - 56]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 64], rax
    mov rax, QWORD [rbp - 48]
    mov rdx, rax
    mov rax, [rbp - 64]
    mov rsi, rax
    lea rdi, [rbp - 80]
    call vector__get_element__JsonValue
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 32], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 24], rdx
    jmp match_end_127
match_127_wildcard:
    mov QWORD [rbp - 80], 0
    lea rax, [rbp - 80]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_127
match_end_127:
    jmp end_if_122
else_122:
    mov rax, QWORD [rbp - 40]
    mov QWORD [rbp - 48], rax
while_131:
and_132:
and_133:
    mov rax, 0
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je and_end_133
    mov rax, 46
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp r10, 0
and_end_133:
    cmp rax, 0
    je and_end_132
    mov rax, 91
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 40]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp r10, 0
and_end_132:
    cmp rax, 0
    je end_while_131
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    add rax, r10
    mov QWORD [rbp - 40], rax
    jmp while_131
end_while_131:
    mov rax, QWORD [rbp - 48]
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    sub rax, r10
    mov QWORD [rbp - 56], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 56]
    pop r10
    add rax, r10
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 64], rax
    mov rax, 0
    mov QWORD [rbp - 72], rax
while_134:
    mov rax, QWORD [rbp - 56]
    push rax
    mov rax, QWORD [rbp - 72]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_134
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 72]
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    add rax, r10
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    push rax
    mov rax, QWORD [rbp - 72]
    imul rax, 1
    mov rcx, [rbp - 64]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 72]
    pop r10
    add rax, r10
    mov QWORD [rbp - 72], rax
    jmp while_134
end_while_134:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 56]
    imul rax, 1
    mov rcx, [rbp - 64]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    lea rax, [rbp - 32]
    mov [rbp - 80], rax
    mov rax, [rax]
    cmp rax, 5
    je match_135_5
    jmp match_135_wildcard
    jmp match_end_135
match_135_5:
    mov rax, [rbp - 80]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 88], rax
    mov rax, [rbp - 64]
    mov rdi, rax
    call string__new___0
    mov QWORD [rbp - 96], rax
    mov rax, [rbp - 96]
    mov rdx, rax
    mov rax, [rbp - 88]
    mov rsi, rax
    lea rdi, [rbp - 112]
    call hashmap__get__String__ptr_JsonValue
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 32], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 24], rdx
    jmp match_end_135
match_135_wildcard:
    mov QWORD [rbp - 104], 0
    lea rax, [rbp - 104]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_135
match_end_135:
end_if_122:
    jmp while_119
end_while_119:
    lea rax, [rbp - 32]
    mov r11, [rbp - 8]
    mov r10, [rax + 0]
    mov [r11 + 0], r10
    mov r10, [rax + 8]
    mov [r11 + 8], r10
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


json__as_number:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    lea rax, [rbp - 16]
    mov [rbp - 24], rax
    mov rax, [rax]
    cmp rax, 2
    je match_139_2
    jmp match_139_wildcard
    jmp match_end_139
match_139_2:
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 32], rax
    mov rax, QWORD [rbp - 32]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_139
match_139_wildcard:
    lea rax, [rel str_140]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
    jmp match_end_139
match_end_139:


json__as_string:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    lea rax, [rbp - 16]
    mov [rbp - 24], rax
    mov rax, [rax]
    cmp rax, 3
    je match_141_3
    jmp match_141_wildcard
    jmp match_end_141
match_141_3:
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 32], rax
    mov rax, [rbp - 32]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_141
match_141_wildcard:
    lea rax, [rel str_142]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
    jmp match_end_141
match_end_141:


json__as_bool:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    lea rax, [rbp - 16]
    mov [rbp - 24], rax
    mov rax, [rax]
    cmp rax, 1
    je match_143_1
    jmp match_143_wildcard
    jmp match_end_143
match_143_1:
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 25], al
    mov al, BYTE [rbp - 25]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_143
match_143_wildcard:
    lea rax, [rel str_144]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
    jmp match_end_143
match_end_143:


json__as_array:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    lea rax, [rbp - 16]
    mov [rbp - 24], rax
    mov rax, [rax]
    cmp rax, 4
    je match_145_4
    jmp match_145_wildcard
    jmp match_end_145
match_145_4:
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 32], rax
    mov rax, [rbp - 32]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_145
match_145_wildcard:
    lea rax, [rel str_146]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
    jmp match_end_145
match_end_145:


json__as_object:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    lea rax, [rbp - 16]
    mov [rbp - 24], rax
    mov rax, [rax]
    cmp rax, 5
    je match_147_5
    jmp match_147_wildcard
    jmp match_end_147
match_147_5:
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 32], rax
    mov rax, [rbp - 32]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_147
match_147_wildcard:
    lea rax, [rel str_148]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
    jmp match_end_147
match_end_147:


json__get_number:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rdx
    mov [rbp - 16], rsi
    mov [rbp - 24], rdi
    mov rax, [rbp - 8]
    mov rcx, rax
    lea rax, [rbp - 24]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rdx, rax
    mov rax, [r10]
    mov rsi, rax
    lea rdi, [rbp - 56]
    call json__get
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 40], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 32], rdx
    lea rax, [rbp - 40]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__as_number
    mov rsp, rbp
    pop rbp
    ret


json__get_string:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rdx
    mov [rbp - 16], rsi
    mov [rbp - 24], rdi
    mov rax, [rbp - 8]
    mov rcx, rax
    lea rax, [rbp - 24]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rdx, rax
    mov rax, [r10]
    mov rsi, rax
    lea rdi, [rbp - 56]
    call json__get
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 40], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 32], rdx
    lea rax, [rbp - 40]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__as_string
    mov rsp, rbp
    pop rbp
    ret


json__get_bool:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rdx
    mov [rbp - 16], rsi
    mov [rbp - 24], rdi
    mov rax, [rbp - 8]
    mov rcx, rax
    lea rax, [rbp - 24]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rdx, rax
    mov rax, [r10]
    mov rsi, rax
    lea rdi, [rbp - 56]
    call json__get
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 40], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 32], rdx
    lea rax, [rbp - 40]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__as_bool
    mov rsp, rbp
    pop rbp
    ret


json__get_array:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rdx
    mov [rbp - 16], rsi
    mov [rbp - 24], rdi
    mov rax, [rbp - 8]
    mov rcx, rax
    lea rax, [rbp - 24]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rdx, rax
    mov rax, [r10]
    mov rsi, rax
    lea rdi, [rbp - 56]
    call json__get
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 40], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 32], rdx
    lea rax, [rbp - 40]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__as_array
    mov rsp, rbp
    pop rbp
    ret


json__get_object:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    mov [rbp - 8], rdx
    mov [rbp - 16], rsi
    mov [rbp - 24], rdi
    mov rax, [rbp - 8]
    mov rcx, rax
    lea rax, [rbp - 24]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rdx, rax
    mov rax, [r10]
    mov rsi, rax
    lea rdi, [rbp - 56]
    call json__get
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 40], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 32], rdx
    lea rax, [rbp - 40]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__as_object
    mov rsp, rbp
    pop rbp
    ret


json__push_str:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    mov rax, 0
    mov QWORD [rbp - 24], rax
while_149:
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_while_149
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    jmp while_149
end_while_149:
    mov rsp, rbp
    pop rbp
    ret


json__push_number:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_150
if_150:
    mov rax, 48
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rsp, rbp
    pop rbp
    ret
end_if_150:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_if_151
if_151:
    mov rax, 45
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, QWORD [rbp - 8]
    push rax
    mov rax, 0
    pop r10
    sub rax, r10
    mov QWORD [rbp - 8], rax
end_if_151:
    mov rax, QWORD [rbp - 8]
    mov QWORD [rbp - 24], rax
    mov rax, 1
    mov QWORD [rbp - 32], rax
while_152:
    mov rax, 0
    push rax
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    mov r10, r10
    push rdx
    cqo
    idiv r10
    pop rdx
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je end_while_152
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    imul rax, r10
    mov QWORD [rbp - 32], rax
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    mov r10, r10
    push rdx
    cqo
    idiv r10
    pop rdx
    mov QWORD [rbp - 24], rax
    jmp while_152
end_while_152:
while_153:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    cmp rax, r10
    setg al
    movzx rax, al
    cmp rax, 0
    je end_while_153
    mov rax, QWORD [rbp - 32]
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    mov r10, r10
    push rdx
    cqo
    idiv r10
    pop rdx
    mov QWORD [rbp - 40], rax
    mov rax, 48
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    add al, r10b
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, QWORD [rbp - 32]
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    imul rax, r10
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    sub rax, r10
    mov QWORD [rbp - 8], rax
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    mov r10, r10
    push rdx
    cqo
    idiv r10
    pop rdx
    mov QWORD [rbp - 32], rax
    jmp while_153
end_while_153:
    mov rsp, rbp
    pop rbp
    ret


json__stringify:
    push rbp
    mov rbp, rsp
    sub rsp, 112

    mov [rbp - 8], rcx
    mov [rbp - 16], rdx
    mov [rbp - 24], rsi
    mov [rbp - 32], rdi
    lea rax, [rbp - 32]
    mov [rbp - 40], rax
    mov rax, [rax]
    cmp rax, 0
    je match_154_0
    cmp rax, 1
    je match_154_1
    cmp rax, 2
    je match_154_2
    cmp rax, 3
    je match_154_3
    cmp rax, 4
    je match_154_4
    cmp rax, 5
    je match_154_5
    jmp match_end_154
match_154_0:
    lea rax, [rel str_155]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__push_str
    jmp match_end_154
match_154_1:
    mov rax, [rbp - 40]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 41], al
    mov al, BYTE [rbp - 41]
    cmp al, 0
    je else_156
if_156:
    lea rax, [rel str_157]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__push_str
    jmp end_if_156
else_156:
    lea rax, [rel str_158]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__push_str
end_if_156:
    jmp match_end_154
match_154_2:
    mov rax, [rbp - 40]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 49], rax
    mov rax, QWORD [rbp - 49]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__push_number
    jmp match_end_154
match_154_3:
    mov rax, [rbp - 40]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 57], rax
    mov rax, 34
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, [rbp - 57]
    mov rax, QWORD [rax]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__push_str
    mov rax, 34
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    jmp match_end_154
match_154_4:
    mov rax, [rbp - 40]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 65], rax
    mov rax, 0
    push rax
    mov rax, [rbp - 65]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je else_159
if_159:
    lea rax, [rel str_160]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__push_str
    jmp end_if_159
else_159:
    mov rax, 91
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, 10
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, 0
    mov QWORD [rbp - 73], rax
for_start_161:
    mov rax, [rbp - 65]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 73]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_161
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    add rax, r10
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__push_indent
    mov rax, QWORD [rbp - 73]
    mov rdx, rax
    mov rax, [rbp - 65]
    mov rsi, rax
    lea rdi, [rbp - 105]
    call vector__get_element__JsonValue
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 89], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 81], rdx
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    add rax, r10
    mov rcx, rax
    mov rax, [rbp - 16]
    mov rdx, rax
    lea rax, [rbp - 89]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__stringify
    mov rax, 1
    push rax
    mov rax, [rbp - 65]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    sub rax, r10
    push rax
    mov rax, QWORD [rbp - 73]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_if_162
if_162:
    mov rax, 44
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
end_if_162:
    mov rax, 10
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 73]
    pop r10
    add rax, r10
    mov QWORD [rbp - 73], rax
    jmp for_start_161
for_end_161:
    mov rax, QWORD [rbp - 8]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__push_indent
    mov rax, 93
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
end_if_159:
    jmp match_end_154
match_154_5:
    mov rax, [rbp - 40]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 73], rax
    mov rax, 0
    push rax
    mov rax, [rbp - 73]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je else_163
if_163:
    lea rax, [rel str_164]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__push_str
    jmp end_if_163
else_163:
    mov rax, 123
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, 10
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, 0
    mov QWORD [rbp - 81], rax
    mov rax, 0
    mov QWORD [rbp - 89], rax
for_start_165:
    mov rax, [rbp - 73]
    add rax, 16
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 89]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_165
    mov rax, [rbp - 73]
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 89]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov QWORD [rbp - 97], rax
    mov rax, 0
    push rax
    mov rax, [rbp - 97]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je end_if_166
if_166:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    add rax, r10
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__push_indent
    mov rax, 34
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, [rbp - 97]
    add rax, 8
    mov rax, QWORD [rax]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__push_str
    mov rax, 34
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, 58
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, 32
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    add rax, r10
    mov rcx, rax
    mov rax, [rbp - 16]
    mov rdx, rax
    mov rax, [rbp - 97]
    add rax, 20
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__stringify
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 81]
    pop r10
    add rax, r10
    mov QWORD [rbp - 81], rax
    mov rax, [rbp - 73]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 81]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_if_167
if_167:
    mov rax, 44
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
end_if_167:
    mov rax, 10
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
end_if_166:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 89]
    pop r10
    add rax, r10
    mov QWORD [rbp - 89], rax
    jmp for_start_165
for_end_165:
    mov rax, QWORD [rbp - 8]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call json__push_indent
    mov rax, 125
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
end_if_163:
    jmp match_end_154
match_end_154:
    mov rsp, rbp
    pop rbp
    ret


json__push_indent:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    mov rax, 0
    mov QWORD [rbp - 24], rax
    mov rax, 2
    push rax
    mov rax, QWORD [rbp - 8]
    pop r10
    imul rax, r10
    mov QWORD [rbp - 32], rax
while_168:
    mov rax, QWORD [rbp - 32]
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_168
    mov rax, 32
    mov sil, al
    mov rax, [rbp - 16]
    mov rdi, rax
    call string__push___0
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    jmp while_168
end_while_168:
    mov rsp, rbp
    pop rbp
    ret


json__write_to_file:
    push rbp
    mov rbp, rsp
    sub rsp, 96

    mov [rbp - 8], rdx
    mov [rbp - 16], rsi
    mov [rbp - 24], rdi
    call string__new___1
    mov QWORD [rbp - 32], rax
    mov rax, 0
    mov rcx, rax
    mov rax, [rbp - 32]
    mov rdx, rax
    lea rax, [rbp - 24]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__stringify
    mov rax, 0
    mov sil, al
    mov rax, [rbp - 32]
    mov rdi, rax
    call string__push___0
    mov rax, [rbp - 32]
    mov rdi, rax
    call string__to_string___1
    mov QWORD [rbp - 40], rax
    mov rax, 0
    mov QWORD [rbp - 48], rax
while_169:
    mov rax, 0
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, QWORD [rbp - 48]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_while_169
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    add rax, r10
    mov QWORD [rbp - 48], rax
    jmp while_169
end_while_169:
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    mov rax, 420
    mov rcx, rax
    mov rax, 577
    mov rdx, rax
    mov rax, [rbp - 8]
    mov rsi, rax
    lea rdi, [rbp - 88]
    call std__io__open___0
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call std__unwrap__u64_Errno__1
    mov QWORD [rbp - 56], rax
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    mov rax, QWORD [rbp - 48]
    mov rcx, rax
    mov rax, [rbp - 40]
    mov rdx, rax
    mov rax, QWORD [rbp - 56]
    mov esi, eax
    lea rdi, [rbp - 88]
    call std__io__write___0
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call std__unwrap__u64_Errno__1
    mov rax, QWORD [rbp - 56]
    mov esi, eax
    lea rdi, [rbp - 72]
    call std__io__close___0
    mov rsp, rbp
    pop rbp
    ret


vector__set_element__JsonValue:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rcx
    mov [rbp - 16], rdx
    mov [rbp - 24], rsi
    mov [rbp - 32], rdi
    mov rax, QWORD [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setle al
    movzx rax, al
    cmp rax, 0
    je end_if_180
if_180:
    lea rax, [rel str_181]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_180:
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 16
    push rax
    mov rax, [rbp - 32]
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov QWORD [rbp - 40], rax
    mov rax, [rbp - 32]
    add rax, 24
    mov rax, QWORD [rax]
    mov rdx, rax
    lea rax, [rbp - 16]
    mov rsi, rax
    mov rax, [rbp - 40]
    mov rdi, rax
    call std__memcpy
    mov rsp, rbp
    pop rbp
    ret


hashmap__set__String__ptr_JsonValue:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov [rbp - 8], rcx
    mov [rbp - 16], rdx
    mov [rbp - 24], rsi
    mov [rbp - 32], rdi
    mov rax, [rbp - 24]
    mov rdi, rax
    call string__to_string___1
    mov QWORD [rbp - 40], rax
    mov rax, [rbp - 40]
    mov rdi, rax
    call hashmap__hash64
    mov QWORD [rbp - 48], rax
    mov rax, 1
    push rax
    mov rax, [rbp - 32]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    sub rax, r10
    push rax
    mov rax, QWORD [rbp - 48]
    pop r10
    and rax, r10
    mov QWORD [rbp - 56], rax
    mov rax, 0
    mov rcx, rax
    mov rax, QWORD [rbp - 56]
    mov rdx, rax
    mov rax, [rbp - 40]
    mov rsi, rax
    mov rax, [rbp - 32]
    mov rdi, rax
    call hashmap__get_move__String__ptr_JsonValue
    mov QWORD [rbp - 64], rax
    mov rax, [rbp - 32]
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov QWORD [rbp - 72], rax
    lea rax, [rbp - 16]
    mov rsi, [rbp - 72]
    add rsi, 20
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rsi + 0], rdx
    mov rdx, [rcx + 8]
    mov [rsi + 8], rdx
    mov rax, [rbp - 40]
    mov rdi, rax
    call std__free
    mov rsp, rbp
    pop rbp
    ret


json__set_value:
    push rbp
    mov rbp, rsp
    sub rsp, 144

    mov [rbp - 8], r8
    mov [rbp - 16], rcx
    mov [rbp - 24], rdx
    mov [rbp - 32], rsi
    mov [rbp - 40], rdi
    lea rax, [rbp - 40]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 56], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 48], rdx
    mov rax, 0
    mov QWORD [rbp - 64], rax
while_170:
    mov rax, 0
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_while_170
    mov rax, 46
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_171
if_171:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 64]
    pop r10
    add rax, r10
    mov QWORD [rbp - 64], rax
end_if_171:
    mov rax, 0
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_172
if_172:
    jmp end_while_170
end_if_172:
    mov rax, 91
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je else_173
if_173:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 64]
    pop r10
    add rax, r10
    mov QWORD [rbp - 64], rax
    mov rax, 0
    mov QWORD [rbp - 72], rax
while_174:
and_175:
    mov rax, 48
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setge al
    cmp rax, 0
    je and_end_175
    mov rax, 57
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setle al
    cmp r10, 0
and_end_175:
    cmp rax, 0
    je end_while_174
    mov rax, 48
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    movzx rax, al
    pop r10
    sub rax, r10
    push rax
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 72]
    pop r10
    imul rax, r10
    pop r10
    add rax, r10
    mov QWORD [rbp - 72], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 64]
    pop r10
    add rax, r10
    mov QWORD [rbp - 64], rax
    jmp while_174
end_while_174:
    mov rax, 93
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je else_176
if_176:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 64]
    pop r10
    add rax, r10
    mov QWORD [rbp - 64], rax
    jmp end_if_176
else_176:
    lea rax, [rel str_177]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_176:
    mov rax, 0
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je else_178
if_178:
    lea rax, [rbp - 56]
    mov [rbp - 80], rax
    mov rax, [rax]
    cmp rax, 4
    je match_179_4
    jmp match_179_wildcard
    jmp match_end_179
match_179_4:
    mov rax, [rbp - 80]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 88], rax
    lea rax, [rbp - 16]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rcx, rax
    mov rax, [r10]
    mov rdx, rax
    mov rax, QWORD [rbp - 72]
    mov rsi, rax
    mov rax, [rbp - 88]
    mov rdi, rax
    call vector__set_element__JsonValue
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_179
match_179_wildcard:
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_179
match_end_179:
    jmp end_if_178
else_178:
    lea rax, [rbp - 56]
    mov [rbp - 80], rax
    mov rax, [rax]
    cmp rax, 4
    je match_182_4
    jmp match_182_wildcard
    jmp match_end_182
match_182_4:
    mov rax, [rbp - 80]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 88], rax
    mov rax, QWORD [rbp - 72]
    mov rdx, rax
    mov rax, [rbp - 88]
    mov rsi, rax
    lea rdi, [rbp - 104]
    call vector__get_element__JsonValue
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 56], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 48], rdx
    jmp match_end_182
match_182_wildcard:
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_182
match_end_182:
end_if_178:
    jmp end_if_173
else_173:
    mov rax, QWORD [rbp - 64]
    mov QWORD [rbp - 72], rax
while_183:
and_184:
and_185:
    mov rax, 0
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je and_end_185
    mov rax, 46
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp r10, 0
and_end_185:
    cmp rax, 0
    je and_end_184
    mov rax, 91
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp r10, 0
and_end_184:
    cmp rax, 0
    je end_while_183
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 64]
    pop r10
    add rax, r10
    mov QWORD [rbp - 64], rax
    jmp while_183
end_while_183:
    mov rax, QWORD [rbp - 72]
    push rax
    mov rax, QWORD [rbp - 64]
    pop r10
    sub rax, r10
    mov QWORD [rbp - 80], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 80]
    pop r10
    add rax, r10
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 88], rax
    mov rax, 0
    mov QWORD [rbp - 96], rax
while_186:
    mov rax, QWORD [rbp - 80]
    push rax
    mov rax, QWORD [rbp - 96]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_186
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 96]
    push rax
    mov rax, QWORD [rbp - 72]
    pop r10
    add rax, r10
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    push rax
    mov rax, QWORD [rbp - 96]
    imul rax, 1
    mov rcx, [rbp - 88]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 96]
    pop r10
    add rax, r10
    mov QWORD [rbp - 96], rax
    jmp while_186
end_while_186:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 80]
    imul rax, 1
    mov rcx, [rbp - 88]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 0
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je else_187
if_187:
    lea rax, [rbp - 56]
    mov [rbp - 104], rax
    mov rax, [rax]
    cmp rax, 5
    je match_188_5
    jmp match_188_wildcard
    jmp match_end_188
match_188_5:
    mov rax, [rbp - 104]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 112], rax
    mov rax, [rbp - 88]
    mov rdi, rax
    call string__new___0
    mov QWORD [rbp - 120], rax
    lea rax, [rbp - 16]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rcx, rax
    mov rax, [r10]
    mov rdx, rax
    mov rax, [rbp - 120]
    mov rsi, rax
    mov rax, [rbp - 112]
    mov rdi, rax
    call hashmap__set__String__ptr_JsonValue
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_188
match_188_wildcard:
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_188
match_end_188:
    jmp end_if_187
else_187:
    lea rax, [rbp - 56]
    mov [rbp - 104], rax
    mov rax, [rax]
    cmp rax, 5
    je match_189_5
    jmp match_189_wildcard
    jmp match_end_189
match_189_5:
    mov rax, [rbp - 104]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 112], rax
    mov rax, [rbp - 88]
    mov rdi, rax
    call string__new___0
    mov QWORD [rbp - 120], rax
    mov rax, [rbp - 120]
    mov rdx, rax
    mov rax, [rbp - 112]
    mov rsi, rax
    lea rdi, [rbp - 136]
    call hashmap__get__String__ptr_JsonValue
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 56], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 48], rdx
    jmp match_end_189
match_189_wildcard:
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_189
match_end_189:
end_if_187:
end_if_173:
    jmp while_170
end_while_170:
    mov rsp, rbp
    pop rbp
    ret


json__change_string:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rcx
    mov [rbp - 16], rdx
    mov [rbp - 24], rsi
    mov [rbp - 32], rdi
    mov rax, 3
    mov [rbp - 48], rax
    mov rax, [rbp - 8]
    mov QWORD [rbp - 40], rax
    lea rax, [rbp - 48]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 48], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 40], rdx
    lea rax, [rbp - 48]
    mov r10, rax
    mov rax, [r10 + 8]
    mov r8, rax
    mov rax, [r10]
    mov rcx, rax
    mov rax, [rbp - 16]
    mov rdx, rax
    lea rax, [rbp - 32]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__set_value
    mov rsp, rbp
    pop rbp
    ret


json__change_number:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rcx
    mov [rbp - 16], rdx
    mov [rbp - 24], rsi
    mov [rbp - 32], rdi
    mov rax, 2
    mov [rbp - 48], rax
    mov rax, QWORD [rbp - 8]
    mov QWORD [rbp - 40], rax
    lea rax, [rbp - 48]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 48], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 40], rdx
    lea rax, [rbp - 48]
    mov r10, rax
    mov rax, [r10 + 8]
    mov r8, rax
    mov rax, [r10]
    mov rcx, rax
    mov rax, [rbp - 16]
    mov rdx, rax
    lea rax, [rbp - 32]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__set_value
    mov rsp, rbp
    pop rbp
    ret


json__change_bool:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 1], cl
    mov [rbp - 9], rdx
    mov [rbp - 17], rsi
    mov [rbp - 25], rdi
    mov rax, 1
    mov [rbp - 41], rax
    mov al, BYTE [rbp - 1]
    mov BYTE [rbp - 33], al
    lea rax, [rbp - 41]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 41], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 33], rdx
    lea rax, [rbp - 41]
    mov r10, rax
    mov rax, [r10 + 8]
    mov r8, rax
    mov rax, [r10]
    mov rcx, rax
    mov rax, [rbp - 9]
    mov rdx, rax
    lea rax, [rbp - 25]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__set_value
    mov rsp, rbp
    pop rbp
    ret


std__println___12:
    push rbp
    mov rbp, rsp
    sub rsp, 96

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    lea rax, [rbp - 16]
    mov [rbp - 24], rax
    mov rax, [rax]
    cmp rax, 0
    je match_190_0
    cmp rax, 2
    je match_190_2
    cmp rax, 3
    je match_190_3
    cmp rax, 1
    je match_190_1
    cmp rax, 4
    je match_190_4
    cmp rax, 5
    je match_190_5
    jmp match_end_190
match_190_0:
    lea rax, [rel str_191]
    mov rdi, rax
    call std__println___0
    jmp match_end_190
match_190_2:
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 32], rax
    mov rax, QWORD [rbp - 32]
    mov rdi, rax
    call std__println___1
    jmp match_end_190
match_190_3:
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 40], rax
    mov rax, [rbp - 40]
    mov rdi, rax
    call std__println___9
    jmp match_end_190
match_190_1:
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 41], al
    mov al, BYTE [rbp - 41]
    cmp al, 0
    je else_192
if_192:
    lea rax, [rel str_193]
    mov rdi, rax
    call std__println___0
    jmp end_if_192
else_192:
    lea rax, [rel str_194]
    mov rdi, rax
    call std__println___0
end_if_192:
    jmp match_end_190
match_190_4:
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 49], rax
    lea rax, [rel str_195]
    mov rdi, rax
    call std__println___0
    mov rax, 0
    mov QWORD [rbp - 57], rax
for_start_196:
    mov rax, [rbp - 49]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 57]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_196
    mov rax, QWORD [rbp - 57]
    mov rdx, rax
    mov rax, [rbp - 49]
    mov rsi, rax
    lea rdi, [rbp - 89]
    call vector__get_element__JsonValue
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 73], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 65], rdx
    lea rax, [rbp - 73]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call std__println___12
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 57]
    pop r10
    add rax, r10
    mov QWORD [rbp - 57], rax
    jmp for_start_196
for_end_196:
    lea rax, [rel str_197]
    mov rdi, rax
    call std__println___0
    jmp match_end_190
match_190_5:
    mov rax, [rbp - 24]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 57], rax
    lea rax, [rel str_198]
    mov rdi, rax
    call std__println___0
    jmp match_end_190
match_end_190:
    mov rsp, rbp
    pop rbp
    ret


get_conf_data:
    push rbp
    mov rbp, rsp
    sub rsp, 112

    lea rax, [rel str_199]
    mov rsi, rax
    lea rdi, [rbp - 32]
    call json__parse
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 16], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 8], rdx
    mov rax, 56
    mov rdi, rax
    call std__malloc___1
    mov QWORD [rbp - 24], rax
    lea rax, [rel str_200]
    mov rdx, rax
    lea rax, [rbp - 16]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__get_string
    mov QWORD [rbp - 32], rax
    lea rax, [rel str_201]
    mov rdx, rax
    lea rax, [rbp - 16]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__get_string
    mov QWORD [rbp - 40], rax
    lea rax, [rel str_202]
    mov rdx, rax
    lea rax, [rbp - 16]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__get_string
    mov QWORD [rbp - 48], rax
    lea rax, [rel str_203]
    mov rdx, rax
    lea rax, [rbp - 16]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__get_string
    mov QWORD [rbp - 56], rax
    lea rax, [rel str_204]
    mov rdx, rax
    lea rax, [rbp - 16]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__get_array
    mov QWORD [rbp - 64], rax
    call vector__new__u8__ptr
    mov QWORD [rbp - 72], rax
    mov rax, 0
    mov QWORD [rbp - 80], rax
for_start_205:
    mov rax, [rbp - 64]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 80]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_205
    mov rax, QWORD [rbp - 80]
    mov rdx, rax
    mov rax, [rbp - 64]
    mov rsi, rax
    lea rdi, [rbp - 112]
    call vector__get_element__JsonValue
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 96], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 88], rdx
    lea rax, [rbp - 96]
    mov [rbp - 104], rax
    mov rax, [rax]
    cmp rax, 3
    je match_206_3
    jmp match_206_wildcard
    jmp match_end_206
match_206_3:
    mov rax, [rbp - 104]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 112], rax
    mov rax, [rbp - 112]
    mov rax, QWORD [rax]
    mov rsi, rax
    mov rax, [rbp - 72]
    mov rdi, rax
    call vector__push__u8__ptr
    jmp match_end_206
match_206_wildcard:
    lea rax, [rel str_207]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
    jmp match_end_206
match_end_206:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 80]
    pop r10
    add rax, r10
    mov QWORD [rbp - 80], rax
    jmp for_start_205
for_end_205:
    lea rax, [rel str_208]
    mov rdx, rax
    lea rax, [rbp - 16]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__get_string
    mov QWORD [rbp - 88], rax
    lea rax, [rel str_209]
    mov rdx, rax
    lea rax, [rbp - 16]
    mov r10, rax
    mov rax, [r10 + 8]
    mov rsi, rax
    mov rax, [r10]
    mov rdi, rax
    call json__get_string
    mov QWORD [rbp - 96], rax
    mov rax, 32
    mov sil, al
    mov rax, [rbp - 88]
    mov rax, QWORD [rax]
    mov rdi, rax
    call string__split
    mov QWORD [rbp - 104], rax
    mov rax, 32
    mov sil, al
    mov rax, [rbp - 96]
    mov rax, QWORD [rax]
    mov rdi, rax
    call string__split
    mov QWORD [rbp - 112], rax
    mov rax, [rbp - 32]
    mov rax, QWORD [rax]
    mov rsi, [rbp - 24]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, [rbp - 40]
    mov rax, QWORD [rax]
    mov rsi, [rbp - 24]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rax, [rbp - 56]
    mov rax, QWORD [rax]
    mov rsi, [rbp - 24]
    add rsi, 16
    mov QWORD [rsi], rax
    mov rax, [rbp - 48]
    mov rax, QWORD [rax]
    mov rsi, [rbp - 24]
    add rsi, 24
    mov QWORD [rsi], rax
    mov rax, [rbp - 72]
    mov rsi, [rbp - 24]
    add rsi, 32
    mov QWORD [rsi], rax
    mov rax, [rbp - 104]
    mov rsi, [rbp - 24]
    add rsi, 48
    mov QWORD [rsi], rax
    mov rax, [rbp - 112]
    mov rsi, [rbp - 24]
    add rsi, 40
    mov QWORD [rsi], rax
    mov rax, [rbp - 24]
    mov rsp, rbp
    pop rbp
    ret


resolve_executable_path:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp - 8], rdi
    mov rax, 0
    mov QWORD [rbp - 16], rax
    mov rax, 0
    mov BYTE [rbp - 17], al
while_210:
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 16]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    setne al
    cmp rax, 0
    je end_while_210
    mov rax, 47
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 16]
    imul rax, rax, 1
    pop r10
    add rax, r10
    movzx rax, BYTE [rax]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_211
if_211:
    mov rax, 1
    mov BYTE [rbp - 17], al
end_if_211:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    mov QWORD [rbp - 16], rax
    jmp while_210
end_while_210:
    mov rax, 0
    push rax
    mov al, BYTE [rbp - 17]
    pop r10
    cmp al, r10b
    sete al
    cmp rax, 0
    je end_if_212
if_212:
    lea rax, [rel str_213]
    mov rdi, rax
    call string__new___0
    mov QWORD [rbp - 25], rax
    mov rax, [rbp - 8]
    mov rdi, rax
    call string__new___0
    mov QWORD [rbp - 33], rax
    mov rax, [rbp - 33]
    mov rsi, rax
    mov rax, [rbp - 25]
    mov rdi, rax
    call string__concat
    mov rax, [rbp - 25]
    mov rax, QWORD [rax]
    mov rsp, rbp
    pop rbp
    ret
end_if_212:
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret


vector__new__u64:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov rax, 8
    mov DWORD [rbp - 4], eax
    mov rax, 8
    mov QWORD [rbp - 12], rax
    mov rax, QWORD [rbp - 12]
    push rax
    mov eax, DWORD [rbp - 4]
    pop r10
    imul eax, r10d
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 20], rax
    mov rax, 32
    mov rdi, rax
    call std__malloc___1
    mov QWORD [rbp - 28], rax
    mov rax, [rbp - 20]
    mov rsi, [rbp - 28]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, 0
    mov rsi, [rbp - 28]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rax, QWORD [rbp - 12]
    mov rsi, [rbp - 28]
    add rsi, 16
    mov QWORD [rsi], rax
    mov eax, DWORD [rbp - 4]
    mov rsi, [rbp - 28]
    add rsi, 24
    mov QWORD [rsi], rax
    mov rax, [rbp - 28]
    mov rsp, rbp
    pop rbp
    ret


vector__push__u64:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_219
if_219:
    mov rax, 2
    push rax
    mov rax, [rbp - 16]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    imul rax, r10
    mov QWORD [rbp - 24], rax
    mov rax, [rbp - 16]
    add rax, 24
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 24]
    pop r10
    imul rax, r10
    mov rdi, rax
    call std__malloc___0
    mov QWORD [rbp - 32], rax
    mov rax, [rbp - 16]
    add rax, 24
    mov rax, QWORD [rax]
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    imul rax, r10
    mov rdx, rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    mov rsi, rax
    mov rax, [rbp - 32]
    mov rdi, rax
    call std__memcpy
    mov rax, [rbp - 32]
    mov rsi, [rbp - 16]
    add rsi, 0
    mov QWORD [rsi], rax
    mov rax, QWORD [rbp - 24]
    mov rsi, [rbp - 16]
    add rsi, 16
    mov QWORD [rsi], rax
end_if_219:
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    imul rax, rax, 8
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    mov rax, [rbp - 16]
    add rax, 24
    mov rax, QWORD [rax]
    mov rdx, rax
    lea rax, [rbp - 8]
    mov rsi, rax
    mov rax, [rbp - 24]
    mov rdi, rax
    call std__memcpy
    mov rax, 1
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov rsi, [rbp - 16]
    add rsi, 8
    mov QWORD [rsi], rax
    mov rsp, rbp
    pop rbp
    ret


vector__get_element__u64:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    mov rax, QWORD [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setle al
    movzx rax, al
    cmp rax, 0
    je end_if_221
if_221:
    lea rax, [rel str_222]
    mov rdi, rax
    call std__print___0
    mov rax, QWORD [rbp - 8]
    mov rdi, rax
    call std__print___1
    lea rax, [rel str_223]
    mov rdi, rax
    call std__print___0
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__println___1
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_221:
    mov rax, QWORD [rbp - 8]
    imul rax, rax, 8
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    mov rax, [rbp - 24]
    mov rax, QWORD [rax]
    mov rsp, rbp
    pop rbp
    ret


compile_to_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 336

    mov [rbp - 8], rdi
    call vector__new__u64
    mov QWORD [rbp - 16], rax
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    mov rdi, rax
    call resolve_executable_path
    mov QWORD [rbp - 24], rax
    mov rax, 0
    mov QWORD [rbp - 32], rax
for_start_214:
    mov rax, [rbp - 8]
    add rax, 32
    mov rax, QWORD [rax]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_214
    mov rax, QWORD [rbp - 32]
    mov rsi, rax
    mov rax, [rbp - 8]
    add rax, 32
    mov rax, QWORD [rax]
    mov rdi, rax
    call vector__get_element__u8__ptr
    mov QWORD [rbp - 40], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    imul rax, 8
    lea rcx, [rbp - 296]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    lea rax, [rel str_215]
    push rax
    mov rax, 1
    imul rax, 8
    lea rcx, [rbp - 296]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 2
    imul rax, 8
    lea rcx, [rbp - 296]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    lea rax, [rel str_216]
    push rax
    mov rax, 3
    imul rax, 8
    lea rcx, [rbp - 296]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    lea rax, [rel str_217]
    mov rdi, rax
    call string__new___0
    mov QWORD [rbp - 304], rax
    mov rax, [rbp - 40]
    mov rdi, rax
    call string__get_file_name
    mov QWORD [rbp - 312], rax
    mov rax, [rbp - 312]
    mov rdi, rax
    call string__new___0
    mov QWORD [rbp - 320], rax
    mov rax, [rbp - 320]
    mov rsi, rax
    mov rax, [rbp - 304]
    mov rdi, rax
    call string__concat
    lea rax, [rel str_218]
    mov rdi, rax
    call string__new___0
    mov QWORD [rbp - 328], rax
    mov rax, [rbp - 328]
    mov rsi, rax
    mov rax, [rbp - 304]
    mov rdi, rax
    call string__concat
    mov rax, [rbp - 304]
    mov rax, QWORD [rax]
    push rax
    mov rax, 4
    imul rax, 8
    lea rcx, [rbp - 296]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, [rel NULL]
    push rax
    mov rax, 5
    imul rax, 8
    lea rcx, [rbp - 296]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    lea rax, [rbp - 296]
    mov rsi, rax
    mov rax, [rbp - 24]
    mov rdi, rax
    call proc__run_cmd_no_wait___0
    mov QWORD [rbp - 336], rax
    mov rax, QWORD [rbp - 336]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call vector__push__u64
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    add rax, r10
    mov QWORD [rbp - 32], rax
    jmp for_start_214
for_end_214:
    mov rax, 0
    mov QWORD [rbp - 40], rax
for_start_220:
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_220
    mov rax, QWORD [rbp - 40]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call vector__get_element__u64
    mov QWORD [rbp - 48], rax
    mov rax, QWORD [rbp - 48]
    mov rsi, rax
    lea rdi, [rbp - 80]
    call proc__wait4___0
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 64], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 56], rdx
    lea rax, [rbp - 64]
    mov [rbp - 72], rax
    mov rax, [rax]
    cmp rax, 0
    je match_224_0
    cmp rax, 1
    je match_224_1
    jmp match_end_224
match_224_0:
    mov rax, [rbp - 72]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 80], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 80]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je end_if_225
if_225:
    lea rax, [rel str_226]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_225:
    jmp match_end_224
match_224_1:
    mov rax, [rbp - 72]
    add rax, 8
    mov rax, [rax]
    mov [rbp - 88], rax
    lea rax, [rel str_227]
    mov rdi, rax
    call std__print___0
    mov rax, QWORD [rbp - 48]
    mov rdi, rax
    call std__print___5
    lea rax, [rel str_228]
    mov rdi, rax
    call std__print___0
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    lea rax, [rbp - 88]
    mov rax, [rax]
    mov rdi, rax
    call std__errno_to_num
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    mov rdi, rax
    call std__println___5
    mov rax, 1
    mov edi, eax
    call std__exit___0
    jmp match_end_224
match_end_224:
    lea rax, [rbp - 64]
    mov rdi, rax
    call std__unwrap__u64_Errno
    mov QWORD [rbp - 88], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 88]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je end_if_229
if_229:
    lea rax, [rel str_230]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_229:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    add rax, r10
    mov QWORD [rbp - 40], rax
    jmp for_start_220
for_end_220:
    mov rsp, rbp
    pop rbp
    ret


assemble_to_obj:
    push rbp
    mov rbp, rsp
    sub rsp, 352

    mov [rbp - 8], rdi
    call vector__new__u64
    mov QWORD [rbp - 16], rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    mov rdi, rax
    call resolve_executable_path
    mov QWORD [rbp - 24], rax
    mov rax, 0
    mov QWORD [rbp - 32], rax
for_start_231:
    mov rax, [rbp - 8]
    add rax, 32
    mov rax, QWORD [rax]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_231
    mov rax, QWORD [rbp - 32]
    mov rsi, rax
    mov rax, [rbp - 8]
    add rax, 32
    mov rax, QWORD [rax]
    mov rdi, rax
    call vector__get_element__u8__ptr
    mov QWORD [rbp - 40], rax
    mov rax, 0
    mov QWORD [rbp - 304], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, QWORD [rbp - 304]
    imul rax, 8
    lea rcx, [rbp - 296]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 304]
    pop r10
    add rax, r10
    mov QWORD [rbp - 304], rax
    mov rax, 0
    mov QWORD [rbp - 312], rax
for_start_232:
    mov rax, [rbp - 8]
    add rax, 40
    mov rax, QWORD [rax]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 312]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_232
    mov rax, QWORD [rbp - 312]
    mov rsi, rax
    mov rax, [rbp - 8]
    add rax, 40
    mov rax, QWORD [rax]
    mov rdi, rax
    call vector__get_element__u8__ptr
    push rax
    mov rax, QWORD [rbp - 304]
    imul rax, 8
    lea rcx, [rbp - 296]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 304]
    pop r10
    add rax, r10
    mov QWORD [rbp - 304], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 312]
    pop r10
    add rax, r10
    mov QWORD [rbp - 312], rax
    jmp for_start_232
for_end_232:
    lea rax, [rel str_233]
    mov rdi, rax
    call string__new___0
    mov QWORD [rbp - 320], rax
    mov rax, [rbp - 40]
    mov rdi, rax
    call string__get_file_name
    mov QWORD [rbp - 328], rax
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    mov rax, [rbp - 328]
    mov rdi, rax
    call string__new___0
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    mov rsi, rax
    mov rax, [rbp - 320]
    mov rdi, rax
    call string__concat
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    lea rax, [rel str_234]
    mov rdi, rax
    call string__new___0
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    mov rsi, rax
    mov rax, [rbp - 320]
    mov rdi, rax
    call string__concat
    mov rax, [rbp - 320]
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 304]
    imul rax, 8
    lea rcx, [rbp - 296]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 304]
    pop r10
    add rax, r10
    mov QWORD [rbp - 304], rax
    lea rax, [rel str_235]
    push rax
    mov rax, QWORD [rbp - 304]
    imul rax, 8
    lea rcx, [rbp - 296]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 304]
    pop r10
    add rax, r10
    mov QWORD [rbp - 304], rax
    lea rax, [rel str_236]
    mov rdi, rax
    call string__new___0
    mov QWORD [rbp - 336], rax
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    mov rax, [rbp - 328]
    mov rdi, rax
    call string__new___0
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    mov rsi, rax
    mov rax, [rbp - 336]
    mov rdi, rax
    call string__concat
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    lea rax, [rel str_237]
    mov rdi, rax
    call string__new___0
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    mov rsi, rax
    mov rax, [rbp - 336]
    mov rdi, rax
    call string__concat
    mov rax, [rbp - 336]
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 304]
    imul rax, 8
    lea rcx, [rbp - 296]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 304]
    pop r10
    add rax, r10
    mov QWORD [rbp - 304], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 304]
    imul rax, 8
    lea rcx, [rbp - 296]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    lea rax, [rbp - 296]
    mov rsi, rax
    mov rax, [rbp - 24]
    mov rdi, rax
    call proc__run_cmd_no_wait___0
    mov QWORD [rbp - 344], rax
    mov rax, QWORD [rbp - 344]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call vector__push__u64
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop r10
    add rax, r10
    mov QWORD [rbp - 32], rax
    jmp for_start_231
for_end_231:
    mov rax, 0
    mov QWORD [rbp - 40], rax
for_start_238:
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_238
    mov rax, QWORD [rbp - 40]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call vector__get_element__u64
    mov QWORD [rbp - 48], rax
    mov rax, QWORD [rbp - 48]
    mov rsi, rax
    lea rdi, [rbp - 80]
    call proc__wait4___0
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 64], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 56], rdx
    lea rax, [rbp - 64]
    mov rdi, rax
    call std__unwrap__u64_Errno
    mov QWORD [rbp - 72], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 72]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je end_if_239
if_239:
    lea rax, [rel str_240]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_239:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 40]
    pop r10
    add rax, r10
    mov QWORD [rbp - 40], rax
    jmp for_start_238
for_end_238:
    mov rsp, rbp
    pop rbp
    ret


link_executable:
    push rbp
    mov rbp, rsp
    sub rsp, 2112

    mov [rbp - 8], rdi
    mov rax, [rbp - 8]
    add rax, 24
    mov rax, QWORD [rax]
    mov rdi, rax
    call resolve_executable_path
    mov QWORD [rbp - 16], rax
    mov rax, 0
    mov QWORD [rbp - 2072], rax
    mov rax, [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 2072]
    imul rax, 8
    lea rcx, [rbp - 2064]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 2072]
    pop r10
    add rax, r10
    mov QWORD [rbp - 2072], rax
    lea rax, [rel str_241]
    push rax
    mov rax, QWORD [rbp - 2072]
    imul rax, 8
    lea rcx, [rbp - 2064]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 2072]
    pop r10
    add rax, r10
    mov QWORD [rbp - 2072], rax
    lea rax, [rel str_242]
    mov rdi, rax
    call string__new___0
    mov QWORD [rbp - 2080], rax
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    mov rdi, rax
    call string__new___0
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    mov rsi, rax
    mov rax, [rbp - 2080]
    mov rdi, rax
    call string__concat
    mov rax, [rbp - 2080]
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 2072]
    imul rax, 8
    lea rcx, [rbp - 2064]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 2072]
    pop r10
    add rax, r10
    mov QWORD [rbp - 2072], rax
    mov rax, 0
    mov QWORD [rbp - 2088], rax
for_start_243:
    mov rax, [rbp - 8]
    add rax, 32
    mov rax, QWORD [rax]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 2088]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_243
    mov rax, QWORD [rbp - 2088]
    mov rsi, rax
    mov rax, [rbp - 8]
    add rax, 32
    mov rax, QWORD [rax]
    mov rdi, rax
    call vector__get_element__u8__ptr
    mov QWORD [rbp - 2096], rax
    mov rax, [rbp - 2096]
    mov rdi, rax
    call string__get_file_name
    mov QWORD [rbp - 2104], rax
    lea rax, [rel str_244]
    mov rdi, rax
    call string__new___0
    mov QWORD [rbp - 2112], rax
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    mov rax, [rbp - 2104]
    mov rdi, rax
    call string__new___0
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    mov rsi, rax
    mov rax, [rbp - 2112]
    mov rdi, rax
    call string__concat
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    lea rax, [rel str_245]
    mov rdi, rax
    call string__new___0
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    mov rsi, rax
    mov rax, [rbp - 2112]
    mov rdi, rax
    call string__concat
    mov rax, [rbp - 2112]
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 2072]
    imul rax, 8
    lea rcx, [rbp - 2064]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 2072]
    pop r10
    add rax, r10
    mov QWORD [rbp - 2072], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 2088]
    pop r10
    add rax, r10
    mov QWORD [rbp - 2088], rax
    jmp for_start_243
for_end_243:
    mov rax, 0
    mov QWORD [rbp - 2096], rax
for_start_246:
    mov rax, [rbp - 8]
    add rax, 48
    mov rax, QWORD [rax]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 2096]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_246
    mov rax, QWORD [rbp - 2096]
    mov rsi, rax
    mov rax, [rbp - 8]
    add rax, 48
    mov rax, QWORD [rax]
    mov rdi, rax
    call vector__get_element__u8__ptr
    push rax
    mov rax, QWORD [rbp - 2072]
    imul rax, 8
    lea rcx, [rbp - 2064]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 2072]
    pop r10
    add rax, r10
    mov QWORD [rbp - 2072], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 2096]
    pop r10
    add rax, r10
    mov QWORD [rbp - 2096], rax
    jmp for_start_246
for_end_246:
    mov rax, [rel NULL]
    push rax
    mov rax, QWORD [rbp - 2072]
    imul rax, 8
    lea rcx, [rbp - 2064]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    lea rax, [rbp - 2064]
    mov rsi, rax
    mov rax, [rbp - 16]
    mov rdi, rax
    call proc__run_cmd___0
    mov DWORD [rbp - 2100], eax
    mov rax, 0
    push rax
    mov eax, DWORD [rbp - 2100]
    pop r10
    cmp eax, r10d
    setne al
    movzx eax, al
    cmp rax, 0
    je else_247
if_247:
    lea rax, [rel str_248]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
    jmp end_if_247
else_247:
    lea rax, [rel str_249]
    mov rdi, rax
    call std__print___0
    mov rax, [rbp - 2080]
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__println___0
    mov rax, [rbp - 2080]
    mov rax, QWORD [rax]
    mov rsp, rbp
    pop rbp
    ret
end_if_247:


print_version:
    push rbp
    mov rbp, rsp
    sub rsp, 0

    lea rax, [rel str_250]
    mov rdi, rax
    call std__println___0
    mov rax, 0
    mov edi, eax
    call std__exit___0
    mov rsp, rbp
    pop rbp
    ret


main:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    mov rax, 0
    mov BYTE [rbp - 17], al
    mov rax, 1
    mov QWORD [rbp - 25], rax
for_start_251:
    mov rax, QWORD [rbp - 16]
    push rax
    mov rax, QWORD [rbp - 25]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_251
    lea rax, [rel str_252]
    mov rsi, rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 25]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov rdi, rax
    call string__strcmp___1
    cmp al, 0
    je else_253
if_253:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 25]
    pop r10
    add al, r10b
    mov BYTE [rbp - 17], al
    jmp for_end_251
    jmp end_if_253
else_253:
    lea rax, [rel str_254]
    mov rsi, rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 25]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov rdi, rax
    call string__strcmp___1
    cmp al, 0
    je else_255
if_255:
    call print_version
    jmp end_if_255
else_255:
    lea rax, [rel str_256]
    mov rsi, rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 25]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov rdi, rax
    call string__strcmp___1
    cmp al, 0
    je else_257
if_257:
    call print_version
    jmp end_if_257
else_257:
    lea rax, [rel str_258]
    mov rsi, rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 25]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov rdi, rax
    call string__strcmp___1
    cmp al, 0
    je else_259
if_259:
    call print_version
    jmp end_if_259
else_259:
    lea rax, [rel str_260]
    mov rsi, rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 25]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov rdi, rax
    call string__strcmp___1
    cmp al, 0
    je else_261
if_261:
    mov rax, 511
    mov rdx, rax
    lea rax, [rel str_262]
    mov rsi, rax
    lea rdi, [rbp - 57]
    call std__io__mkdir___0
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 41], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 33], rdx
    mov rax, 420
    mov rcx, rax
    mov rax, 64
    push rax
    mov rax, 2
    pop r10
    or rax, r10
    mov rdx, rax
    lea rax, [rel str_263]
    mov rsi, rax
    lea rdi, [rbp - 73]
    call std__io__open___0
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 57], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 49], rdx
    mov rax, 0
    mov edi, eax
    call std__exit___0
    jmp end_if_261
else_261:
    lea rax, [rel str_264]
    mov rdi, rax
    call std__print___0
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 25]
    imul rax, rax, 8
    pop r10
    add rax, r10
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_261:
end_if_259:
end_if_257:
end_if_255:
end_if_253:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 25]
    pop r10
    add rax, r10
    mov QWORD [rbp - 25], rax
    jmp for_start_251
for_end_251:
    call get_conf_data
    mov QWORD [rbp - 33], rax
    mov rax, 511
    mov rdx, rax
    lea rax, [rel str_265]
    mov rsi, rax
    lea rdi, [rbp - 65]
    call std__io__mkdir___0
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rbp - 49], rdx
    mov rdx, [rcx + 8]
    mov [rbp - 41], rdx
    mov rax, [rbp - 33]
    mov rdi, rax
    call compile_to_asm
    mov rax, [rbp - 33]
    mov rdi, rax
    call assemble_to_obj
    mov rax, [rbp - 33]
    mov rdi, rax
    call link_executable
    mov QWORD [rbp - 57], rax
    mov rax, 0
    push rax
    mov al, BYTE [rbp - 17]
    pop r10
    cmp al, r10b
    setg al
    cmp rax, 0
    je end_if_266
if_266:
    mov rax, [rbp - 57]
    push rax
    mov rax, 1
    push rax
    mov al, BYTE [rbp - 17]
    pop r10
    sub al, r10b
    imul rax, 8
    mov rcx, [rbp - 8]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    mov rax, 1
    push rax
    mov al, BYTE [rbp - 17]
    pop r10
    sub al, r10b
    imul rax, rax, 8
    push rax
    mov rax, [rbp - 8]
    pop r10
    add rax, r10
    mov QWORD [rbp - 65], rax
    mov rax, [rbp - 65]
    mov rsi, rax
    mov rax, [rbp - 57]
    mov rdi, rax
    call proc__run_cmd___0
    mov DWORD [rbp - 69], eax
    mov rax, 0
    push rax
    mov eax, DWORD [rbp - 69]
    pop r10
    cmp eax, r10d
    setne al
    movzx eax, al
    cmp rax, 0
    je end_if_267
if_267:
    lea rax, [rel str_268]
    mov rdi, rax
    call std__print___0
    mov eax, DWORD [rbp - 69]
    mov edi, eax
    call std__print___2
    lea rax, [rel str_269]
    mov rdi, rax
    call std__print___0
    mov rax, [rbp - 57]
    mov rdi, rax
    call std__println___0
end_if_267:
end_if_266:
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret


vector__get_element__ConfLine__ptr:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rsi
    mov [rbp - 16], rdi
    mov rax, QWORD [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setle al
    movzx rax, al
    cmp rax, 0
    je end_if_271
if_271:
    lea rax, [rel str_272]
    mov rdi, rax
    call std__print___0
    mov rax, QWORD [rbp - 8]
    mov rdi, rax
    call std__print___1
    lea rax, [rel str_273]
    mov rdi, rax
    call std__print___0
    mov rax, [rbp - 16]
    add rax, 8
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__println___1
    mov rax, 1
    mov edi, eax
    call std__exit___0
end_if_271:
    mov rax, QWORD [rbp - 8]
    imul rax, rax, 8
    push rax
    mov rax, [rbp - 16]
    mov rax, QWORD [rax]
    pop r10
    add rax, r10
    mov QWORD [rbp - 24], rax
    mov rax, [rbp - 24]
    mov rax, QWORD [rax]
    mov rsp, rbp
    pop rbp
    ret


std__println___13:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    mov rax, 0
    mov QWORD [rbp - 16], rax
for_start_270:
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_270
    mov rax, QWORD [rbp - 16]
    mov rsi, rax
    mov rax, [rbp - 8]
    mov rdi, rax
    call vector__get_element__ConfLine__ptr
    mov QWORD [rbp - 24], rax
    mov rax, [rbp - 24]
    mov rdi, rax
    call print_conf_line
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    mov QWORD [rbp - 16], rax
    jmp for_start_270
for_end_270:
    mov rsp, rbp
    pop rbp
    ret


std__println___14:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    lea rax, [rel str_274]
    mov rdi, rax
    call std__println___0
    lea rax, [rel str_275]
    mov rdi, rax
    call std__print___0
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je else_276
if_276:
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__println___0
    jmp end_if_276
else_276:
    lea rax, [rel str_277]
    mov rdi, rax
    call std__println___0
end_if_276:
    lea rax, [rel str_278]
    mov rdi, rax
    call std__print___0
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je else_279
if_279:
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__println___0
    jmp end_if_279
else_279:
    lea rax, [rel str_280]
    mov rdi, rax
    call std__println___0
end_if_279:
    lea rax, [rel str_281]
    mov rdi, rax
    call std__print___0
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je else_282
if_282:
    mov rax, [rbp - 8]
    add rax, 16
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__println___0
    jmp end_if_282
else_282:
    lea rax, [rel str_283]
    mov rdi, rax
    call std__println___0
end_if_282:
    lea rax, [rel str_284]
    mov rdi, rax
    call std__print___0
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    add rax, 24
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je else_285
if_285:
    mov rax, [rbp - 8]
    add rax, 24
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__println___0
    jmp end_if_285
else_285:
    lea rax, [rel str_286]
    mov rdi, rax
    call std__println___0
end_if_285:
    lea rax, [rel str_287]
    mov rdi, rax
    call std__println___0
    mov rax, 0
    mov QWORD [rbp - 16], rax
    lea rax, [rel str_288]
    mov rdi, rax
    call std__println___0
    mov rax, 0
    mov QWORD [rbp - 16], rax
while_289:
    mov rax, [rbp - 8]
    add rax, 32
    mov rax, QWORD [rax]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_289
    lea rax, [rel str_290]
    mov rdi, rax
    call std__print___0
    mov rax, QWORD [rbp - 16]
    mov rsi, rax
    mov rax, [rbp - 8]
    add rax, 32
    mov rax, QWORD [rax]
    mov rdi, rax
    call vector__get_element__u8__ptr
    mov QWORD [rbp - 24], rax
    mov rax, [rbp - 24]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    mov QWORD [rbp - 16], rax
    jmp while_289
end_while_289:
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    add rax, 32
    mov rax, QWORD [rax]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_291
if_291:
    lea rax, [rel str_292]
    mov rdi, rax
    call std__println___0
end_if_291:
    lea rax, [rel str_293]
    mov rdi, rax
    call std__println___0
    mov rax, 0
    mov QWORD [rbp - 16], rax
while_294:
    mov rax, [rbp - 8]
    add rax, 40
    mov rax, QWORD [rax]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_294
    lea rax, [rel str_295]
    mov rdi, rax
    call std__print___0
    mov rax, QWORD [rbp - 16]
    mov rsi, rax
    mov rax, [rbp - 8]
    add rax, 40
    mov rax, QWORD [rax]
    mov rdi, rax
    call vector__get_element__u8__ptr
    mov QWORD [rbp - 24], rax
    mov rax, [rbp - 24]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    mov QWORD [rbp - 16], rax
    jmp while_294
end_while_294:
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    add rax, 40
    mov rax, QWORD [rax]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_296
if_296:
    lea rax, [rel str_297]
    mov rdi, rax
    call std__println___0
end_if_296:
    lea rax, [rel str_298]
    mov rdi, rax
    call std__println___0
    mov rax, 0
    mov QWORD [rbp - 16], rax
while_299:
    mov rax, [rbp - 8]
    add rax, 48
    mov rax, QWORD [rax]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_299
    lea rax, [rel str_300]
    mov rdi, rax
    call std__print___0
    mov rax, QWORD [rbp - 16]
    mov rsi, rax
    mov rax, [rbp - 8]
    add rax, 48
    mov rax, QWORD [rax]
    mov rdi, rax
    call vector__get_element__u8__ptr
    mov QWORD [rbp - 24], rax
    mov rax, [rbp - 24]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    mov QWORD [rbp - 16], rax
    jmp while_299
end_while_299:
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    add rax, 48
    mov rax, QWORD [rax]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_301
if_301:
    lea rax, [rel str_302]
    mov rdi, rax
    call std__println___0
end_if_301:
    lea rax, [rel str_303]
    mov rdi, rax
    call std__println___0
    mov rsp, rbp
    pop rbp
    ret


print_conf_line:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    lea rax, [rel str_304]
    mov rdi, rax
    call std__println___0
    lea rax, [rel str_305]
    mov rdi, rax
    call std__print___0
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    setne al
    movzx rax, al
    cmp rax, 0
    je else_306
if_306:
    mov rax, [rbp - 8]
    mov rax, QWORD [rax]
    mov rdi, rax
    call std__println___0
    jmp end_if_306
else_306:
    lea rax, [rel str_307]
    mov rdi, rax
    call std__println___0
end_if_306:
    lea rax, [rel str_308]
    mov rdi, rax
    call std__println___0
    mov rax, 0
    mov QWORD [rbp - 16], rax
while_309:
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    add rax, 8
    mov rax, QWORD [rax]
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    cmp rax, r10
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_309
    lea rax, [rel str_310]
    mov rdi, rax
    call std__print___0
    mov rax, QWORD [rbp - 16]
    mov rsi, rax
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    mov rdi, rax
    call vector__get_element__u8__ptr
    mov QWORD [rbp - 24], rax
    mov rax, [rbp - 24]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop r10
    add rax, r10
    mov QWORD [rbp - 16], rax
    jmp while_309
end_while_309:
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    add rax, 8
    mov rax, QWORD [rax]
    add rax, 8
    mov rax, QWORD [rax]
    pop r10
    cmp rax, r10
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_311
if_311:
    lea rax, [rel str_312]
    mov rdi, rax
    call std__println___0
end_if_311:
    lea rax, [rel str_313]
    mov rdi, rax
    call std__println___0
    mov rsp, rbp
    pop rbp
    ret


