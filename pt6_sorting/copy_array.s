.global copy_array
.intel_syntax noprefix

# ####################################################################
# copy an array from one address to another one
# rdi: address of the array
# si: length of the array
# rdx: target address of the array
copy_array:

	push rbp
	mov rbp, rsp

	sub rsp, 24 # 24 bytes allocation

	mov [rbp-8], rdi # rdi: original address
	mov [rbp-10], si # rsi: array length
	mov [rbp-18], rdx # target address of the array
	mov [rbp-20], word ptr 0 # index of the array

	push rdi
	push rsi

	.L_push_array:

		# store the value from origin to target address
		mov rdx,[rbp-8] 
		mov al, [rdx] # get the value
		
		# copy the value to the target array
		mov rdx, [rbp-18] # load the address
		mov [rdx], al

		# go to next addresses
		inc qword ptr [rbp-8]
		inc qword ptr [rbp-18]

		# increment index and test length limit
		inc word ptr [rbp-20]
		mov ax, [rbp-10]
		cmp ax, word ptr [rbp-20]
		jne .L_push_array

	pop rsi
	pop rdi

	mov rsp, rbp
	pop rbp

	ret
