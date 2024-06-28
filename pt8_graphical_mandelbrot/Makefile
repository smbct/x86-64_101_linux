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



main.o: main.s
	as -g main.s -c -o main.o
mandelbrot.o: mandelbrot.s
	as -g mandelbrot.s -c -o mandelbrot.o

mandelbrot: main.o mandelbrot.o
	gcc main.o mandelbrot.o -lcsfml-graphics -lcsfml-window -lcsfml-system  -o mandelbrot

#################################################


test_print_float.s: test_print_float.c
	gcc -S test_print_float.c -masm=intel -fdiagnostics-color=always -fverbose-asm -o test_print_float.s


test_double_cmp.s: test_double_cmp.c
	gcc -S test_double_cmp.c -masm=intel -fdiagnostics-color=always -fverbose-asm -o test_double_cmp.s