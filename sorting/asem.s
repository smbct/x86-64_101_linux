
# documentation

# https://cs.dartmouth.edu/~sergey/cs258/tiny-guide-to-x86-assembly.pdf

# https://www.classes.cs.uchicago.edu/archive/2009/spring/22620-1/docs/handout-03.pdf ABI 

# https://gitlab.com/x86-psABIs/x86-64-ABI/-/jobs/artifacts/master/raw/x86-64-ABI/abi.pdf?job=build System V ABI

# https://stackoverflow.com/tags/x86/info

# system V ABI x86 64 linux

.text
.global main, _store_array, debug, debug2, debug3, debug4, debug5, debug6, debug7
.intel_syntax noprefix


# ####################################################################
# selection sort on an array (of word)
# rdi: array pointer (qword ptr)
# si: array length (word ptr)
_selection_sort:

	push rbp
	mov rbp, rsp

	sub rsp, 24
	# local variables
	# 4 (-4): array length
	# 8 (-12): array pointer
	# 4 (-16): first index
	# 4 (-20): second index
	# 4 (-24): local min 

	# register to preserve
	push rdi
	push rsi
	push rbx

	mov [rbp-4], si
	mov [rbp-12], rdi
	mov [rbp-16], word ptr 0

	main_loop:

		# second index starts from first index
		mov ax, [rbp-16]
		mov [rbp-20], ax

		# increase second index var
		inc word ptr [rbp-20]

		# get the min value starting from the first index
		sub_loop:

			# load current val in bx
			mov rax, [rbp-12]
			xor rbx, rbx
			mov bx, [rbp-20]
			shl bx, 1 # rbx *= 2
			add rax, rbx # rax is the address of the index2 element
			mov bx, [rax]

			# load the current min in dx
			mov rcx, [rbp-12]
			xor rdx, rdx
			mov dx, [rbp-16]
			shl dx, 1
			add rcx, rdx
			mov dx, [rcx]

			# compare with local min
			cmp bx, dx
			jge skip_swap
			
			# swap here if relevant
			
				mov [rcx], bx
				mov [rax], dx

			skip_swap:

			inc word ptr [rbp-20]
			mov ax, [rbp-4]
			cmp ax, word ptr [rbp-20]
			jne sub_loop

		# swap min found with current at first index

		# increment
		inc word ptr [rbp-16]
		mov ax, [rbp-4]
		dec ax
		cmp ax, word ptr [rbp-16]
		jne main_loop

	pop rbx
	pop rsi
	pop rdi

	mov rsp, rbp
	pop rbp

	ret

# ####################################################################
# store an array from one address to another one
# rdi: address of the array
# si: length of the array
# rdx: target address of the array
_store_array:

	push rbp
	mov rbp, rsp

	sub rsp, 24 # 24 bytes allocation

	mov [rbp-8], rdi # rdi: original address
	mov [rbp-12], si # rsi: array length
	mov [rbp-20], rdx # target address of the array
	mov [rbp-24], word ptr 0 # index of the array

	push rdi
	push rsi
	push rbx

	push_array:

		# store the value from origin to target address
		mov rdx,[rbp-8] 
		xor rax, rax
		mov ax, [rdx] # get the value
		
		mov rdx, [rbp-20] # load the address
		mov [rdx], ax

		# go to next addresses
		add [rbp-8], qword ptr 2
		add [rbp-20], qword ptr 2

		# increment index and test length limit
		inc word ptr [rbp-24]
		mov ax, [rbp-12]
		cmp ax, word ptr [rbp-24]
		jne push_array

	pop rbx
	pop rsi
	pop rdi

	mov rsp, rbp
	pop rbp

	ret

# #################################################################### 
# print a new line
_print_ln:
	push rbp
	lea rdi, [new_line]
	xor eax, eax
	call printf
	pop rbp
	ret

# ####################################################################
# print an array
# rdi: array pointer
# rsi: array length
_print_array:

	push rbp
	mov rbp, rsp

	sub rsp, 24 # 2 local variable: the array length and the array index 
	# rbp-8: array length
	# rbp-16: array pointer (will not be at the begining)
	# rbp-24: array index iter

	push rbx
	push rdi
	push rsi

	# Save the values of registers that the function
	mov [rbp-16], rdi # array pointer
	mov [rbp-8], rsi # array length

	# print array
	
	# clear the stack at the pointer position for the value to display and the index
	mov [rbp-24], qword ptr 0 # array index (i)

	write_array_elt:

		# call to printf
		mov rdx, [rbp-16] # load array pointer
		mov si, [rdx] # second argument, only 2 bytes
		lea rdi, [text_one_elt] # first argument
		xor eax, eax
		call printf

		inc qword ptr [rbp-24] # index += 1
		add [rbp-16], qword ptr 2 # increase the array pointer
		
		# keep going if end not reached
		mov rax, [rbp-8] # length

		cmp rax, [rbp-24]
		jne write_array_elt

	call _print_ln

	# ########################################
	# function return

	# saved values
	pop rsi
	pop rdi
	pop rbx

	mov rsp, rbp # de allocate the stack
	pop rbp # restore the caller's base pointer

	ret

# ####################################################################
# main function (libc main)
main:

	push rbp
	mov rbp, rsp

	# allocate space for the array rbp-22 is the adress
	sub sp, [test_array_len]
	sub sp, [test_array_len]

	sub rsp, 2 # alignment

	# registers to preserve
	push rdi
	push rsi
	push rbx

	# store the array in the stack
	lea rdi, [test_array] # rdi is the address of the array
	mov si, [test_array_len] # si is the length of the array
	lea rdx, [rbp]
	sub dx, si
	sub dx, si # rdx is now the target address to store the array
	call _store_array

	# print the array before sorting
	lea rdi, [text_unsorted]
	xor eax, eax
	call printf

	lea rdi, [rbp]
	sub di, test_array_len
	sub di, test_array_len
	xor rsi, rsi
	mov si, test_array_len
	call _print_array

	# perform selection sort
	mov rdi, rbp
	sub di, test_array_len
	sub di, test_array_len
	mov si, [test_array_len]
	call _selection_sort

	# perform merge sort
	# lea rdi, [rbp]
	# sub di, test_array_len
	# sub di, test_array_len
	# mov si, 0
	# mov dx, test_array_len
	# dec dx
	# call _merge_sort_rec

	# print the array before sorting
	lea rdi, [text_sorted]
	xor eax, eax
	call printf

	mov rdi, rbp
	sub di, test_array_len
	sub di, test_array_len
	xor rsi, rsi
	mov si, test_array_len
	call _print_array

	pop rbx	
	pop rsi
	pop rdi

	# return value is 0
	xor rax, rax

	mov rsp, rbp # de allocate the stack
	pop rbp # restore the caller's base pointer

	ret

text_unsorted:
	.asciz "unsorted array: \n"
text_sorted:
	.asciz "sorted array: \n"

text_before:
	.asciz "before:\n"
text_after:
	.asciz "after:\n"


text_len:
	.asciz "array length: %u\n"

text_one_elt:
	.asciz "%d, "

test_array:
	.word 1, 32, 3, 60, 22, 54, 7, 21, 9, 10, 42

new_line:
	.asciz "\n"

test_array_len:
	.word 11

