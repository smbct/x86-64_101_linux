#include <stdlib.h>
#include <stdio.h>

typedef struct {
    int x;
    short y;
} my_struct;

void fill_my_struct(my_struct mstr) {

    mstr.x = 4;
    mstr.y = 16;

}

int main(int argc, char* argv[]) {

    printf("test\n");

    my_struct str;
    fill_my_struct(str);

    return 0;
}