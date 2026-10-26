section .data
malloc_list_head dq 0
str_25: db "num_to_errno called with 0 (everything fine)", 0
str_27: db "hello world", 0
str_28: db "nigger", 0
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
std__exit:
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


std__malloc___0:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov [rbp - 8], rdi
    mov rax, 8
    push rax
    mov rax, QWORD [rbp - 8]
    pop rbx
    mov r10, rbx
    push rdx
    cqo
    idiv r10
    mov rax, rdx
    pop rdx
    mov QWORD [rbp - 16], rax
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 16]
    pop rbx
    cmp rax, rbx
    setne al
    movzx rax, al
    cmp rax, 0
    je end_if_1
if_1:
    mov rax, QWORD [rbp - 16]
    push rax
    mov rax, 8
    pop rbx
    sub rax, rbx
    push rax
    mov rax, QWORD [rbp - 8]
    pop rbx
    add rax, rbx
    mov QWORD [rbp - 8], rax
end_if_1:
    mov rax, [rel malloc_list_head]
    mov QWORD [rbp - 24], rax
    mov rax, 0
    mov QWORD [rbp - 32], rax
while_2:
    mov rax, 0
    push rax
    mov rax, [rbp - 24]
    pop rbx
    cmp rax, rbx
    setne al
    movzx rax, al
    cmp rax, 0
    je end_while_2
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    imul rax, rax, 8
    pop rbx
    add rax, rbx
    mov rax, QWORD [rax]
    mov QWORD [rbp - 40], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    imul rax, rax, 8
    pop rbx
    add rax, rbx
    mov rax, QWORD [rax]
    mov QWORD [rbp - 48], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 48]
    pop rbx
    cmp rax, rbx
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_3
if_3:
    mov rax, QWORD [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 40]
    pop rbx
    cmp rax, rbx
    setge al
    movzx rax, al
    cmp rax, 0
    je end_if_4
if_4:
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
    pop rbx
    add rax, rbx
    mov rsp, rbp
    pop rbp
    ret
end_if_4:
end_if_3:
    mov rax, [rbp - 24]
    mov QWORD [rbp - 32], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 2
    imul rax, rax, 8
    pop rbx
    add rax, rbx
    mov rax, QWORD [rax]
    mov QWORD [rbp - 24], rax
    jmp while_2
end_while_2:
    mov rax, 24
    push rax
    mov rax, QWORD [rbp - 8]
    pop rbx
    add rax, rbx
    mov QWORD [rbp - 40], rax
    mov rax, 4096
    mov QWORD [rbp - 48], rax
while_5:
    mov rax, QWORD [rbp - 40]
    push rax
    mov rax, QWORD [rbp - 48]
    pop rbx
    cmp rax, rbx
    setl al
    movzx rax, al
    cmp rax, 0
    je end_while_5
    mov rax, 4096
    push rax
    mov rax, QWORD [rbp - 48]
    pop rbx
    add rax, rbx
    mov QWORD [rbp - 48], rax
    jmp while_5
end_while_5:
    mov rax, 1
    neg rax
    mov r9, rax
    mov rax, 34
    mov r8, rax
    mov rax, 3
    mov rcx, rax
    mov rax, QWORD [rbp - 48]
    mov rdx, rax
    mov rax, 0
    mov rsi, rax
    mov rax, 9
    mov rdi, rax
    call std__syscall
    mov QWORD [rbp - 56], rax
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
    pop rbx
    sub rax, rbx
    mov QWORD [rbp - 64], rax
    mov rax, 32
    push rax
    mov rax, QWORD [rbp - 64]
    pop rbx
    cmp rax, rbx
    setg al
    movzx rax, al
    cmp rax, 0
    je else_6
if_6:
    mov rax, QWORD [rbp - 8]
    push rax
    mov rax, 24
    push rax
    mov rax, [rbp - 56]
    pop rbx
    add rax, rbx
    pop rbx
    add rax, rbx
    mov QWORD [rbp - 72], rax
    mov rax, 24
    push rax
    mov rax, QWORD [rbp - 64]
    pop rbx
    sub rax, rbx
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
    jmp end_if_6
else_6:
    mov rax, 24
    push rax
    mov rax, QWORD [rbp - 48]
    pop rbx
    sub rax, rbx
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
end_if_6:
    mov rax, 0
    push rax
    mov rax, [rbp - 32]
    pop rbx
    cmp rax, rbx
    setne al
    movzx rax, al
    cmp rax, 0
    je else_7
