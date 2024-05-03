.global _start
.intel_syntax noprefix

# compilation: as hellow_world.s -o hello_world.o
# linking: gcc -static -nostdlib hello_wolrd.o -o hello_world

_start:

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
