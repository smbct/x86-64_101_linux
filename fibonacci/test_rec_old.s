.global main
.intel_syntax noprefix

# compilation: as test_rec.s -o test_rec.o
# linking: gcc test_rec.o -o test_rec

# rdi : arg
# recursive call until the argument equals 0
_test_rec:
    
    push rbp
    mov rbp, rsp

    sub rsp, 32
    # rbp-8 : arg (8 bytes)

    push rbx
    push rsi

    # store the local variable
    mov [rbp-8], rdi

    # compare the local variable to 0
    mov rbx, [rbp-8]
    test rbx, rbx
    jz endif

    # if_exponent_not_0:

        dec qword ptr [rbp-8]

        # store the left and right parameters for the next recursive call
        mov rdi, qword ptr [rbp-8]
        call _test_rec

    endif:

    pop rsi
    pop rbx

    leave
    ret

main:

    push rbp
    mov rbp, rsp

    push rbx
    push rsi

    # 
    mov rdi, qword ptr 1

    call _test_rec
    debug:

    # exit
    mov rax, 0

    pop rsi
    pop rbx

    leave
    ret
