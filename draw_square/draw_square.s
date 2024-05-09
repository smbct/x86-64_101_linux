.global _start, debug
.intel_syntax noprefix

# compilation: as draw_square.s -o draw_square.o
# linking: gcc -static -nostdlib draw_square.o -o draw_square

_start:


    mov r9, 0
    for_loop_rows:    

        mov r8, 0
        for_loop_columns:

            # printing a star
            mov rax, 1
            mov rdi, 1
            lea rsi, [star_character]
            mov rdx, 1
            syscall

            # printing a space
            mov rax, 1
            mov rdi, 1
            lea rsi, [space_character]
            mov rdx, 1
            syscall

            inc r8
            cmp r8, [square_size]
            jne for_loop_columns

        # writing a new line
        mov rax, 1
        mov rdi, 1
        lea rsi, [new_line]
        mov rdx, 1
        syscall
        
        inc r9
        cmp r9, [square_size]
        jne for_loop_rows

    

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
