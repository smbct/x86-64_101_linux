.global _start
.intel_syntax noprefix

# compilation: as multiply_rec.s -o multiply_rec.o
# linking: gcc -static -nostdlib multiply_rec.o -o multiply_rec

# rsp + 24 : first parameter (left)
# rsp + 16 : second parameter (right)
# return : left*right in rax
_multiply_rec:
    
    push rbp
    mov rbp, rsp

    sub rsp, 16
    # rbp-8 : left (8 bytes)
    # rbp-16 : right (8 bytes)

    # store the local variables
    mov rax, [rbp+24]
    mov [rbp-8], rax
    mov rax, [rbp+16]
    mov [rbp-16], rax

    # compare left to 1
    cmp [rbp-8], qword ptr 1
    jne else_left_not_1

    if_left_1:
        mov rax, [rbp-16]
        jmp endif

    else_left_not_1:
        dec qword ptr [rbp-8]

        # store the left and right parameters for the next recusrive call
        push qword ptr [rbp-8]
        push qword ptr [rbp-16]

        call _multiply_rec
        add rax, [rbp-16] # compute the result

        add rsp, 16

    endif:

    add rsp, 16

    mov rsp, rbp
    pop rbp

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
