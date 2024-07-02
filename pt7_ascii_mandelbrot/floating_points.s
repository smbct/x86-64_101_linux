	.file	"floating_points.c"
	.intel_syntax noprefix
# GNU C17 (Ubuntu 11.4.0-1ubuntu1~22.04) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -masm=intel -mtune=generic -march=x86-64 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.section	.rodata
.LC2:
	.string	"result: %f\n"
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
	sub	rsp, 32	#,
	mov	DWORD PTR -20[rbp], edi	# argc, argc
	mov	QWORD PTR -32[rbp], rsi	# argv, argv
# floating_points.c:9:     double nbf = 0.25;
	movsd	xmm0, QWORD PTR .LC0[rip]	# tmp84,
	movsd	QWORD PTR -8[rbp], xmm0	# nbf, tmp84
# floating_points.c:11:     nbf = nbf * 0.5;
	movsd	xmm1, QWORD PTR -8[rbp]	# tmp86, nbf
	movsd	xmm0, QWORD PTR .LC1[rip]	# tmp87,
	mulsd	xmm0, xmm1	# tmp85, tmp86
	movsd	QWORD PTR -8[rbp], xmm0	# nbf, tmp85
# floating_points.c:13:     printf("result: %f\n", nbf);
	mov	rax, QWORD PTR -8[rbp]	# tmp88, nbf
	movq	xmm0, rax	#, tmp88
	lea	rax, .LC2[rip]	# tmp89,
	mov	rdi, rax	#, tmp89
	mov	eax, 1	#,
	call	printf@PLT	#
# floating_points.c:15:     return 0;
	mov	eax, 0	# _5,
# floating_points.c:16: }
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
	.long	1070596096
	.align 8
.LC1:
	.long	0
	.long	1071644672
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
