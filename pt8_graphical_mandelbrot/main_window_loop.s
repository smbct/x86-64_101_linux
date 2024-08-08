	.file	"main_window_loop.c"
	.intel_syntax noprefix
# GNU C17 (Ubuntu 11.4.0-1ubuntu1~22.04) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -masm=intel -mtune=generic -march=x86-64 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.section	.rodata
.LC0:
	.string	"SFML window"
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

# main_window_loop.c:4: int main(int argc, char* argv[]) {
	mov	rax, QWORD PTR fs:40	# tmp100, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR -8[rbp], rax	# D.5025, tmp100
	xor	eax, eax	# tmp100

# main_window_loop.c:12:     const char* title = "SFML window";
	lea	rax, .LC0[rip]	# tmp87,
	mov	QWORD PTR -72[rbp], rax	# title, tmp87

# main_window_loop.c:13:     sfUint32 style = sfResize | sfClose;
	mov	DWORD PTR -76[rbp], 6	# style,

# main_window_loop.c:14:     const sfContextSettings* settings = NULL;
	mov	QWORD PTR -64[rbp], 0	# settings,

# main_window_loop.c:17:     window = sfRenderWindow_create(mode, title, sfResize | sfClose, settings);
	mov	rcx, QWORD PTR -64[rbp]	# tmp88, settings
	mov	rdx, QWORD PTR -72[rbp]	# tmp89, title
	mov	rsi, QWORD PTR mode.0[rip]	# tmp90, mode
	mov	eax, DWORD PTR mode.0[rip+8]	# tmp91, mode
	mov	r8, rcx	#, tmp88
	mov	ecx, 6	#,
	mov	rdi, rsi	#, tmp90
	mov	esi, eax	#, tmp91
	call	sfRenderWindow_create@PLT	#
	mov	QWORD PTR -56[rbp], rax	# window, tmp92

# main_window_loop.c:22:     while (sfRenderWindow_isOpen(window)) {
	jmp	.L2	#
.L4:

# main_window_loop.c:27:             if (event.type == sfEvtClosed) {
	mov	eax, DWORD PTR -48[rbp]	# _1, event.type
# main_window_loop.c:27:             if (event.type == sfEvtClosed) {
	test	eax, eax	# _1
	jne	.L3	#,
# main_window_loop.c:28:                 sfRenderWindow_close(window);
	mov	rax, QWORD PTR -56[rbp]	# tmp93, window
	mov	rdi, rax	#, tmp93
	call	sfRenderWindow_close@PLT	#
.L3:

# main_window_loop.c:25:         while (sfRenderWindow_pollEvent(window, &event)) {
	lea	rdx, -48[rbp]	# tmp94,
	mov	rax, QWORD PTR -56[rbp]	# tmp95, window
	mov	rsi, rdx	#, tmp94
	mov	rdi, rax	#, tmp95
	call	sfRenderWindow_pollEvent@PLT	#
	test	eax, eax	# _2
	jne	.L4	#,

# main_window_loop.c:33:         sfRenderWindow_display(window);
	mov	rax, QWORD PTR -56[rbp]	# tmp96, window
	mov	rdi, rax	#, tmp96
	call	sfRenderWindow_display@PLT	#
.L2:

# main_window_loop.c:22:     while (sfRenderWindow_isOpen(window)) {
	mov	rax, QWORD PTR -56[rbp]	# tmp97, window
	mov	rdi, rax	#, tmp97
	call	sfRenderWindow_isOpen@PLT	#
	test	eax, eax	# _3
	jne	.L3	#,

# main_window_loop.c:37:     sfRenderWindow_destroy(window);
	mov	rax, QWORD PTR -56[rbp]	# tmp98, window
	mov	rdi, rax	#, tmp98
	call	sfRenderWindow_destroy@PLT	#

# main_window_loop.c:39:     return 0;
	mov	eax, 0	# _14,

# main_window_loop.c:40: }
	mov	rdx, QWORD PTR -8[rbp]	# tmp101, D.5025
	sub	rdx, QWORD PTR fs:40	# tmp101, MEM[(<address-space-1> long unsigned int *)40B]
	je	.L7	#,
	call	__stack_chk_fail@PLT	#
	
.L7:
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
