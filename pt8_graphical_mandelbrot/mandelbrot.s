.global draw_mandelbrot
.intel_syntax noprefix

.text

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

        movsd xmm1, [rip+double_4_cst]
        comisd xmm0, xmm1

        # printing x and y
        # mov eax, 2
        # lea rdi, [rip+formatter5]
        # call printf

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

        movsd xmm0, [rip+double_2_cst] # xmm0 = 2
        mulsd xmm0, [rbp-24] # xmm0 = 2*x
        mulsd xmm0, [rbp-32] # xmm0 = 2*x*y
        addsd xmm0, [rbp-16] # xmm0 = 2*x*y + y0
        movsd [rbp-32], xmm0 # store y_next = 2*x*y + y0

        movsd xmm0, [rbp-40]
        movsd [rbp-24], xmm0 # store x_next = xtemp = x*x-y*y + x0
        
        
        # increase the iteration variable and test for the loop termination
        inc dword ptr [rbp-44]
        mov eax, [rip+max_iteration]
        cmp eax, [rbp-44]
        jne .L_for_conv

    .L_end_for:

    # printing test
    xor eax, eax
    lea rdi, [rip+new_lines]
    call printf

    xor eax, eax
    xor rsi, rsi
    mov si, [rbp-44]
    lea rdi, [rip+formatter4]
    call printf
    

    # printing x and y
    mov eax, 2
    movsd xmm0, [rbp-24]
    movsd xmm1, [rbp-32] 
    lea rdi, [rip+formatter6]
    call printf

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
# draw the mandelbrot set
# rdi: the image ptr (8 bytes)
# esi: image width
# edx: image height
draw_mandelbrot:

    push rbp
    mov rbp, rsp

    # stack allocation
    sub rsp, 40  # 40
    # image_ptr: rbp-8, 8 bytes
    # image width: rbp-12, 4 bytes
    # image height: rbp-16, 4 bytes
    # pixel_x_index: rbp-20, 4 bytes
    # pixel_y_index: rbp-24, 4 bytes
    # x0 mandelbrot: rbp-32, 8 bytes
    # y0 mandelbrot: rbp-40, 8 bytes

    # store the parameters
    mov [rbp-8], rdi
    mov [rbp-12], esi
    mov [rbp-16], edx

    # preserving registers
	push rdi
	push rsi
	push rbx

    # # printing test
    # xor eax, eax
    # lea rdi, [rip+text_test]
    # call printf

    mov [rbp-20], dword ptr 0
    .L_for_x:

        # compute x0
        cvtsi2sd xmm0, dword ptr [rbp-20]
        dec dword ptr [rbp-12]
        cvtsi2sd xmm3, dword ptr [rbp-12]
        inc dword ptr [rbp-12]
        divsd xmm0, xmm3
        movsd xmm3, [rip+max_x]
        subsd xmm3, [rip+min_x]
        mulsd xmm0, xmm3
        addsd xmm0, [rip+min_x]
        movsd [rbp-32], xmm0

        mov [rbp-24], dword ptr 0
        .L_for_y:

            # compute stuff here

            # init y0
            cvtsi2sd xmm1, dword ptr [rbp-24]
            dec dword ptr [rbp-16]
            cvtsi2sd xmm3, dword ptr [rbp-16]
            inc dword ptr [rbp-16]
            divsd xmm1, xmm3
            movsd xmm3, [rip+max_y]
            subsd xmm3, [rip+min_y]
            mulsd xmm1, xmm3
            addsd xmm1, [rip+min_y]
            movsd [rbp-40], xmm1

            # test the point convergence
            xorps xmm0, xmm0
            xorps xmm1, xmm1
            movsd xmm0, [rbp-32]
            movsd xmm1, [rbp-40]
            call test_convergence

            # print test
            # xor rsi, rsi
            # mov si, ax
            # xor eax, eax
            # lea rdi, [rip+formatter3]
            # call printf

            test ax, ax
            jnz .L_if_not_converge 

            # .L_if_converge:

                mov rdi, [rbp-8] # image ptr
                mov esi, [rbp-20] # x coordinate
                mov edx, [rbp-24] # y coordinate
                mov ecx,  [rip+color_red] # color red
                call sfImage_setPixel

            .L_if_not_converge:

            # call printf
            # mov eax, 2
            # lea rdi, [rip+formatter2]
            # movsd xmm0, [rbp-32]
            # movsd xmm1, [rbp-40]
            # call printf

            # xor eax, eax
            # lea rdi, [rip+formatter]
            # mov esi, [rbp-20]
            # mov edx, [rbp-24]
            # call printf

            inc dword ptr [rbp-24]
            mov eax, [rbp-16]
            cmp eax, [rbp-24]
            jne .L_for_y

        inc dword ptr [rbp-20]
        mov eax, [rbp-12]
        cmp eax, [rbp-20]
        jne .L_for_x

    # restoring preserved registers
	pop rbx
	pop rsi
	pop rdi

    mov rsp, rbp
    pop rbp

    ret

.data

color_red:
	.byte 255, 0, 0, 255

text_test:
	.asciz "test\n"

formatter:
    .asciz "x, y: %d, %d\n"

formatter2:
    .asciz "float x0, y0: %f, %f\n"

formatter3:
    .asciz "val ax: %d\n"

formatter4:
    .asciz "val iter: %d\n"

formatter5:
    .asciz "float cmp conv: %f, %f\n"

formatter6:
    .asciz "float x final, y final: %f, %f\n"


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
