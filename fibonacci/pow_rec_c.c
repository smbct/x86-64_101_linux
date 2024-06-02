#include "stdio.h"
#include "stdlib.h"

long pow_rec(long base, long exponent) {

    

    if(exponent == 0) {

        if_exponent_0:
        return 1;
    } else {
    
        else_exponent_not_0:
        long res = base*pow_rec(base, exponent-1);
        return res;
    }

    endif:

}

int main(int argc, char* argv) {

    long res = pow_rec((long)5, (long)3);

    printf("%ld\n", res);
    debug:
    
    return 0;
}