#include <stdlib.h>
#include <stdio.h>


// assembly generation command: gcc -S floating_points.c -masm=intel -fdiagnostics-color=always -fverbose-asm -o floating_points.s

int main(int argc, char* argv[]) {

    double nbf = 0.25;
    nbf = nbf * 0.5;
    printf("result: %f\n", nbf);

    return 0;
}