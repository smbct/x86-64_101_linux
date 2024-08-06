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


    // creating and displaying a drawing
    const int width = 800, height = 600;
    sfImage* image = sfImage_create(width, height); // image object
    
    sfColor color_red = sfColor_fromRGB(255, 0, 0);
    sfImage_setPixel(image, 42, 42, color_red);

    // for(int x = 10; x < 100; x ++) {
    //     for(int y = 30; y < 60; y ++) {
    //         sfImage_setPixel(image, x, y, color_red);
    //     }
    // }

    sfTexture* texture = sfTexture_createFromImage(image, NULL); // texture object

    sfSprite* sprite = sfSprite_create(); // sprite object
    sfSprite_setTexture(sprite, texture, sfTrue);

    sfRenderWindow_drawSprite(window, sprite, NULL);


    // display the window
    sfRenderWindow_display(window);

    // pause
    sleep(5);
    
    // destroy the sprite
    sfSprite_destroy(sprite);

    // destroy the texture
    sfTexture_destroy(texture);

    // destroy the image
    sfImage_destroy(image);

    // destroy the window
    sfRenderWindow_destroy(window);

    return 0;
}