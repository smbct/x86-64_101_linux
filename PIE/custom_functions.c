#include <stdlib.h>
#include <stdio.h>

void init_array_c(char* array, short length) {
    
    // initialized the array
    for(unsigned int i = 0; i < length; i ++) {
        array[i] = i;
    }

}

void print_array_c(char* array, short length) {
    
    for(unsigned int i = 0; i < length; i ++) {
        printf("%d ", array[i]);
    
    }
    
    printf("\n");
}

void shuffle_array_c(char* array, short length) {

    for(unsigned int i = 0; i < 10; i ++) {
        int i = rand()%length;
        int j = rand()%length;

        char temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }

}

int test_functions_c() {

    srand(42);

    char array[10];

    init_array_c(array, 10);

    print_array_c(array, 10);

    shuffle_array_c(array, 10);

    print_array_c(array, 10);


}

