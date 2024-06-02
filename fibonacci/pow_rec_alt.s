.global main
.intel_syntax noprefix

# compilation: as pow_rec_alt.s -o pow_rec_alt.o
# linking: gcc pow_rec_alt.o -o pow_rec_alt

# rdi : base
# rsi : exponent
# return : base^exponent in rax
_pow_rec:
    
    push rbp
    mov rbp, rsp

    sub rsp, 32
    # rbp-8 : base (8 bytes)
    # rbp-16 : exponent (8 bytes)

    push rbx
    push rsi

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
        mov rdi, qword ptr [rbp-8]
        mov rsi, qword ptr [rbp-16]
        call _pow_rec

        imul rax, [rbp-8] # compute the result

    .L_endif:

    pop rsi
    pop rbx

    leave
    debug2:
    ret

main:

    push rbp
    mov rbp, rsp

    push rbx
    push rsi

    # pushing the two parameters to the stack -> 5^3
    mov rdi, qword ptr 5
    mov rsi, qword ptr 3

    call _pow_rec
    debug:

    # exit
    mov rax, 0

    pop rsi
    pop rbx

    leave
    ret
