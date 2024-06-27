.global print_array
.intel_syntax noprefix

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

    # restoring the rsp value
    mov rsp, rbp
    pop rbp

    ret

array_elt_formatter:
    .asciz "%hhd "
