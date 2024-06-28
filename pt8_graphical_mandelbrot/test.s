.text
.global main, debug, debug2, debug3
.intel_syntax noprefix

.extern sfRenderWindow_create

# ----------------------------------------------------------
# main (libc main)
main:

	push rbp
	mov rbp, rsp

	sub rsp, 48 
	sub rsp, 8 # alignment
	# 8: (8) window ptr
	# 40: (48) sfEvent

	# registers to preserve
	push rdi
	push rsi
	push rbx

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

	# window ptr
	mov [rbp-8], rax


	# main loop
	while_window_opened:

		while_window_poll_event:

			lea	rsi, [rbp-48]	# event
			mov	rdi, [rbp-8]	# window ptr
			call sfRenderWindow_pollEvent

			# test for close event
			mov edx, [rbp-48]
			test rdx, rdx
			jne skip_close

			# close window

				mov rdi, [rbp-8]
				call sfRenderWindow_close 

			skip_close:

			test eax, eax
			jne while_window_poll_event



		# lea rdi, [rip+text_test]
    	# xor eax, eax
    	# call printf

		# clear window
		mov rdi, [rbp-8]
		mov rsi, 0
		call sfRenderWindow_clear

		# window display
		mov	rdi, [rbp-8]
		call sfRenderWindow_display

		mov rdi, [rbp-8]
		call sfRenderWindow_isOpen

		test eax, eax
		jne while_window_opened 



	# window destruction
	mov rdi, [rbp-8]
	call sfRenderWindow_destroy

	pop rbx	
	pop rsi
	pop rdi

	# return value is 0
	xor rax, rax

	mov rsp, rbp # de allocate the stack
	pop rbp # restore the caller's base pointer

	ret



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
