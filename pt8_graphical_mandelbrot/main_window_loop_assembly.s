.global main
.intel_syntax noprefix

main:
    
    push rbp # storing the rbp value before manipulation
    mov rbp, rsp # storing the rsp register

    sub rsp, 72
    # rbp-8 : window pointer, 8 bytes
    # rbp-16 : image pointer, 8 bytes
    # rbp-24 : texture pointer, 8 bytes
    # rbp-32 : sprite pointer, 8 bytes
    # rbp-36 ; temp x coordinate, 4 bytes
    # rbp-40 ; temp y coordinate, 4 bytes
    # rbp-68 ; event, 28 bytes

    # storing the preserved registers
    push rdi
	push rsi
    push rbx

    # window creation
    mov rdi, [rip+window_width]
    mov esi, [rip+window_depth]
    # title
    lea rdx, [rip+window_title]
    # style
    mov ecx, [rip+window_style]
    # settings
    mov	r8, qword ptr 0
    call sfRenderWindow_create
    mov [rbp-8], rax # store the window ptr

    # main window loop
    .L_while_window_open:

        # test if window is open 
        mov rdi, [rbp-8] # window pointer
        call sfRenderWindow_isOpen
        test eax, eax
        jz .L_end_while_window_open

        # poll event loop
        .L_while_poll_event:

            mov rdi, [rbp-8] # window ptr
            lea rsi, [rbp-68] # event ptr
            call sfRenderWindow_pollEvent

            # leave poll event loop if no eventw
            test eax, eax
            jz .L_end_while_pool_event

            # test event type and close the window if required
            mov eax, dword ptr [rbp-68]
            test eax, eax
            jnz .L_end_if_event_equal_close 

            .L_if_event_equal_close:
                mov rdi, [rbp-8] # window ptr
                call sfRenderWindow_close
            .L_end_if_event_equal_close:

            jmp .L_while_poll_event
        .L_end_while_pool_event:

        # calling "display"
        mov	rdi, [rbp-8]
        call sfRenderWindow_display

        jmp .L_while_window_open

    .L_end_while_window_open:

    # window destruction
    mov rdi, [rbp-8]
	call sfRenderWindow_destroy

    pop rbx
    pop rsi
    pop rdi

    # restoring the rsp and rbp registers
    mov rsp, rbp
    pop rbp

    # return
    mov rax, 0
    ret


window_title:
   .string	"SFML x86 window"

# window video mode
window_width:
    .long 800
window_height:
    .long 600
window_depth:
    .long 32

# window style
window_style:
    .long 6
