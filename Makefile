asem.o: asem.s
	as asem.s -o asem.o

asem: asem.o
	gcc -o asem -static asem.o

asem_2.o: asem_2.s
	as asem_2.s -o asem_2.o

asem_2: asem_2.o
	gcc -o asem_2 -static asem_2.o




selection_sort.o: selection_sort.s
	as selection_sort.s -o selection_sort.o

call_sort: call_sort.c selection_sort.o
	gcc call_sort.c selection_sort.o -o call_sort