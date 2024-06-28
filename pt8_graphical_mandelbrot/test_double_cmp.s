	.file	"test_double_cmp.c"
	.intel_syntax noprefix
# GNU C17 (Ubuntu 11.4.0-1ubuntu1~22.04) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -masm=intel -mtune=generic -march=x86-64 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.section	.rodata
.LC2:
	.string	"x <= y"
.LC3:
	.string	"x > y"
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
# test_double_cmp.c:6:     double x = -4.5;
	movsd	xmm0, QWORD PTR .LC0[rip]	# tmp84,
	movsd	QWORD PTR -16[rbp], xmm0	# x, tmp84
# test_double_cmp.c:7:     double y = -4.;
	movsd	xmm0, QWORD PTR .LC1[rip]	# tmp85,
	movsd	QWORD PTR -8[rbp], xmm0	# y, tmp85
# test_double_cmp.c:10:     if(x <= y) {
	movsd	xmm0, QWORD PTR -8[rbp]	# tmp86, y
	comisd	xmm0, QWORD PTR -16[rbp]	# tmp86, x
	jb	.L7	#,
# test_double_cmp.c:11:         printf("x <= y\n");
	lea	rax, .LC2[rip]	# tmp87,
	mov	rdi, rax	#, tmp87
	call	puts@PLT	#
	jmp	.L4	#
.L7:
# test_double_cmp.c:13:         printf("x > y\n");
	lea	rax, .LC3[rip]	# tmp88,
	mov	rdi, rax	#, tmp88
	call	puts@PLT	#
.L4:
# test_double_cmp.c:16:     return 0;
	mov	eax, 0	# _7,
# test_double_cmp.c:18: }
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
	.long	-1072562176
	.align 8
.LC1:
	.long	0
	.long	-1072693248
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
