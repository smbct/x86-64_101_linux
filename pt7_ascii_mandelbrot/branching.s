.global main
.intel_syntax noprefix

# compilation: as -g branching.s -o branching.o
# linking: gcc branching.o -static -o branching

# ####################################################################
# main function (libc main)
main:

    # stack alignment
    sub rsp, 8

    mov al, 41
    mov bl, 42

    cmp al, bl
    jbe .L_endif

    # if_branch

        # printing
        xor eax, eax
        lea rdi, [jumping_str]
        call printf

    .L_endif:
    
    # restoring the rsp pointer
    add rsp, 8

    # return
    mov rax, 0
    ret

jumping_str:
    .asciz "not jumping!\n"

