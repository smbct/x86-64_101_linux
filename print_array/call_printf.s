.global main
.intel_syntax noprefix

# compilation: as call_printf.s -o call_printf.o
# linking: gcc call_printf.o -static -o call_printf

# ####################################################################
# main function (libc main)
main:

    # storing the rsp value before manipulation
    push rbp
    mov rbp, rsp

    # (automatic) 16 bytes alignement of rsp    
    mov rax, rsp # temporary storing the stack pointer
    and rax, 15 # computing rsp modulo 15 to compute the misalignement
    sub rsp, rax # subtrackting byte to align rsp
    # alternatively, alignement can be simply performed here by : sub rsp, 8

    # printing hello_world with a system call
    mov rax, 1
    mov rdi, 1
    lea rsi, [hello_world]
    mov rdx, 14
    syscall

    # printing hello_world with printf
    xor eax, eax
    lea rdi, [hello_world]
    call printf

    # printing an integer value
    xor eax, eax
    lea rdi, [integer_formatter]
    mov rsi, 42
    call printf

    # restoring the rsp value
    mov rsp, rbp
    pop rbp

    # return
    mov rax, 0
    ret

hello_world:
    .asciz "Hello, World!\n"

integer_formatter:
    .asciz "integer value: %i\n"
