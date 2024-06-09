.global _start
.intel_syntax noprefix

# as test.s -o test.o && gcc -static -nostdlib test.o -o test

_multiply_rec:
    mov rbp, rsp
    mov rbx, [rbp+8]
    debug:
    mov rsp, rbp
    ret

_start:

    # pushing the two parameters to the stack
    push qword ptr 5
    push qword ptr 4

    call _multiply_rec

    # popping the parameters stored on the stack
    add rsp, 16

    # exit
    mov rax, 60
    mov rdi, 0
    syscall
