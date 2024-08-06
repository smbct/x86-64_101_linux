	.file	"create_window_c.c"
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
	sub	rsp, 80	#,
	mov	DWORD PTR -68[rbp], edi	# argc, argc
	mov	QWORD PTR -80[rbp], rsi	# argv, argv
# create_window_c.c:12:     const char* title = "SFML window";
	lea	rax, .LC0[rip]	# tmp86,
	mov	QWORD PTR -48[rbp], rax	# title, tmp86
# create_window_c.c:13:     sfUint32 style = sfResize | sfClose;
	mov	DWORD PTR -64[rbp], 6	# style,
# create_window_c.c:14:     const sfContextSettings* settings = NULL;
	mov	QWORD PTR -40[rbp], 0	# settings,
# create_window_c.c:17:     window = sfRenderWindow_create(mode, title, sfResize | sfClose, settings);
	mov	rcx, QWORD PTR -40[rbp]	# tmp87, settings
	mov	rdx, QWORD PTR -48[rbp]	# tmp88, title
	mov	rsi, QWORD PTR mode.0[rip]	# tmp89, mode
	mov	eax, DWORD PTR mode.0[rip+8]	# tmp90, mode
	mov	r8, rcx	#, tmp87
	mov	ecx, 6	#,
	mov	rdi, rsi	#, tmp89
	mov	esi, eax	#, tmp90
	call	sfRenderWindow_create@PLT	#
	mov	QWORD PTR -32[rbp], rax	# window, tmp91
# create_window_c.c:21:     const int width = 800, height = 600;
	mov	DWORD PTR -60[rbp], 800	# width,
# create_window_c.c:21:     const int width = 800, height = 600;
	mov	DWORD PTR -56[rbp], 600	# height,
	
# create_window_c.c:22:     sfImage* image = sfImage_create(width, height); // image object
	mov	edx, DWORD PTR -56[rbp]	# height.0_1, height
	mov	eax, DWORD PTR -60[rbp]	# width.1_2, width
	mov	esi, edx	#, height.0_1
	mov	edi, eax	#, width.1_2
	call	sfImage_create@PLT	#
	mov	QWORD PTR -24[rbp], rax	# image, tmp92


# create_window_c.c:24:     sfColor color_red = sfColor_fromRGB(255, 0, 0);
	mov	edx, 0	#,
	mov	esi, 0	#,
	mov	edi, 255	#,
	call	sfColor_fromRGB@PLT	#
	mov	DWORD PTR -52[rbp], eax	# color_red, tmp94

# create_window_c.c:25:     sfImage_setPixel(image, 42, 42, color_red);
	mov	edx, DWORD PTR -52[rbp]	# tmp95, color_red
	mov	rax, QWORD PTR -24[rbp]	# tmp96, image
	mov	ecx, edx	#, tmp95
	mov	edx, 42	#,
	mov	esi, 42	#,
	mov	rdi, rax	#, tmp96
	call	sfImage_setPixel@PLT	#

# create_window_c.c:33:     sfTexture* texture = sfTexture_createFromImage(image, NULL); // texture object
	mov	rax, QWORD PTR -24[rbp]	# tmp97, image
	mov	esi, 0	#,
	mov	rdi, rax	#, tmp97
	call	sfTexture_createFromImage@PLT	#
	mov	QWORD PTR -16[rbp], rax	# texture, tmp98

# create_window_c.c:35:     sfSprite* sprite = sfSprite_create(); // sprite object
	call	sfSprite_create@PLT	#
	mov	QWORD PTR -8[rbp], rax	# sprite, tmp99

# create_window_c.c:36:     sfSprite_setTexture(sprite, texture, sfTrue);
	mov	rcx, QWORD PTR -16[rbp]	# tmp100, texture
	mov	rax, QWORD PTR -8[rbp]	# tmp101, sprite
	mov	edx, 1	#,
	mov	rsi, rcx	#, tmp100
	mov	rdi, rax	#, tmp101
	call	sfSprite_setTexture@PLT	#

# create_window_c.c:40:     sfRenderWindow_drawSprite(window, sprite, NULL);
	mov	rcx, QWORD PTR -8[rbp]	# tmp102, sprite
	mov	rax, QWORD PTR -32[rbp]	# tmp103, window
	mov	edx, 0	#,
	mov	rsi, rcx	#, tmp102
	mov	rdi, rax	#, tmp103
	call	sfRenderWindow_drawSprite@PLT	#

# create_window_c.c:44:     sfRenderWindow_display(window);
	mov	rax, QWORD PTR -32[rbp]	# tmp104, window
	mov	rdi, rax	#, tmp104
	call	sfRenderWindow_display@PLT	#
# create_window_c.c:47:     sleep(5);
	mov	edi, 5	#,
	call	sleep@PLT	#
# create_window_c.c:50:     sfRenderWindow_destroy(window);
	mov	rax, QWORD PTR -32[rbp]	# tmp105, window
	mov	rdi, rax	#, tmp105
	call	sfRenderWindow_destroy@PLT	#
# create_window_c.c:52:     return 0;
	mov	eax, 0	# _24,
# create_window_c.c:53: }
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
