.global _start
.intel_syntax noprefix

# compilation: as fibonacci.s -o fibonacci.o
# linking: gcc -static -nostdlib fibonacci.o -o fibonacci

# compute a fibonacci number recursively
# parameters are stored on the stack
# param : si : index of the fibonacci number to be computed, 2 bytes
# return value : f_n term, in the rax register
_compute_fibonacci_rec:
    
    push rbp
    mov rbp, rsp

    sub rsp, 18
    # local variables:
    # rbp-18 : sequence index, 2 bytes
    # rbp-16 : f_(n-2), 8 bytes
    # rbp-8 : f_(n-1), 8 bytes

    # fibonacci sequence :
    # f_0 = 0
    # f_1 = 1
    # f_n = f_(n-1) + f_(n-2)

    # store the index parameter in the stack
    mov [rbp-18], si

    # test the index value
    cmp word ptr [rbp-18], 1
    je if_n_1
    jg else_n_gt1
    
    if_n_0: # special case when n is 0, return 0
        mov rax, qword ptr 0
        jmp end_if_n

    if_n_1: # special case when n is 1, return 1
        mov rax, qword ptr 1
        jmp end_if_n

    else_n_gt1: # recursive case : compute f_(n-2) + f_(n-1)

        # compute f_(n-2)
        mov si, [rbp-18]
        sub si, 2
        call _compute_fibonacci_rec
        mov [rbp-16], rax

        # compute f_(n-1)
        mov si, [rbp-18]
        dec si
        call _compute_fibonacci_rec
        mov [rbp-8], rax

        # compute f_n = f_(n-2)+f_(n-1) in the rax register
        xor rax, rax
        add rax, [rbp-16]
        add rax, [rbp-8]

    end_if_n:

    mov rsp, rbp
    pop rbp

    ret


_start:

    mov si, 17
    call _compute_fibonacci_rec

    debug:

    # exit
    mov rax, 60
    mov rdi, 0
    syscall