if_7:
    mov rax, [rbp - 56]
    push rax
    mov rax, 2
    imul rax, 8
    mov rcx, [rbp - 32]
    add rcx, rax
    pop rax
    mov QWORD [rcx], rax
    jmp end_if_7
else_7:
    mov rax, [rbp - 56]
    mov QWORD [malloc_list_head], rax
end_if_7:
    mov rax, 24
    push rax
    mov rax, [rbp - 56]
    pop rbx
    add rax, rbx
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
    pop rbx
    mov r10, rbx
    push rdx
    cqo
    idiv r10
    pop rdx
    mov QWORD [rbp - 32], rax
    mov rax, 8
    push rax
    mov rax, QWORD [rbp - 8]
    pop rbx
    mov r10, rbx
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
for_start_8:
    mov rax, QWORD [rbp - 32]
    push rax
    mov rax, QWORD [rbp - 64]
    pop rbx
    cmp rax, rbx
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_8
    mov rax, [rbp - 56]
    push rax
    mov rax, QWORD [rbp - 64]
    imul rax, rax, 8
    pop rbx
    add rax, rbx
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
    pop rbx
    add rax, rbx
    mov QWORD [rbp - 64], rax
    jmp for_start_8
for_end_8:
    mov rax, 0
    push rax
    mov rax, QWORD [rbp - 40]
    pop rbx
    cmp rax, rbx
    setg al
    movzx rax, al
    cmp rax, 0
    je end_if_9
if_9:
    mov rax, [rbp - 24]
    mov QWORD [rbp - 72], rax
    mov rax, [rbp - 16]
    mov QWORD [rbp - 80], rax
    mov rax, 8
    push rax
    mov rax, QWORD [rbp - 32]
    pop rbx
    imul rax, rbx
    mov QWORD [rbp - 88], rax
    mov rax, 0
    mov QWORD [rbp - 96], rax
for_start_10:
    mov rax, QWORD [rbp - 40]
    push rax
    mov rax, QWORD [rbp - 96]
    pop rbx
    cmp rax, rbx
    setl al
    movzx rax, al
    cmp rax, 0
    je for_end_10
    mov rax, [rbp - 80]
    push rax
    mov rax, QWORD [rbp - 96]
    push rax
    mov rax, QWORD [rbp - 88]
    pop rbx
    add rax, rbx
    imul rax, rax, 1
    pop rbx
    add rax, rbx
    movzx rax, BYTE [rax]
    push rax
    mov rax, QWORD [rbp - 96]
    push rax
    mov rax, QWORD [rbp - 88]
    pop rbx
    add rax, rbx
    imul rax, 1
    mov rcx, [rbp - 72]
    add rcx, rax
    pop rax
    mov BYTE [rcx], al
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 96]
    pop rbx
    add rax, rbx
    mov QWORD [rbp - 96], rax
    jmp for_start_10
for_end_10:
end_if_9:
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
    pop rbx
    cmp rax, rbx
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_11
if_11:
    mov rsp, rbp
    pop rbp
    ret
end_if_11:
    mov rax, 24
    push rax
    mov rax, [rbp - 8]
    pop rbx
    sub rax, rbx
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
while_12:
    mov rax, 32
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop rbx
    add rax, rbx
    movzx rax, BYTE [rax]
    pop rbx
    cmp al, bl
    sete al
    cmp rax, 0
    je end_while_12
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 24]
    pop rbx
    add rax, rbx
    mov QWORD [rbp - 24], rax
    jmp while_12
end_while_12:
    mov rax, 45
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop rbx
    add rax, rbx
    movzx rax, BYTE [rax]
    pop rbx
    cmp al, bl
    sete al
    cmp rax, 0
    je end_if_13
if_13:
    mov rax, 1
    mov QWORD [rbp - 32], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 24]
    pop rbx
    add rax, rbx
    mov QWORD [rbp - 24], rax
end_if_13:
while_14:
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop rbx
    add rax, rbx
    movzx rax, BYTE [rax]
    pop rbx
    cmp al, bl
    setne al
    cmp rax, 0
    je end_while_14
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 24]
    imul rax, rax, 1
    pop rbx
    add rax, rbx
    movzx rax, BYTE [rax]
    mov BYTE [rbp - 33], al
    mov rax, 48
    push rax
    mov al, BYTE [rbp - 33]
    pop rbx
    cmp al, bl
    setb al
    cmp rax, 0
    je end_if_15
