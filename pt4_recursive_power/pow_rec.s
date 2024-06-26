.global _start
.intel_syntax noprefix

# compilation: as -g pow_rec.s -o pow_rec.o
# linking: gcc -static -nostdlib pow_rec.o -o pow_rec

# params: 
# rdi : base
# rsi : exponent
# return : base^exponent in rax
_pow_rec:
    
    push rbp
    mov rbp, rsp

    sub rsp, 16
    # rbp-8 : base (8 bytes)
    # rbp-16 : exponent (8 bytes)

    # store the local variables
    mov [rbp-8], rdi
    mov [rbp-16], rsi

    # compare the exponent to 0
    mov rbx, [rbp-16]
    test rbx, rbx
    jnz .L_else_exponent_not_0

    .L_if_exponent_0:

        mov rax, 1
        jmp .L_endif

    .L_else_exponent_not_0:

        dec qword ptr [rbp-16]

        # store the left and right parameters for the next recursive call
        mov rdi, [rbp-8]
        mov rsi, [rbp-16]
        call _pow_rec

        imul rax, [rbp-8] # compute the result

    .L_endif:

    mov rsp, rbp
    pop rbp

    ret

_start:

    push rbp
    mov rbp, rsp

    # pushing the two parameters to the stack -> 5^3
    mov rdi, 5
    mov rsi, 3

    call _pow_rec

    mov rsp, rbp
    pop rbp

    # exit
    mov rax, 60
    mov rdi, 0
    syscall
