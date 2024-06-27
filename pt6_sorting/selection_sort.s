.global selection_sort
.intel_syntax noprefix

# ####################################################################
# Sort an array with the selection sort algorithm
# rdi : array pointer
# si : array length
selection_sort:

    push rbp
    mov rbp, rsp

    sub rsp, 48 
    # rbp-8 : (8 bytes) array address for the main iteration
    # rbp-10 : (2 bytes) array length
    # rbp-12 : (2 bytes) outer index
    # rbp-14 : (2 bytes) inner index
    # rbp-22 : (8 bytes) outer array address
    # rbp-30 : (8 bytes) inner array address
    # rbp-32 : (2 bytes) sub-array min index
    # rbp-33 : (1 byte) temp value for swapping

    # variable initialization
    mov [rbp-8], rdi # array address
    mov [rbp-10], si # array length

    mov [rbp-12], word ptr 0 # init the outer array index
    mov [rbp-22], rdi # init the outer array address

    .L_outer_for:

        # init the inner array index <- array_index+1
        mov ax, [rbp-12]
        mov [rbp-14], ax
        inc word ptr [rbp-14]
        

        # init the sub-array min index
        mov [rbp-32], ax

        # init the inner array address
        mov rax, [rbp-22]
        mov [rbp-30], rax
        inc qword ptr [rbp-30]

        # init the temp value (current min) with the outer current element
        mov rax, [rbp-22]
        mov al, [rax]
        mov [rbp-33], al

        .L_inner_for:

            mov rax, [rbp-30]
            mov al, [rax] # inner array value

            cmp al, [rbp-33] # current min value
            
            jge .L_else_not_lower

            # .L_if_lower update the min index
                
                mov rax, [rbp-30]  
                mov al, [rax]
                mov [rbp-33], al # store the current min in the temp variable

                mov ax, [rbp-14]
                mov [rbp-32], ax # record the index 

            .L_else_not_lower:

            # increase the inner address
            inc qword ptr [rbp-30]

            # increase the inner index and compare with the array length
            inc word ptr [rbp-14]
            mov ax, [rbp-10]
            cmp ax, [rbp-14]
            jne .L_inner_for

        # ----------------------------------------
        # swap the values
        
        # debug
        mov al, [rbp-33]


        # mov the addres of the min element in the inner address variable
        xor rax, rax
        add al, [rbp-32]
        add rax, [rbp-8]
        mov [rbp-30], rax

        # move the value at the outer address to the temp variable 
        mov rax, [rbp-22]
        mov al, [rax]
        mov [rbp-33], al # the outer element is stored in the temp variable

        # swap the values : inner to outer
        mov rax, [rbp-30]
        mov al, [rax]
        mov rcx, [rbp-22]
        mov [rcx], al

        # temp to inner
        mov al, [rbp-33] # get the temp value
        mov rcx, [rbp-30]
        mov [rcx], al # store it to the inner
         

        # increase the outer address
        inc qword ptr [rbp-22]

        # increase the outer index and compare with the array length
        inc word ptr [rbp-12]
        mov ax, [rbp-12]
        inc ax
        cmp ax, [rbp-10]
        jne .L_outer_for



    mov rsp, rbp
    pop rbp

    ret
