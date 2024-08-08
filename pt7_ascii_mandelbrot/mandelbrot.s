.global draw_mandelbrot
.intel_syntax noprefix

.section .text

# ----------------------------------------------------------
# test if a point converge in the mandelbrot set
# xmm0: x0
# xmm1: y0
# return a boolean in ax
test_convergence:

    push rbp
    mov rbp, rsp

    sub rsp, 56 # 46 + 10
    # x0: rbp-8, 8 bytes
    # y0: rbp-16, 8 bytes
    # x: rbp-24, 8 bytes
    # y: rbp-32, 8 bytes
    # xtemp: rbp-40, 8 bytes
    # iter, rbp-44, 4 bytes
    # return flag, rbp-46, 2 bytes

    # preserving registers
	push rdi
	push rsi
	push rbx

    # save the paramers
    movsd [rbp-8], xmm0
    movsd [rbp-16], xmm1

    # init x and y
    xorps xmm0, xmm0
    movsd [rbp-24], xmm0
    movsd [rbp-32], xmm0

    # init the return flag
    xor ax, ax
    mov [rbp-46], ax

    # init the iter variable
    mov [rbp-44], dword ptr 0
    .L_for_conv:

        # test for convergence
        movsd xmm0, [rbp-24]
        mulsd xmm0, xmm0
        movsd xmm1, [rbp-32]
        mulsd xmm1, xmm1
        addsd xmm0, xmm1

        movsd xmm1, [double_4_cst]
        comisd xmm0, xmm1

        jbe  .L_convergence_not_verified

        # .L_convergence_verified:

            mov [rbp-46], word ptr 1
            jmp .L_end_for

        .L_convergence_not_verified:

        # compute the next iteration
        movsd xmm0, [rbp-24]
        mulsd xmm0, [rbp-24] # xmm0 = x*x
        movsd xmm1, [rbp-32]
        mulsd xmm1, [rbp-32] # xmm1 = y*y
        subsd xmm0, xmm1 # xmm0 = x*x-y*y
        # movsd xmm3, xmm0 # xmm3 <- xmm0 = x*x-y*y, is used for the convergence test

        addsd xmm0, [rbp-8] # xmm0 = x*x-y*y + x0
        movsd [rbp-40], xmm0 # store xtemp = xmm0 = x*x-y*y + x0

        movsd xmm0, [double_2_cst] # xmm0 = 2
        mulsd xmm0, [rbp-24] # xmm0 = 2*x
        mulsd xmm0, [rbp-32] # xmm0 = 2*x*y
        addsd xmm0, [rbp-16] # xmm0 = 2*x*y + y0
        movsd [rbp-32], xmm0 # store y_next = 2*x*y + y0

        movsd xmm0, [rbp-40]
        movsd [rbp-24], xmm0 # store x_next = xtemp = x*x-y*y + x0
        
        
        # increase the iteration variable and test for the loop termination
        inc dword ptr [rbp-44]
        mov eax, [max_iteration]
        cmp eax, [rbp-44]
        jne .L_for_conv

    .L_end_for:

    # set the return flag
    mov ax, [rbp-46]

    # restoring the preserved registers
    pop rbx
    pop rsi
    pop rdi

    # returning
    mov rsp, rbp
    pop rbp
    ret


# ----------------------------------------------------------
# draw the ascii mandelbrot set
# edi: width
# esi: height
draw_mandelbrot:

    push rbp
    mov rbp, rsp

    # stack allocation
    sub rsp, 40 # 32 + 8

    # width: rbp-4, 4 bytes
    # height: rbp-8, 4 bytes
    # row index: rbp-12, 4 bytes
    # col index: rbp-16, 4 bytes
    # x0 mandelbrot: rbp-24, 8 bytes
    # y0 mandelbrot: rbp-32, 8 bytes

    # store the parameters
    mov [rbp-4], edi
    mov [rbp-8], esi

    # preserving registers
	push rdi
	push rsi
	push rbx


    mov [rbp-12], dword ptr 0
    .L_for_row:

        # init y0
        cvtsi2sd xmm1, dword ptr [rbp-12]
        dec dword ptr [rbp-8]
        cvtsi2sd xmm3, dword ptr [rbp-8]
        inc dword ptr [rbp-8]
        divsd xmm1, xmm3
        movsd xmm3, [max_y]
        subsd xmm3, [min_y]
        mulsd xmm1, xmm3
        addsd xmm1, [min_y]
        movsd [rbp-32], xmm1

        mov [rbp-16], dword ptr 0
        .L_for_col:

            # compute stuff here

            # compute x0
            cvtsi2sd xmm0, dword ptr [rbp-16]
            dec dword ptr [rbp-4]
            cvtsi2sd xmm3, dword ptr [rbp-4]
            inc dword ptr [rbp-4]
            divsd xmm0, xmm3
            movsd xmm3, [max_x]
            subsd xmm3, [min_x]
            mulsd xmm0, xmm3
            addsd xmm0, [min_x]
            movsd [rbp-24], xmm0

            # print x0 and y0 to debug
            # mov eax, 2
            # lea rdi, [formatter]
            # movsd xmm0, [rbp-24]
            # movsd xmm1, [rbp-32]
            # call printf

            # test the point convergence
            xorps xmm0, xmm0
            xorps xmm1, xmm1
            movsd xmm0, [rbp-24]
            movsd xmm1, [rbp-32]
            call test_convergence

            test ax, ax
            jnz .L_if_not_converge 

            # .L_if_converge:

                # print a star

                # printing a star
                mov rax, 1
                mov rdi, 1
                lea rsi, [star_character]
                mov rdx, 1
                syscall

                jmp .L_end_if_converge

            .L_if_not_converge:

                # printing a space
                mov rax, 1
                mov rdi, 1
                lea rsi, [space_character]
                mov rdx, 1
                syscall

            .L_end_if_converge:

            inc dword ptr [rbp-16]
            mov eax, [rbp-4]
            cmp eax, [rbp-16]
            jne .L_for_col

        # print a line return
        mov rax, 1
        mov rdi, 1
        lea rsi, [new_line]
        mov rdx, 1
        syscall

        inc dword ptr [rbp-12]
        mov eax, [rbp-8]
        cmp eax, [rbp-12]
        jne .L_for_row

    # restoring preserved registers
	pop rbx
	pop rsi
	pop rdi

    mov rsp, rbp
    pop rbp

    ret

.data

star_character:
    .word '*'
space_character:
    .word ' '
new_line:
    .word '\n'

formatter:
    .asciz "float x0, y0: %f, %f\n"

formatter2:
    .asciz "row and col %d %d\n"

new_lines:
    .asciz "\n\n\n"

max_iteration:
    .word 500

min_x:
    .double -2.00
max_x:
    .double 0.47

min_y:
    .double -1.12
max_y:
    .double 1.12

double_4_cst:
    .double 4.
double_2_cst:
    .double 2.
