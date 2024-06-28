.global _start
.intel_syntax noprefix

# compilation: as main.s -o main.o && as mandelbrot.s -o mandelbrot.o
# linking: gcc -static -nostdlib main.o mandelbrot.o -o main

.section .text

_start:

    push rbp
    mov rbp, rsp

    mov edi, 80
    mov esi, 30
    call draw_mandelbrot    

    mov rsp, rbp
    pop rbp

    # exit
    mov rax, 60
    mov rdi, 0
    syscall

.section .data

square_size:
    .quad 20
star_character:
    .word '*'
space_character:
    .word ' '
new_line:
    .word '\n'
