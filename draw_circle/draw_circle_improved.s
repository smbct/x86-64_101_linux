.global _start
.intel_syntax noprefix

# compilation: as draw_circle.s -o draw_circle.o
# linking: gcc -static -nostdlib draw_circle.o -o draw_circle

_start:

    push rbp
    mov rbp, rsp
    
    sub rsp, 12
    # local variables
    # 4: (4) column_index
    # 4: (8) row index
    # 4: (12) square center
    # 4: (16) squared radius
    # 4: (20) temp_distance

    # initialize the square center
    mov ax, [rect_size]
    shr ax
    mov [rbp-12], ax

    # inialize the radius and squared radius local variables
    mov cx, [diameter]
    shr cx
    imul cx, cx
    mov [rbp-16], cx

    # row index variable is initialized to 0
    mov [rbp-8], word ptr 0

    # loop on the rows
   row_loop:

        # column index variable initialized to 0
        mov [rbp-4], word ptr 0

        # loop on the columns
        column_loop:

            # test if the current character is inside the circle
            mov ax, [rbp-4]
            sub ax, [rbp-12]
            imul ax, ax
            mov [rbp-20], ax
            mov ax, [rbp-8]
            sub ax, [rbp-12]
            imul ax, ax
            add [rbp-20], ax
            mov ax, [rbp-20]
            cmp ax, [rbp-16]

            jge draw_space

            # draw_star:

                # test if a star should be drawn
                mov rax, 1
                mov rdi, 1
                lea rsi, [star_symbol]
                mov rdx, 1
                syscall
                
                jmp skip_space

            draw_space:

                mov rax, 1
                mov rdi, 1
                lea rsi, [space_symbol]
                mov rdx, 1
                syscall

            skip_space:

            mov rax, 1
            mov rdi, 1
            lea rsi, [space_symbol]
            mov rdx, 1
            syscall

            # increment the column index variable
            inc word ptr [rbp-4]

            mov cx, [rect_size]
            cmp [rbp-4], cx
            jne column_loop

        # print a new line
        mov rax, 1
        mov rdi, 1
        lea rsi, [new_line]
        mov rdx, 1
        syscall

        # increment the row index variable
        inc word ptr [rbp-8]

        mov cx, [rect_size]
        cmp [rbp-8], cx
        jne row_loop

    # exit system call
    mov rax, 60
    mov rdi, 69
    syscall

    mov rsp, rbp
    pop rbp

star_symbol:
    .word '*'

space_symbol:
    .word ' '

new_line:
    .word '\n'

rect_size:
    .word 20

diameter:
    .word 20

# data types: https://software-dl.ti.com/codegen/docs/tiarmclang/compiler_tools_user_guide/gnu_syntax_arm_asm_language/gnu_arm_directives/data_defining_directives.html#gar-data-defining-directives
