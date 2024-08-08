#include <unistd.h>
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

    //-------------------------------------------------
    // Start the application loop
    sfEvent event;
    while (sfRenderWindow_isOpen(window)) {

        // Process events
        while (sfRenderWindow_pollEvent(window, &event)) {
            // Close window : exit
            if (event.type == sfEvtClosed) {
                sfRenderWindow_close(window);
            }
        }

        // Update the window
        sfRenderWindow_display(window);
    }

    // destroy the window
    sfRenderWindow_destroy(window);

    return 0;
}