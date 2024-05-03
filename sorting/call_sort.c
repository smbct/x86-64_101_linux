#include <stdlib.h>
#include <stdio.h>

#include <time.h>

extern void _selection_sort(short* array, short length);

void _selection_sort_c(short* array, short length) {
    for(unsigned int i = 0; i < length; i ++) {
        for(unsigned int j = i+1; j < length; j ++) {
            if(array[j] < array[i]) {
                short tmp = array[i];
                array[i] = array[j];
                array[j] = tmp;
            }
        }
    }
}

void fill_random(short* array, short length) {
    for(unsigned int i = 0; i < length; i ++) {
        array[i] = rand()%(4*length);
    }
}

int main(int argc, char* argv[]) {

    srand(42);

    clock_t begin, end;
    double time_spent;

    // short array_length = 11;
    // short table[] = {1, 32, 3, 60, 22, 54, 7, 21, 9, 10, 42};

    short array_length = 1000;
    short *table = malloc(array_length*sizeof(short));

    // fill_random(table, array_length);

    // printf("My array unsorted: \n");
    // for(unsigned int i = 0; i < array_length; i ++) {
    //     printf("%d", table[i]);
    //     if(i < array_length-1) {
    //         printf(", ");
    //     }
    // }
    // printf("\n\n");

    int nbRepSort = 200;
    int nbRepRep = 10;

    
    double c_time = 0., assembly_time = 0.;

    // c test
    for(unsigned int i = 0; i < nbRepRep; i ++) {
        begin = clock();
        for(unsigned int j = 0; j < nbRepSort; j ++) {
            fill_random(table, array_length);
            _selection_sort_c(table, array_length);
        }
        end = clock();
        c_time += (double)(end - begin) / CLOCKS_PER_SEC;
    }
    c_time /= nbRepRep;

    // assembly test
    for(unsigned int i = 0; i < nbRepRep; i ++) {
        begin = clock();
        for(unsigned int j = 0; j < nbRepSort; j ++) {
            fill_random(table, array_length);
            _selection_sort(table, array_length);
        }
        end = clock();
        assembly_time += (double)(end - begin) / CLOCKS_PER_SEC;
    }
    assembly_time /= nbRepRep;
    
 
    printf("execution time C sort: %f\n", c_time);
    printf("execution time assembly sort: %f\n", assembly_time);

    // for(unsigned int i = 0; i < array_length; i ++) {
    //     printf("%d", table[i]);
    //     if(i < array_length-1) {
    //         printf(", ");
    //     }
    // }
    // printf("\n");

    free(table);

    return 0;
}