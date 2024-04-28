
# documentation

# https://cs.dartmouth.edu/~sergey/cs258/tiny-guide-to-x86-assembly.pdf

# https://www.classes.cs.uchicago.edu/archive/2009/spring/22620-1/docs/handout-03.pdf ABI 

# https://gitlab.com/x86-psABIs/x86-64-ABI/-/jobs/artifacts/master/raw/x86-64-ABI/abi.pdf?job=build System V ABI

# https://stackoverflow.com/tags/x86/info

# system V ABI x86 64 linux

.text
.global main, debug, debug2, debug3, debug4, debug5, debug6, debug7
.intel_syntax noprefix

# ####################################################################
# merge sort on an array (of word)
# rdi: array pointer (qword ptr)
# si: array length (word ptr)
_merge_sort:

	push rbp
	mov rbp, rsp

	# sub rsp ...

	mov rsp, rbp
	pop rbp

	ret

# rdi: array pointer
# si: left index
# dx: right index
_merge_sort_rec:

	push rbp
	mov rbp, rsp

	sub rsp, 44
	# 4 (-4) left index param
	# 4 (-8) right index param
	# 4 (-12) mid index
	# 8 (-20) array copy pointer
	# 4 (-24) left index iter
	# 4 (-28) right index iter
	# 8 (-36) array pointer
	# 4 (-40) index in the copy array, when merging
	# 4 (-44) array length

	# allocate space for the array copy
	xor rax, rax
	mov ax, dx
	sub ax, si
	inc ax
	shl ax, 1 # ax is the size to allocate in the stack
	sub rsp, rax
	mov [rbp-20], rsp

	# register to preserve
	push rdi
	push rsi
	push rbx
	
	# stack frame alignment (16 bytes)
	mov rax, rsp
	and rax, 15
	sub rsp, rax

	# loading parameters to the stack
	mov [rbp-4], si
	mov [rbp-8], dx
	mov [rbp-36], rdi
	
	# computing and storing array length
	mov ax, [rbp-8]
	sub ax, [rbp-4]
	inc ax
	mov [rbp-44], ax

	# computing and storing mid index 
	xor rax, rax
	mov ax, [rbp-8]
	add ax, [rbp-4]
	shr ax, 1
	mov [rbp-12], ax
	
	xor rbx, rbx
	mov bx, [rbp-4]
	xor rcx, rcx
	mov cx, [rbp-8]

	# recursive calls on left and right if necessary
	cmp ax, [rbp-4]
	jle skip_rec_sort

	cmp [rbp-8], ax
	jle skip_rec_sort

	# ##########################################
	# recursive sort on the two sub arrays

		# rec sort left
		mov rdi, [rbp-36]
		mov si, [rbp-4]
		mov dx, [rbp-12]
		call _merge_sort_rec

		# rec sort right
		mov rdi, [rbp-36]
		mov si, [rbp-12]
		mov dx, [rbp-8]
		call _merge_sort_rec

	skip_rec_sort:

	# ##########################################
	# merging

	# create a copy in the stack
	# rdi: address of the array
	# si: length of the array
	# rdx: address of the target array
	xor rdi, rdi
	add di, [rbp-4]
	shl di, 1
	add rdi, [rbp-36]
	xor rsi, rsi
	mov si, [rbp-44]
	mov rdx, [rbp-20]
	call _store_array

		# debug print
			# lea rdi, [text_before]
			# xor eax, eax
			# call printf

			# test original array
			# rdi: array pointer
			# rsi: array length
			# xor rdi, rdi
			# mov di, [rbp-4]
			# shl di, 1
			# add rdi, [rbp-36] # go to the start of the sub array
			# xor rsi, rsi
			# mov si, [rbp-8]
			# sub si, [rbp-4]
			# inc si
			# call _print_array

			# test copy array original pointer
			# rdi: array pointer
			# rsi: array length
			# mov rdi, [rbp-20]
			# xor rsi, rsi
			# mov si, [rbp-8]
			# sub si, [rbp-4]
			# inc si
			# call _print_array
		# end debug print

	# get left, mid, right debug
	xor rax, rax
	mov ax, [rbp-4]
	xor rbx, rbx
	mov bx, [rbp-12]
	xor rcx, rcx
	mov cx, [rbp-8]

	# for loop, iterate over entire copy array
	# /!\ the copy is from the copy array to the input array
	# /!\ the original array is indexed from left..right
	# /!\ but the copy array is indexed from 0 to length
	
	mov ax, [rbp-4]
	mov [rbp-40], ax # iter dest array index
	mov [rbp-24], word ptr 0 # left index iter -> left index orig
	mov ax, [rbp-12]
	sub ax, [rbp-4]
	mov [rbp-28], ax # right index iter -> mid index
	copy_array_iterate:

		# pick from left if left is not at the end (mid-1)
		# 	and if [ right is at the end or the value at right is gt the left]

		# debug print the indexes
		# lea rdi, [text_one_elt]
		# xor rsi, rsi
		# mov si, [rbp-4]
		# xor eax, eax
		# call printf
		# lea rdi, [text_one_elt]
		# xor rsi, rsi
		# mov si, [rbp-8]
		# xor eax, eax
		# call printf
		# lea rdi, [text_one_elt]
		# xor rsi, rsi
		# mov si, [rbp-12]
		# xor eax, eax
		# call printf
		# lea rdi, [text_one_elt]
		# xor rsi, rsi
		# mov si, [rbp-40]
		# xor eax, eax
		# call printf
		# lea rdi, [text_one_elt]
		# xor rsi, rsi
		# mov si, [rbp-24]
		# xor eax, eax
		# call printf
		# lea rdi, [text_one_elt]
		# xor rsi, rsi
		# mov si, [rbp-28]
		# xor eax, eax
		# call printf
		# call _print_ln

		# check if left reached the end
		mov ax, [rbp-12]
		sub ax, [rbp-4]
		cmp ax, [rbp-24]
		je pick_from_right

		# check if right reached the end
		mov ax, [rbp-8]
		sub ax, [rbp-4]
		inc ax
		cmp [rbp-28], ax
		je pick_from_left

		# compare left and right
		cmp_two_values:
			xor rbx, rbx
			mov bx, [rbp-24]
			shl bx, 1
			add rbx, [rbp-20]
			mov ax, [rbx]

			xor rdx, rdx
			mov dx, [rbp-28]
			shl dx, 1
			add rdx, [rbp-20]
			mov cx, [rdx]

			cmp cx, ax
			jl pick_from_right

		pick_from_left:

			# copy from copy_arry to input_array
			xor rbx, rbx
			mov bx, [rbp-24]
			shl bx, 1
			add rbx, [rbp-20] # address in the copy array
			mov ax, [rbx]
			xor rbx, rbx
			mov bx, [rbp-40]
			shl bx, 1
			add rbx, [rbp-36] # address in the input array
			mov [rbx], ax
			# inc and jmp
			inc word ptr [rbp-24]
			jmp after_picking

		pick_from_right:

			# copy from copy_arry to input_array
			xor rbx, rbx
			mov bx, [rbp-28]
			shl bx, 1
			add rbx, [rbp-20] # address in the copy array
			mov ax, [rbx]
			xor rbx, rbx
			mov bx, [rbp-40]
			shl bx, 1
			add rbx, [rbp-36] # address in the input array
			mov [rbx], ax
			# inc
			inc word ptr [rbp-28]

		after_picking:

		inc word ptr [rbp-40]
		mov ax, [rbp-8]
		inc ax
		cmp ax, [rbp-40]
		jne copy_array_iterate

		# debug print
			# lea rdi, [text_after]
			# xor eax, eax
			# call printf

			# test after storing
			# rdi: array pointer
			# rsi: array length
			# xor rdi, rdi
			# mov di, [rbp-4]
			# shl di, 1
			# add rdi, [rbp-36]
			# xor rsi, rsi
			# mov si, [rbp-8]
			# sub si, [rbp-4]
			# inc si
			# call _print_array
		# end debug print


	# restoring saved registers
	pop rbx
	pop rsi
	pop rdi

	mov rsp, rbp
	pop rbp

	ret


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
	# mov rdi, rbp
	# sub di, test_array_len
	# sub di, test_array_len
	# mov si, [test_array_len]
	# call _selection_sort

	# perform merge sort
	lea rdi, [rbp]
	sub di, test_array_len
	sub di, test_array_len
	mov si, 0
	mov dx, test_array_len
	dec dx
	call _merge_sort_rec

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

