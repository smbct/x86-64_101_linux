.global main
.intel_syntax noprefix

# as -g call_print_array_c.s -o call_print_array_c.o && gcc -g  print_array_c.c -c -o print_array_c.o && gcc -static call_print_array_c.o print_array_c.o -o call_print_array_c

main:

    push rbp
    mov rbp, rsp

    # printing an array
    lea rdi, my_array
    mov si, my_array_length
    call print_array_c

    mov rsp, rbp
    pop rbp

    # return
    mov rax, 0
    ret

my_array:
    .byte 5, 12, 42, 8, 1, 3, 7, 25, 14

my_array_length:
    .word 9
