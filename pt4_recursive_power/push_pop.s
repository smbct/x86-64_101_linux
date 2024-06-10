.global _start, debug, debug2
.intel_syntax noprefix

# compilation: as -g push_pop.s -o push_pop.o
# linking: gcc -static -nostdlib push_pop.o -o push_pop

_start:
    mov rbp, rsp

    # moving the value 42 into 8 bytes in the stack
    push qword ptr 42

    pop rax

    mov rsp, rbp

    # exit
    mov rax, 60
    mov rdi, 0
    syscall
