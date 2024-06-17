.global main
.intel_syntax noprefix


# as call_custom_c_2.s -o call_custom_c_2.o && gcc  custom_functions.c -c -o custom_functions.o && gcc -static call_custom_c_2.o custom_functions.o -o call_custom_c_2

main:

    push rbp
    mov rbp, rsp

    sub sp, my_array_length
    
    # automatic 16 bytes alignement of rsp    
    mov rax, rsp # temporary storing the stack pointer
    and rax, 15 # computing rsp modulo 15 to compute the misalignement
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

    mov rsp, rbp
    pop rbp

    # return
    mov rax, 0
    ret

my_array_length:
    .word 10
