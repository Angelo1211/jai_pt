#import "Basic";
#import "stb_image_write";

WIDTH  :: 1920; 
HEIGHT :: 1080;

Pixel :: struct {
	r : u8;
	g : u8;
	b : u8;
	a : u8;
};

main :: ()
{
	pixels : [] Pixel;
	pixels = NewArray(WIDTH * HEIGHT, Pixel);
	defer free(pixels.data);

	for x : 0..WIDTH-1
	{
		for y : 0..HEIGHT-1
		{
			pixels[x + y * WIDTH].r = 128;

			if x % 20 < 5
				pixels[x + y * WIDTH].g = 230;

			if y % 11 > 9
				pixels[x + y * WIDTH].b = 200;

			pixels[x + y * WIDTH].a = 255;
		}
	}

	stbi_write_png("Image.png", WIDTH, HEIGHT, 4, pixels.data, 4);
}