if_15:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop rbx
    cmp rax, rbx
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_16
if_16:
    mov rax, QWORD [rbp - 16]
    neg rax
    mov rsp, rbp
    pop rbp
    ret
end_if_16:
    mov rax, QWORD [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret
end_if_15:
    mov rax, 57
    push rax
    mov al, BYTE [rbp - 33]
    pop rbx
    cmp al, bl
    seta al
    cmp rax, 0
    je end_if_17
if_17:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop rbx
    cmp rax, rbx
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_18
if_18:
    mov rax, QWORD [rbp - 16]
    neg rax
    mov rsp, rbp
    pop rbp
    ret
end_if_18:
    mov rax, QWORD [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret
end_if_17:
    mov rax, 48
    push rax
    mov al, BYTE [rbp - 33]
    movzx rax, al
    pop rbx
    sub rax, rbx
    mov QWORD [rbp - 41], rax
    mov rax, QWORD [rbp - 41]
    push rax
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 16]
    pop rbx
    imul rax, rbx
    pop rbx
    add rax, rbx
    mov QWORD [rbp - 16], rax
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 24]
    pop rbx
    add rax, rbx
    mov QWORD [rbp - 24], rax
    jmp while_14
end_while_14:
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 32]
    pop rbx
    cmp rax, rbx
    sete al
    movzx rax, al
    cmp rax, 0
    je end_if_19
if_19:
    mov rax, QWORD [rbp - 16]
    neg rax
    mov rsp, rbp
    pop rbp
    ret
end_if_19:
    mov rax, QWORD [rbp - 16]
    mov rsp, rbp
    pop rbp
    ret


std__print_newline:
    push rbp
    mov rbp, rsp
    sub rsp, 0

    sub rsp, 1
    mov byte [rsp], 10
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1
    syscall
    add rsp, 1
    mov rsp, rbp
    pop rbp
    ret


std__print_char:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rbp - 1], dil
    movsx rax, BYTE [rbp - 1]
    sub rsp, 1
    mov [rsp], al
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1
    syscall
    add rsp, 1
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


std__print_num:
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
    je end_if_20
if_20:
    sub rsp, 1
    mov byte [rsp], '-'
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1
    syscall
    add rsp, 1
    mov rax, QWORD [rbp - 8]
    neg rax
    mov QWORD [rbp - 8], rax
end_if_20:
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 8]
    pop rbx
    cmp rax, rbx
    setge al
    movzx rax, al
    cmp rax, 0
    je end_if_21
if_21:
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 8]
    pop rbx
    mov r10, rbx
    push rdx
    cqo
    idiv r10
    pop rdx
    mov QWORD [rbp - 25], rax
    mov rax, QWORD [rbp - 25]
    mov rdi, rax
    call std__print_num
end_if_21:
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 8]
    pop rbx
    mov r10, rbx
    push rdx
    cqo
    idiv r10
    mov rax, rdx
    pop rdx
    mov QWORD [rbp - 16], rax
    mov rax, 48
    push rax
    mov rax, QWORD [rbp - 16]
    pop rbx
    add al, bl
    mov BYTE [rbp - 17], al
    mov rax, 1
    mov rdi, 1
    lea rsi, [rbp - 17]
    mov rdx, 1
    syscall
    mov rsp, rbp
    pop rbp
    ret


std__print_num_u:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 8]
    pop rbx
    cmp rax, rbx
    setae al
    movzx rax, al
    cmp rax, 0
    je end_if_22
if_22:
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 8]
    pop rbx
    mov r10, rbx
    push rdx
    xor rdx, rdx
    div r10
    pop rdx
    mov QWORD [rbp - 25], rax
    mov rax, QWORD [rbp - 25]
    mov rdi, rax
    call std__print_num_u
end_if_22:
    mov rax, 10
    push rax
    mov rax, QWORD [rbp - 8]
    pop rbx
    mov r10, rbx
    push rdx
    xor rdx, rdx
    div r10
    mov rax, rdx
    pop rdx
    mov QWORD [rbp - 16], rax
    mov rax, 48
    push rax
    mov rax, QWORD [rbp - 16]
    pop rbx
    add al, bl
    mov BYTE [rbp - 17], al
    mov rax, 1
    mov rdi, 1
    lea rsi, [rbp - 17]
    mov rdx, 1
    syscall
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
while_23:
    mov rax, 0
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 16]
    imul rax, rax, 1
    pop rbx
    add rax, rbx
    movzx rax, BYTE [rax]
    pop rbx
    cmp al, bl
    setne al
    cmp rax, 0
    je end_while_23
    mov rax, [rbp - 8]
    push rax
    mov rax, QWORD [rbp - 16]
    imul rax, rax, 1
    pop rbx
    add rax, rbx
    movzx rax, BYTE [rax]
    mov dil, al
    call std__print_char
    mov rax, 1
    push rax
    mov rax, QWORD [rbp - 16]
    pop rbx
    add rax, rbx
    mov QWORD [rbp - 16], rax
    jmp while_23
