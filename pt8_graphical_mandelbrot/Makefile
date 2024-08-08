# hello world

hello_sfml: hello_sfml.o
	gcc hello_sfml.o -lcsfml-graphics -lcsfml-window -lcsfml-system -o hello_sfml

hello_sfml.o: hello_sfml.s
	as -g hello_sfml.s -c -o hello_sfml.o

# window creation

create_window_c: create_window_c.o
	gcc create_window_c.o -lcsfml-graphics -lcsfml-window -lcsfml-system -o create_window_c

create_window_c.o: create_window_c.c
	gcc create_window_c.c -c -o create_window_c.o

create_window_c.s: create_window_c.c
	gcc -S create_window_c.c -masm=intel -fdiagnostics-color=always -fverbose-asm -o create_window_c.s

create_window_assembly: create_window_assembly.o
	gcc create_window_assembly.o -lcsfml-graphics -lcsfml-window -lcsfml-system -o create_window_assembly

create_window_assembly.o: create_window_assembly.s
	as -g create_window_assembly.s -c -o create_window_assembly.o

# draw mandelbrot

draw_mandelbrot.o: draw_mandelbrot.s
	as -g draw_mandelbrot.s -c -o draw_mandelbrot.o

mandelbrot.o: mandelbrot.s
	as -g mandelbrot.s -c -o mandelbrot.o

mandelbrot: draw_mandelbrot.o mandelbrot.o
	gcc draw_mandelbrot.o mandelbrot.o -lcsfml-graphics -lcsfml-window -lcsfml-system -o mandelbrot

# main window loop

main_window_loop: main_window_loop.c
	gcc main_window_loop.c -lcsfml-graphics -lcsfml-window -o main_window_loop

main_window_loop.s: main_window_loop.c
	gcc -S main_window_loop.c -masm=intel -fdiagnostics-color=always -fverbose-asm -o main_window_loop.s

test_event.s: test_event.c
	gcc -S test_event.c -masm=intel -fdiagnostics-color=always -fverbose-asm -o test_event.s

test_event: test_event.c
	gcc test_event.c -lcsfml-graphics -lcsfml-window -o test_event

main_window_loop_assembly.o: main_window_loop_assembly.s
	as -g main_window_loop_assembly.s -c -o main_window_loop_assembly.o

main_window_loop_assembly: main_window_loop_assembly.o
	gcc main_window_loop_assembly.o -lcsfml-graphics -lcsfml-window -lcsfml-system -o main_window_loop_assembly