.global _hello_world_assembly
.intel_syntax noprefix

# compilation: as hello_world.s -o hello_world.o
# linking: gcc -static -nostdlib hello_world.o -o hello_world

_hello_world_assembly:

    push rbp
    mov rbp, rsp

    mov rax, 1
    mov rdi, 1
    lea rsi, [hello_world_str]
    mov rdx, 14
    syscall

    mov rsp, rbp
    pop rbp
    ret

hello_world_str:
    .asciz "Hello, World!\n"
