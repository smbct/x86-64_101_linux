	.file	"test_event.c"
	.intel_syntax noprefix
# GNU C17 (Ubuntu 11.4.0-1ubuntu1~22.04) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -masm=intel -mtune=generic -march=x86-64 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.section	.rodata
.LC0:
	.string	"SFML window"
.LC1:
	.string	"event size: %ld\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64	
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	sub	rsp, 96	#,
	mov	DWORD PTR -84[rbp], edi	# argc, argc
	mov	QWORD PTR -96[rbp], rsi	# argv, argv
# test_event.c:4: int main(int argc, char* argv[]) {
	mov	rax, QWORD PTR fs:40	# tmp95, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR -8[rbp], rax	# D.4738, tmp95
	xor	eax, eax	# tmp95
# test_event.c:11:     const char* title = "SFML window";
	lea	rax, .LC0[rip]	# tmp84,
	mov	QWORD PTR -72[rbp], rax	# title, tmp84
# test_event.c:12:     sfUint32 style = sfResize | sfClose;
	mov	DWORD PTR -76[rbp], 6	# style,
# test_event.c:13:     const sfContextSettings* settings = NULL;
	mov	QWORD PTR -64[rbp], 0	# settings,
# test_event.c:16:     window = sfRenderWindow_create(mode, title, sfResize | sfClose, settings);
	mov	rcx, QWORD PTR -64[rbp]	# tmp85, settings
	mov	rdx, QWORD PTR -72[rbp]	# tmp86, title
	mov	rsi, QWORD PTR mode.0[rip]	# tmp87, mode
	mov	eax, DWORD PTR mode.0[rip+8]	# tmp88, mode
	mov	r8, rcx	#, tmp85
	mov	ecx, 6	#,
	mov	rdi, rsi	#, tmp87
	mov	esi, eax	#, tmp88
	call	sfRenderWindow_create@PLT	#
	mov	QWORD PTR -56[rbp], rax	# window, tmp89
# test_event.c:21:     printf("event size: %ld\n", sizeof(sfEvent));
	mov	esi, 28	#,
	lea	rax, .LC1[rip]	# tmp90,
	mov	rdi, rax	#, tmp90
	mov	eax, 0	#,
	call	printf@PLT	#
# test_event.c:23:     sfRenderWindow_pollEvent(window, &event);
	lea	rdx, -48[rbp]	# tmp91,
	mov	rax, QWORD PTR -56[rbp]	# tmp92, window
	mov	rsi, rdx	#, tmp91
	mov	rdi, rax	#, tmp92
	call	sfRenderWindow_pollEvent@PLT	#
# test_event.c:25:     event.type = sfEvtClosed;
	mov	DWORD PTR -48[rbp], 0	# event.type,
# test_event.c:28:     sfRenderWindow_destroy(window);
	mov	rax, QWORD PTR -56[rbp]	# tmp93, window
	mov	rdi, rax	#, tmp93
	call	sfRenderWindow_destroy@PLT	#
# test_event.c:30:     return 0;
	mov	eax, 0	# _11,
# test_event.c:31: }
	mov	rdx, QWORD PTR -8[rbp]	# tmp96, D.4738
	sub	rdx, QWORD PTR fs:40	# tmp96, MEM[(<address-space-1> long unsigned int *)40B]
	je	.L3	#,
	call	__stack_chk_fail@PLT	#
.L3:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align 8
	.type	mode.0, @object
	.size	mode.0, 12
mode.0:
# width:
	.long	800
# height:
	.long	600
# bitsPerPixel:
	.long	32
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
