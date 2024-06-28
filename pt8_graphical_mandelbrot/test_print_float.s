	.file	"test_print_float.c"
	.intel_syntax noprefix
# GNU C17 (Ubuntu 11.4.0-1ubuntu1~22.04) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -masm=intel -mtune=generic -march=x86-64 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.section	.rodata
.LC1:
	.string	"test %f %f \n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	endbr64	
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	sub	rsp, 48	#,
	mov	DWORD PTR -36[rbp], edi	# argc, argc
	mov	QWORD PTR -48[rbp], rsi	# argv, argv
# test_print_float.c:6:     int y = 42;
	mov	DWORD PTR -20[rbp], 42	# y,
# test_print_float.c:9:     double x = y;
	pxor	xmm0, xmm0	# tmp84
	cvtsi2sd	xmm0, DWORD PTR -20[rbp]	# tmp84, y
	movsd	QWORD PTR -16[rbp], xmm0	# x, tmp84
# test_print_float.c:10:     double z = 3.5;
	movsd	xmm0, QWORD PTR .LC0[rip]	# tmp85,
	movsd	QWORD PTR -8[rbp], xmm0	# z, tmp85
# test_print_float.c:12:     printf("test %f %f \n", x, z);


	movsd	xmm0, QWORD PTR -8[rbp]	# tmp86, z
	movapd	xmm1, xmm0	#, tmp86

	mov	rax, QWORD PTR -16[rbp]	# tmp87, x
	movq	xmm0, rax	#, tmp87

	lea	rax, .LC1[rip]	# tmp88,
	mov	rdi, rax	#, tmp88
	mov	eax, 2	#,
	call	printf@PLT	#


# test_print_float.c:14:     return 0;
	mov	eax, 0	# _6,
# test_print_float.c:16: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1074528256
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
