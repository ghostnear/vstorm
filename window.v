module vstorm

import gg
import gx

[heap]
struct StormWindow
{
mut:
	gg &gg.Context
}

// Initialises the window
pub fn (mut win StormWindow) init(parent &StormContext)
{
	win.gg = gg.new_context(
		bg_color: gx.black
		width: 960
		height: 540
		window_title: "VStorm app"
		frame_fn: storm_default_draw
		user_data: parent
	)
}

// Runs the window loop
pub fn (mut win StormWindow) run()
{
	win.gg.run()
}