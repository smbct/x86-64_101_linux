.global main
.intel_syntax noprefix

# as -g call_custom_c.s -o call_custom_c.o && gcc -g  custom_functions.c -c -o custom_functions.o && gcc -static call_custom_c.o custom_functions.o -o call_custom_c

main:

    push rbp
    mov rbp, rsp

    sub sp, my_array_length
    
    # automatic 16 bytes alignement of rsp    
    mov rax, rsp # temporary storing the stack pointer
    and rax, 15 # computing rsp modulo 16 to compute the misalignement
    sub rsp, rax # subtracting byte to align rsp

    # init an array
    mov rdi, rbp
    sub di, my_array_length
    mov si, my_array_length
    call init_array_c

    # printing an array
    mov rdi, rbp
    sub di, my_array_length
    mov si, my_array_length
    call print_array_c

    # init the random seed
    mov edi, 42
    call srand

    # shuffle the array
    mov rdi, rbp
    sub di, my_array_length
    mov si, my_array_length
    call shuffle_array_c

    # printing an array
    mov rdi, rbp
    sub di, my_array_length
    mov si, my_array_length
    call print_array_c

    call test_functions_c

    mov rsp, rbp
    pop rbp

    # return
    mov rax, 0
    ret

my_array_length:
    .word 10
