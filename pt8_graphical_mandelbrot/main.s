.global main
.intel_syntax noprefix

.text

# ----------------------------------------------------------
# fill the pixels of an image
# rdi: the image ptr (8 bytes)
fill_image:

	push rbp
	mov rbp, rsp

	sub rsp, 24 # 12 bytes allocation + 12 bytes padding
	# image ptr: rbp-8, 8 bytes
	# x index: rbp-10, 2 bytes
	# y index: rbp-12, 2 bytes

	# preserving registers
	push rdi
	push rsi
	push rbx

	mov [rbp-8], rdi
	mov [rbp-10], word ptr 0
	.L_for_x:
		
		mov [rbp-12], word ptr 0
		.L_for_y:

			mov rdi, [rbp-8] # image ptr
			xor esi, esi
			mov si, [rbp-10] # x coordinate
			xor edx, edx
			mov dx, [rbp-12] # y coordinate
			mov ecx,  [rip+color_red] # color red
			call sfImage_setPixel


			inc word ptr [rbp-12]
			mov ax, 100
			cmp ax, [rbp-12]
			jne .L_for_y

		inc word ptr [rbp-10]
		mov ax, 200
		cmp ax, [rbp-10]
		jne .L_for_x


	# restoring preserved registers
	pop rbx
	pop rsi
	pop rdi

	mov rsp, rbp
	pop rbp
	ret

# ----------------------------------------------------------
# main (libc main)
main:

	push rbp
	mov rbp, rsp

	sub rsp, 80 
	sub rsp, 8 # alignment
	# window ptr: rbp-8, 8 bytes 
	# sfEvent: rbp-48, 40 bytes
	# pixel_buffer_ptr, rbp-56, 8 bytes
	# image_ptr: rbp-64, 8 bytes
	# texture_ptr: rbp-72, 8 bytes
	# sprite_ptr: rbp-80, 8 bytes

	# registers to preserve
	push rdi
	push rsi
	push rbx

	# -------------------------------
	# create the window
    # mode
    # rip + symbol -> position independant executable
    # style
    mov ecx, [rip+window_style]
    # title
    lea rdx, [rip+window_title]
	# 
    mov	r8, qword ptr 0
	# video mode
	mov	rdi, [rip+window_width]
	mov	esi, [rip+window_depth]
    call sfRenderWindow_create
	mov [rbp-8], rax # store the window ptr

	# ------------------------------------
	# create the image texture and sprite

	# image_ptr
	mov edi, [rip+window_width]
	mov esi, [rip+window_height]
	call sfImage_create
	mov [rbp-64], rax # the image ptr is stored (return value)

	# fill the image
	mov rdi, [rbp-64] # image ptr
	mov esi, 42 # x coordinate
	mov edx, 42 # y coordinate
	mov ecx,  [rip+color_red] # color red
	call sfImage_setPixel

	# mov rdi, [rbp-64]
	# call fill_image

	mov rdi, [rbp-64]
	mov esi, [rip+window_width]
	mov edx, [rip+window_height]
	call draw_mandelbrot

	# texture ptr
	mov rdi, [rbp-64] # image_ptr
	mov esi, 0
	call sfTexture_createFromImage
	mov [rbp-72], rax

	# sprite ptr
	call sfSprite_create
	mov [rbp-80], rax

	# bind the associate to the sprite
	mov rdi, [rbp-80] # sprite_ptr
	mov rsi, [rbp-72] # texture ptr
	mov edx, 1 # TRUE
	call sfSprite_setTexture


	# main loop
	.L_while_window_opened:

		.L_while_window_poll_event:

			lea	rsi, [rbp-48]	# event
			mov	rdi, [rbp-8]	# window ptr
			call sfRenderWindow_pollEvent

			# test for close event
			mov edx, [rbp-48]
			test rdx, rdx
			jne .L_skip_close

			# close window

				mov rdi, [rbp-8]
				call sfRenderWindow_close 

			.L_skip_close:

			test eax, eax
			jne .L_while_window_poll_event



		# lea rdi, [rip+text_test]
    	# xor eax, eax
    	# call printf

		# clear window
		mov rdi, [rbp-8]
		mov rsi, 0
		call sfRenderWindow_clear

		# draw the sprite
		mov rdi, [rbp-8] # window_ptr
		mov rsi, [rbp-80] # sprite_ptr
		mov edx, 0
		call sfRenderWindow_drawSprite

		# window display
		mov	rdi, [rbp-8]
		call sfRenderWindow_display

		# test if the window is still open
		mov rdi, [rbp-8]
		call sfRenderWindow_isOpen
		test eax, eax
		jne .L_while_window_opened 

	# ------------------------------------
	# destroy the image texture and sprite

	# free the sprite
	mov rdi, [rbp-80] # sprite_ptr
	call sfSprite_destroy

	# free the texture ptr
	mov rdi, [rbp-72]
	call sfTexture_destroy

	# free the image pointer
	mov rdi, [rbp-64]
	call sfImage_destroy

	# ------------------------------------
	# window destruction
	mov rdi, [rbp-8]
	call sfRenderWindow_destroy

	# restore preserved registers
	pop rbx	
	pop rsi
	pop rdi

	# return value is 0
	xor rax, rax

	mov rsp, rbp # de allocate the stack
	pop rbp # restore the caller's base pointer

	ret

.data

color_red:
	.byte 255, 0, 0, 255

text_test:
	.asciz "test\n"

window_title:
   .string	"SFML x86 window"

# window video mode
window_width:
    .long 800
window_height:
    .long 600
window_depth:
    .long 32

window_style:
    .long 6

# .long : 4 bytes values
