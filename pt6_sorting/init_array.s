.global init_array
.intel_syntax noprefix

# ####################################################################
# Initialize an array with 0s
# rdi: address of the array
# si: length of the array
init_array:

	push rbp
	mov rbp, rsp

	sub rsp, 16 # 16 bytes allocation

	mov [rbp-8], rdi # rdi: original address
	mov [rbp-10], si # rsi: array length
	mov [rbp-12], word ptr 0 # index of the array

	push rdi
	push rsi

	.L_push_array:

		# store the value from origin to target address
		mov rdx,[rbp-8]
        mov [rdx], byte ptr 0 # get the value

		# go to next addresses
		inc qword ptr [rbp-8]

		# increment index and test length limit
		inc word ptr [rbp-12]
		mov ax, [rbp-10]
		cmp ax, word ptr [rbp-12]
		jne .L_push_array

	pop rsi
	pop rdi

	mov rsp, rbp
	pop rbp

	ret
