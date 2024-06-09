.global _start
.intel_syntax noprefix

_start:

    # allocating 4 bytes in the stack
    sub rsp, 4

    # storing the value 42 to the reserved space
    mov [rsp], dword ptr 42

    # inspecting the value through a register
    mov rax, [rsp]

    # memory is de-allocated by restoring the original rsp value
    add rsp, 4

    # exit
    mov rax, 60
    mov rdi, 0
    syscall
