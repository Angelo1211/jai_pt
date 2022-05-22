#import "Basic";
#import "Window_Creation";
#import "Input";

main :: ()
{
	window_width  :: 1280; 
	window_height :: 720;
	running := true;

	window := create_window(window_name="Path Tracer", width=window_width, height=window_height);

	// TODO(AO) Look into SIMP

	while running
	{
		update_window_events();

		for event : events_this_frame
		{
			if (event.type == .QUIT) || (event.key_code == .ESCAPE && event.key_pressed)
			{
				running = false;
				break;
			}
		}
	}
}


