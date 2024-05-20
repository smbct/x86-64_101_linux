.global _start, _before_call, _after_call, debug, debug2
.intel_syntax noprefix

# compilation: as hello_world_func.s -o hello_world_func.o
# linking: gcc -static -nostdlib hello_world_func.o -o hello_world_func

_print_hello_world:

    # rsp+8 : nb_repeat parameter
    # rsp : return address

    for_loop_print:

        mov rax, 1
        mov rdi, 1
        lea rsi, [hello_world]
        mov rdx, 14
        syscall

        mov rax, [rsp+8]
        dec qword ptr [rsp+8]
        mov rax, [rsp+8]
        test rax, rax
        jnz for_loop_print

    ret

_start:

    push qword ptr 5

    _before_call:
    call _print_hello_world
    _after_call:

    # popping the parameter stored on the stack
    pop rax

    # exit
    mov rax, 60
    mov rdi, 69
    syscall

hello_world:
    .asciz "Hello, World!\n"
