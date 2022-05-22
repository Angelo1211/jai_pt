#import "Basic";
#import "Window_Creation";

main :: ()
{
	window_width  := 1280; 
	window_height := 720;
	frames_alive := 2000;

	window := create_window(window_name="Path Tracer", width=window_width, height=window_height);

	while frames_alive > 0
	{
		print("Frames left %\n", frames_alive);
		frames_alive -= 1;
	}
}