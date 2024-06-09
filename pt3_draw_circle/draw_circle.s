.global _start
.intel_syntax noprefix

# compilation: as draw_circle.s -o draw_circle.o
# linking: gcc -static -nostdlib draw_circle.o -o draw_circle

_start:

    mov rbp, rsp
    sub rsp, 40
    # row index : offset=8, size=8
    # column index : offset=16, size=8
    # square center : offset=24, size=8
    # radius squared : offset=32, size=8
    # distance squared : offset=40, size=8

    # rax is temporary used to compute square_size/2
    mov rax, [square_size]
    shr rax
    # storing the value in the square center variable
    mov qword ptr [rbp-24], rax

    # rax is squared
    imul rax, rax
    # storing the squared radius
    mov qword ptr [rbp-32], rax


    mov qword ptr [rbp-8], 0 # row index var is set to 0
    .L_for_loop_rows:    

        mov qword ptr [rbp-16], 0 # col index var is set to 0
        .L_for_loop_columns:

            # compute (row_index - square_center)² into distance_squared
            mov rax, [rbp-8]
            sub rax, [rbp-24]
            imul rax, rax
            mov [rbp-40], rax

            # add (col_index - square_center)² to distance_squared
            mov rax, [rbp-16]
            sub rax, [rbp-24]
            imul rax, rax
            add [rbp-40], rax

            # compare distance_squared to radius_squared
            mov rax, [rbp-32]
            cmp [rbp-40], rax
            jge .L_print_space

            # .L_print_star:
                lea rsi, [star_character]
                jmp .L_end_print
            .L_print_space:
                lea rsi, [space_character]
            .L_end_print:

            # printing the chosen character
            mov rax, 1
            mov rdi, 1
            mov rdx, 1
            syscall

            # printing a space
            mov rax, 1
            mov rdi, 1
            lea rsi, [space_character]
            mov rdx, 1
            syscall

            # increment col index var
            inc qword ptr [rbp-16]
            # test column loop termination
            mov rax, [rbp-16]
            cmp rax, [square_size]
            jne .L_for_loop_columns

        # writing a new line
        mov rax, 1
        mov rdi, 1
        lea rsi, [new_line]
        mov rdx, 1
        syscall
        
        # increment col index var
        inc qword ptr [rbp-8]
        # test row loop termination
        mov rax, [rbp-8]
        cmp rax, [square_size]
        jne .L_for_loop_rows

    # memory de allocation
    mov rsp, rbp

    # exit
    mov rax, 60
    mov rdi, 0
    syscall

square_size:
    .quad 20

star_character:
    .word '*'

space_character:
    .word ' '

new_line:
    .word '\n'
