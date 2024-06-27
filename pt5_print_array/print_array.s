.global main
.intel_syntax noprefix

# compilation: as print_array.s -o print_array.o
# linking: gcc print_array.o -static -o print_array

# ####################################################################
# print an array (encoded on bytes)
# rdi : array pointer
# si : array length
print_array:

    # storing the rsp value before manipulation
    push rbp
    mov rbp, rsp

    # rbp - 8 : array pointer, 8 bytes
    # rbp - 10 : array index, 2 bytes
    # rbp - 12 : array size, 2 bytes
    # 4 padding bytes
    sub rsp, 16
    
    mov [rbp-8], rdi # loading the array pointer
    mov [rbp-10], word ptr 0 # array_index <- 0
    mov [rbp-12], si # loading the array length

    # printing the "my_array_str" string
    xor eax, eax
    lea rdi, [my_array_str]
    call printf

    .L_for_loop_writing_1:

        # printing the "my_array_str" string
        xor eax, eax
        lea rdi, [array_elt_formatter]
        mov rsi, [rbp-8] # load the array pointer
        mov sil, [rsi] # load the value stored at the address
        call printf

        inc qword ptr [rbp-8] # increase the array pointer
        inc word ptr [rbp-10] # increase the array index
        mov ax, [rbp-10]
        cmp ax, [rbp-12]
        mov bx, [rbp-12]

        jne .L_for_loop_writing_1 # test if all characters have been printed

    # printing a new line
    xor eax, eax
    lea rdi, [new_line]
    call printf

    # restoring the rsp value
    mov rsp, rbp
    pop rbp

    ret

# ####################################################################
# print an array (encoded on bytes)
print_array_noparams:

    # storing the rsp value before manipulation
    push rbp
    mov rbp, rsp

    # rbp - 8 : array pointer, 8 bytes
    # rbp - 10 : array index, 2 bytes
    # rbp - 12 : array size, 2 bytes
    # 4 padding bytes
    sub rsp, 16
    
    lea rax,  [my_array] 
    mov [rbp-8], rax # loading the array pointer
    mov [rbp-10], word ptr 0 # array_index <- 0
    mov ax, my_array_length
    mov [rbp-12], ax # loading the array length

    # printing the "my_array_str" string
    xor eax, eax
    lea rdi, [my_array_str]
    call printf

    .L_for_loop_writing_2:

        # printing the "my_array_str" string
        xor eax, eax
        lea rdi, [array_elt_formatter]
        mov rsi, [rbp-8] # load the array pointer
        mov sil, [rsi] # load the value stored at the address
        call printf

        inc byte ptr [rbp-8] # increase the array pointer
        inc word ptr [rbp-10] # increase the array index
        mov ax, [rbp-10]
        cmp ax, [rbp-12]
        mov bx, [rbp-12]

        jne .L_for_loop_writing_2 # test if all characters have been printed

    # printing a new line
    xor eax, eax
    lea rdi, [new_line]
    call printf

    # restoring the rsp value
    mov rsp, rbp
    pop rbp
    ret

# ####################################################################
# main function (libc main)
main:

    
    push rbp # storing the rbp value before manipulation
    mov rbp, rsp # storing the rsp register

    # calling the pint_array_noparams function that takes no parameters
    call print_array_noparams

    # calling the print_array function with parameters
    lea rdi, [my_array]
    mov si, [my_array_length]
    call print_array

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

array_elt_formatter:
    .asciz "%hhd "
new_line:
    .asciz "\n"
my_array_str:
    .asciz "My array : "

hello_world:
    .asciz "Hello, World!\n"
