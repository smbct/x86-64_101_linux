.global _start, _pow_rec, if_exponent_0
.intel_syntax noprefix

# compilation: as pow_rec.s -o pow_rec.o
# linking: gcc -static -nostdlib pow_rec.o -o pow_rec

# rsp + 24 : base
# rsp + 16 : exponent
# return : base^exponent in rax
_pow_rec:
    
    push rbp
    mov rbp, rsp

    sub rsp, 16
    # rbp-8 : base (8 bytes)
    # rbp-16 : exponent (8 bytes)

    # store the local variables
    mov rax, [rbp+24]
    mov [rbp-8], rax
    mov rax, [rbp+16]
    mov [rbp-16], rax

    # compare the exponent to 0
    mov rbx, [rbp-16]
    test rbx, rbx
    jnz else_exponent_not_0

    if_exponent_0:

        mov rax, 1
        jmp endif

    else_exponent_not_0:

        dec qword ptr [rbp-16]

        # store the left and right parameters for the next recursive call
        push qword ptr [rbp-8]
        push qword ptr [rbp-16]
        call _pow_rec

        imul rax, [rbp-8] # compute the result

        add rsp, 16

    endif:

    mov rsp, rbp
    pop rbp

    ret

_start:

    push rbp
    mov rbp, rsp

    # pushing the two parameters to the stack -> 5^3
    push qword ptr 5
    push qword ptr 3

    call _pow_rec
    debug:

    # popping the parameters stored on the stack
    add rsp, 16

    mov rsp, rbp
    pop rbp

    # exit
    mov rax, 60
    mov rdi, 0
    syscall
