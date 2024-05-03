.text
.global _merge_sort, _merge_sort_rec
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
