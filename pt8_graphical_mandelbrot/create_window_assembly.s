.global main
.intel_syntax noprefix

main:
    
    push rbp # storing the rbp value before manipulation
    mov rbp, rsp # storing the rsp register

    sub rsp, 40
    # rbp-8 : window pointer, 8 bytes
    # rbp-16 : image pointer, 8 bytes
    # rbp-24 : texture pointer, 8 bytes
    # rbp-32 : sprite pointer, 8 bytes
    # rbp-36 ; temp x coordinate, 4 bytes
    # rbp-40 ; temp y coordinate, 4 bytes

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

    # creating and displaying a drawing
    
    # image creation
    mov edi, [rip+window_width] # image witdth
    mov esi, [rip+window_height] # image height
    call sfImage_create
    mov [rbp-16], rax # image ptr

    mov [rbp-36], dword ptr 20
    .L_for_temp_x:

        mov [rbp-40], dword ptr 20
        .L_for_temp_y:

            # draw on the image
            mov rdi, [rbp-16] # image ptr
            mov esi, [rbp-36] # x coordinates
            mov edx, [rbp-40] # y coordinates
            mov ecx, [rip+color_red] # color
            call sfImage_setPixel

            inc dword ptr [rbp-40]
            cmp [rbp-40], dword ptr 50
            jne .L_for_temp_y
                
        inc dword ptr [rbp-36]
        cmp [rbp-36], dword ptr 60
        jne .L_for_temp_x


    

    # texture creation
    mov rdi, [rbp-16] # image ptr
    mov esi, 0
    call sfTexture_createFromImage
    mov [rbp-24], rax # texture ptr

    # sprite creation
    call sfSprite_create
    mov [rbp-32], rax # sprite ptr

    # sprite set texture
    mov rdi, [rbp-32] # sprite ptr
    mov rsi, [rbp-24] # texture ptr
    mov edx, 1
    call sfSprite_setTexture

    # drawing the sprite
    mov rdi, [rbp-8] # window ptr
    mov rsi, [rbp-32]
    mov edx, 0
    call sfRenderWindow_drawSprite

    # calling "display"
    mov	rdi, [rbp-8]
	call sfRenderWindow_display

    # calling "sleep"
    mov	edi, 5
	call sleep

    # sprite destruction
    mov rdi, [rbp-32]
    call sfSprite_destroy

    # texure destruction
    mov rdi, [rbp-24]
    call sfTexture_destroy

    # image de destruction
    mov rdi, [rbp-16]
    call sfImage_destroy

    

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

# color red
color_red:
    .byte 255, 0, 0, 255