end_while_23:
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
    je match_24_0
    cmp rax, 1
    je match_24_1
    cmp rax, 2
    je match_24_2
    cmp rax, 3
    je match_24_3
    cmp rax, 4
    je match_24_4
    cmp rax, 5
    je match_24_5
    cmp rax, 6
    je match_24_6
    cmp rax, 7
    je match_24_7
    cmp rax, 8
    je match_24_8
    cmp rax, 9
    je match_24_9
    cmp rax, 10
    je match_24_10
    cmp rax, 11
    je match_24_11
    cmp rax, 12
    je match_24_12
    cmp rax, 13
    je match_24_13
    cmp rax, 14
    je match_24_14
    cmp rax, 15
    je match_24_15
    cmp rax, 16
    je match_24_16
    cmp rax, 17
    je match_24_17
    cmp rax, 18
    je match_24_18
    cmp rax, 19
    je match_24_19
    cmp rax, 20
    je match_24_20
    cmp rax, 21
    je match_24_21
    cmp rax, 22
    je match_24_22
    cmp rax, 23
    je match_24_23
    cmp rax, 24
    je match_24_24
    cmp rax, 25
    je match_24_25
    cmp rax, 26
    je match_24_26
    cmp rax, 27
    je match_24_27
    cmp rax, 28
    je match_24_28
    cmp rax, 29
    je match_24_29
    cmp rax, 30
    je match_24_30
    cmp rax, 31
    je match_24_31
    cmp rax, 32
    je match_24_32
    cmp rax, 33
    je match_24_33
    cmp rax, 34
    je match_24_34
    cmp rax, 35
    je match_24_35
    cmp rax, 36
    je match_24_36
    cmp rax, 37
    je match_24_37
    cmp rax, 38
    je match_24_38
    jmp match_end_24
match_24_0:
    lea rax, [rel str_25]
    mov rdi, rax
    call std__println___0
    mov rax, 1
    mov edi, eax
    call std__exit
    jmp match_end_24
match_24_1:
    mov QWORD [rbp - 32], 1
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_2:
    mov QWORD [rbp - 32], 2
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_3:
    mov QWORD [rbp - 32], 3
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_4:
    mov QWORD [rbp - 32], 4
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_5:
    mov QWORD [rbp - 32], 5
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_6:
    mov QWORD [rbp - 32], 6
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_7:
    mov QWORD [rbp - 32], 7
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_8:
    mov QWORD [rbp - 32], 8
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_9:
    mov QWORD [rbp - 32], 9
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_10:
    mov QWORD [rbp - 32], 10
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_11:
    mov QWORD [rbp - 32], 11
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_12:
    mov QWORD [rbp - 32], 12
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_13:
    mov QWORD [rbp - 32], 13
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_14:
    mov QWORD [rbp - 32], 14
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_15:
    mov QWORD [rbp - 32], 15
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_16:
    mov QWORD [rbp - 32], 16
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_17:
    mov QWORD [rbp - 32], 17
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_18:
    mov QWORD [rbp - 32], 18
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_19:
    mov QWORD [rbp - 32], 19
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_20:
    mov QWORD [rbp - 32], 20
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_21:
    mov QWORD [rbp - 32], 21
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_22:
    mov QWORD [rbp - 32], 22
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_23:
    mov QWORD [rbp - 32], 23
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_24:
    mov QWORD [rbp - 32], 24
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_25:
    mov QWORD [rbp - 32], 25
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_26:
    mov QWORD [rbp - 32], 26
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_27:
    mov QWORD [rbp - 32], 27
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_28:
    mov QWORD [rbp - 32], 28
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_29:
    mov QWORD [rbp - 32], 29
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_30:
    mov QWORD [rbp - 32], 30
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_31:
    mov QWORD [rbp - 32], 31
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_32:
    mov QWORD [rbp - 32], 32
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_33:
    mov QWORD [rbp - 32], 33
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_34:
    mov QWORD [rbp - 32], 34
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_35:
    mov QWORD [rbp - 32], 35
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_36:
    mov QWORD [rbp - 32], 36
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_37:
    mov QWORD [rbp - 32], 37
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_24_38:
    mov QWORD [rbp - 32], 38
    lea rax, [rbp - 32]
    mov rdi, [rbp - 8]
    mov rcx, rax
    mov rdx, [rcx + 0]
    mov [rdi + 0], rdx
    mov rax, [rbp - 8]
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_24
match_end_24:


