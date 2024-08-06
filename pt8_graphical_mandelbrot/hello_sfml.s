.global main
.intel_syntax noprefix

main:
    
    push rbp # storing the rbp value before manipulation
    mov rbp, rsp # storing the rsp register

    # storing the preserved registers
    push rdi
	push rsi

    mov rax, 1
    mov rdi, 1
    lea rsi, [rip+hello_world]
    mov rdx, 14
    syscall

    pop rsi
    pop rdi

    # restoring the rsp and rbp registers
    mov rsp, rbp
    pop rbp

    # return
    mov rax, 0
    ret

hello_world:
    .asciz "Hello, World!\n"
