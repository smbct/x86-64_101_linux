template/main.o: template/main.c
	gcc template/main.c -c -o template/main.o

template/main: template/main.o
	gcc template/main.o -lcsfml-graphics -lcsfml-window -lcsfml-system -o template/main

template/main2.s: template/main2.c
	gcc -S template/main2.c -masm=intel -fdiagnostics-color=always -fverbose-asm -o template/main2.s

# template image test
template/image: template/image.c
	gcc template/image.c -lcsfml-graphics -lcsfml-window -lcsfml-system -o template/image
template/image.s: template/image.c
	gcc -S template/image.c -masm=intel -fdiagnostics-color=always -fverbose-asm -o template/image.s

#################################################

test.o: test.s
	as test.s -c -o test.o

test: test.o
	gcc test.o -lcsfml-graphics -lcsfml-window -lcsfml-system  -o test





#################################################


test_print_float.s: test_print_float.c
	gcc -S test_print_float.c -masm=intel -fdiagnostics-color=always -fverbose-asm -o test_print_float.s


test_double_cmp.s: test_double_cmp.c
	gcc -S test_double_cmp.c -masm=intel -fdiagnostics-color=always -fverbose-asm -o test_double_cmp.s


#################################################

hello_sfml: hello_sfml.o
	gcc hello_sfml.o -lcsfml-graphics -lcsfml-window -lcsfml-system -o hello_sfml

hello_sfml.o: hello_sfml.s
	as -g hello_sfml.s -c -o hello_sfml.o

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

draw_mandelbrot.o: draw_mandelbrot.s
	as -g draw_mandelbrot.s -c -o draw_mandelbrot.o

mandelbrot.o: mandelbrot.s
	as -g mandelbrot.s -c -o mandelbrot.o

mandelbrot: draw_mandelbrot.o mandelbrot.o
	gcc draw_mandelbrot.o mandelbrot.o -lcsfml-graphics -lcsfml-window -lcsfml-system -o mandelbrot