std__errno_to_num:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp - 8], rdi
    lea rax, [rbp - 8]
    mov [rbp - 16], rax
    mov rax, [rax]
    cmp rax, 1
    je match_26_1
    cmp rax, 2
    je match_26_2
    cmp rax, 3
    je match_26_3
    cmp rax, 4
    je match_26_4
    cmp rax, 5
    je match_26_5
    cmp rax, 6
    je match_26_6
    cmp rax, 7
    je match_26_7
    cmp rax, 8
    je match_26_8
    cmp rax, 9
    je match_26_9
    cmp rax, 10
    je match_26_10
    cmp rax, 11
    je match_26_11
    cmp rax, 12
    je match_26_12
    cmp rax, 13
    je match_26_13
    cmp rax, 14
    je match_26_14
    cmp rax, 15
    je match_26_15
    cmp rax, 16
    je match_26_16
    cmp rax, 17
    je match_26_17
    cmp rax, 18
    je match_26_18
    cmp rax, 19
    je match_26_19
    cmp rax, 20
    je match_26_20
    cmp rax, 21
    je match_26_21
    cmp rax, 22
    je match_26_22
    cmp rax, 23
    je match_26_23
    cmp rax, 24
    je match_26_24
    cmp rax, 25
    je match_26_25
    cmp rax, 26
    je match_26_26
    cmp rax, 27
    je match_26_27
    cmp rax, 28
    je match_26_28
    cmp rax, 29
    je match_26_29
    cmp rax, 30
    je match_26_30
    cmp rax, 31
    je match_26_31
    cmp rax, 32
    je match_26_32
    cmp rax, 33
    je match_26_33
    cmp rax, 34
    je match_26_34
    cmp rax, 35
    je match_26_35
    cmp rax, 36
    je match_26_36
    cmp rax, 37
    je match_26_37
    cmp rax, 38
    je match_26_38
    jmp match_26_wildcard
    jmp match_end_26
match_26_1:
    mov rax, 1
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_2:
    mov rax, 2
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_3:
    mov rax, 3
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_4:
    mov rax, 4
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_5:
    mov rax, 5
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_6:
    mov rax, 6
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_7:
    mov rax, 7
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_8:
    mov rax, 8
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_9:
    mov rax, 9
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_10:
    mov rax, 10
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_11:
    mov rax, 11
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_12:
    mov rax, 12
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_13:
    mov rax, 13
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_14:
    mov rax, 14
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_15:
    mov rax, 15
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_16:
    mov rax, 16
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_17:
    mov rax, 17
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_18:
    mov rax, 18
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_19:
    mov rax, 19
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_20:
    mov rax, 20
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_21:
    mov rax, 21
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_22:
    mov rax, 22
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_23:
    mov rax, 23
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_24:
    mov rax, 24
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_25:
    mov rax, 25
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_26:
    mov rax, 26
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_27:
    mov rax, 27
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_28:
    mov rax, 28
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_29:
    mov rax, 29
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_30:
    mov rax, 30
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_31:
    mov rax, 31
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_32:
    mov rax, 32
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_33:
    mov rax, 33
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_34:
    mov rax, 34
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_35:
    mov rax, 35
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_36:
    mov rax, 36
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_37:
    mov rax, 37
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_38:
    mov rax, 38
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_26_wildcard:
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret
    jmp match_end_26
match_end_26:


test__io__hello:
    push rbp
    mov rbp, rsp
    sub rsp, 0

    lea rax, [rel str_27]
    mov rdi, rax
    call std__println___0
    mov rsp, rbp
    pop rbp
    ret


test__io__hello2:
    push rbp
    mov rbp, rsp
    sub rsp, 0

    call test__io__hello
    mov rsp, rbp
    pop rbp
    ret


main:
    push rbp
    mov rbp, rsp
    sub rsp, 0

    call test__io__hello
    lea rax, [rel str_28]
    mov rdi, rax
    call std__println___0
    mov rsp, rbp
    pop rbp
    ret


