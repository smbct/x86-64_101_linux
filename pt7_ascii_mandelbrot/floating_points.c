#include <stdlib.h>
#include <stdio.h>


// assembly generation command: gcc -g -S floating_points.c -masm=intel -fdiagnostics-color=always -fverbose-asm -o floating_points.s

int main(int argc, char* argv[]) {

    double nbf = -0.25;
    nbf = nbf * 0.5;
    printf("result: %f\n", nbf);

    // float nbf = 0.25;
    // nbf = nbf * 0.5;
    // printf("result: %f\n", nbf);

    // int val_int = 42;
    // double val_double = (double)val_int;
    // float val_float = (float)val_int;
    // val_int = (int)val_float;
    // val_int = (int)val_double;

    return 0;
}