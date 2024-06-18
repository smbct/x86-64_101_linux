#include <stdio.h>

int print_array_c(char* array, short length) {
    
    for(unsigned int i = 0; i < length; i ++) {
        printf("%d ", array[i]);
    }
    
    printf("\n");

    return 42;
}


