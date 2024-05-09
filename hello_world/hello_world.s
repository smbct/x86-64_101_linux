.global _start, debug
.intel_syntax noprefix

# compilation: as hello_world.s -o hello_world.o
# linking: gcc -static -nostdlib hello_world.o -o hello_world

_start:

    mov rax, 30
    add rax, 12
    debug:

    mov rax, 1
    mov rdi, 1
    lea rsi, [hello_world]
    mov rdx, 14
    syscall

    # exit
    mov rax, 60
    mov rdi, 69
    syscall


hello_world:
    .asciz "Hello, World!\n"
