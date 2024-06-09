.global _start, _before_call, _after_call, debug, debug2
.intel_syntax noprefix

# compilation: as hello_world_func.s -o hello_world_func.o
# linking: gcc -static -nostdlib hello_world_func.o -o hello_world_func

_print_hello_world:
    
    mov rax, 1
    mov rdi, 1
    lea rsi, [hello_world]
    mov rdx, 14
    syscall

    ret

_start:

    _before_call:
    call _print_hello_world
    _after_call:

    # popping the parameter stored on the stack
    pop rax

    # exit
    mov rax, 60
    mov rdi, 0
    syscall

hello_world:
    .asciz "Hello, World!\n"
