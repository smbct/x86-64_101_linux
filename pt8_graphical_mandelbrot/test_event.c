#include <stdio.h>
#include <SFML/Graphics.h>

int main(int argc, char* argv[]) {

    // window pointer
    sfRenderWindow* window;

    // window arguments
    const sfVideoMode mode = {800, 600, 32};
    const char* title = "SFML window";
    sfUint32 style = sfResize | sfClose;
    const sfContextSettings* settings = NULL;

    // create the main window
    window = sfRenderWindow_create(mode, title, sfResize | sfClose, settings);

    // test with the event type
    sfEvent event;

    // output the size of sfEvent struct, in bytes
    printf("event size: %ld\n", sizeof(sfEvent));

    // function call needing an sfEvent pointer
    sfRenderWindow_pollEvent(window, &event);

    event.type = sfEvtClosed;

    // destroy the window
    sfRenderWindow_destroy(window);

    return 0;
}