.global _start, debug
.intel_syntax noprefix

# compilation: as draw_circle.s -o draw_circle.o
# linking: gcc -static -nostdlib draw_circle.o -o draw_circle

_start:

    sub rsp, 4

    mov [rsp], dword ptr 42

    mov eax, [rsp]
    debug:

    # exit
    mov rax, 60
    mov rdi, 69
    syscall
