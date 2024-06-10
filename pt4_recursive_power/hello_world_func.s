.global _start
.intel_syntax noprefix

# compilation: as -g hello_world_func.s -o hello_world_func.o
# linking: gcc -static -nostdlib hello_world_func.o -o hello_world_func

_print_hello_world:
    
    mov rax, 1
    mov rdi, 1
    lea rsi, [hello_world]
    mov rdx, 14
    syscall

    ret

_start:

    call _print_hello_world

    # exit
    mov rax, 60
    mov rdi, 0
    syscall

hello_world:
    .asciz "Hello, World!\n"
