.global main
.intel_syntax noprefix

# compilation: as main.s -o main.o
# as print_array.s -o print_array.o
# linking: gcc print_array.o main.o -static -o main

# ####################################################################
# main function (libc main)
main:
    
    push rbp # storing the rbp value before manipulation
    mov rbp, rsp # storing the rsp register

    # stack allocation
    sub rsp, 8 # store the address of the array copy
    xor rax, rax
    mov ax, [my_array_length] # the length is stored on a word : 4 bytes -> ax registers
    sub rsp, rax # store the array

    # automatic 16 bytes alignement of rsp    
    mov rax, rsp # temporary storing the stack pointer
    and rax, 15 # computing rsp modulo 16 to compute the misalignement
    xor rsp, rax # subtracting byte to align rsp

    # storing the preserved registers
    push rdi
	push rsi

    # store the address of the array copy
    xor rax, rax
    mov ax, [my_array_length]
    mov rcx, rbp
    sub rcx, 8
    sub rcx, rax
    mov [rbp-8], rcx

    # copy the array
    lea rdi, my_array
    mov si, [my_array_length]
    mov rdx, [rbp-8]
    call copy_array

    # -------------------------------------------------------------
    # Print the original array

    # printing the "My array : " string
    xor eax, eax
    lea rdi, [my_array_str]
    call printf

    # calling the print_array function with parameters
    lea rdi, [my_array]
    mov si, [my_array_length]
    call print_array

    # printing a new line
    xor eax, eax
    lea rdi, [new_line]
    call printf

    # -------------------------------------------------------------
    # Init the copy array

    # initialize the array
    # mov rdi, [rbp-8]
    # mov si, [my_array_length]
    # call init_array

    # -------------------------------------------------------------
    # Selection sort of the copy array
    mov rdi, [rbp-8]
    mov si, [my_array_length]
    call selection_sort

    # -------------------------------------------------------------
    # Print the copy array

    # printing the "My array : " string
    xor eax, eax
    lea rdi, [my_array_copy_str]
    call printf

    # calling the print_array function with parameters
    mov rdi, [rbp-8]
    mov si, [my_array_length]
    call print_array

    # printing a new line
    xor eax, eax
    lea rdi, [new_line]
    call printf

    # restoring the preserved registers
	pop rsi
	pop rdi

    # restoring the rsp and rbp registers
    mov rsp, rbp
    pop rbp

    # return
    mov rax, 0
    ret

my_array:
    .byte 5, 12, 42, 8, 1, 3, 7, 25, 14
my_array_length:
    .word 9

new_line:
    .asciz "\n"
my_array_str:
    .asciz "My array :        "
my_array_copy_str:
    .asciz "My array sorted : "
