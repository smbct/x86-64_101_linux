void _hello_world_assembly();

// compilation: as hello_world.s -o hello_world.o && gcc call_assembly.c -c -o call_assembly.o && gcc -static hello_world.o call_assembly.o -o hello_world

int main(int argc, char* argv) {

    // call an assembly function
    _hello_world_assembly();

}