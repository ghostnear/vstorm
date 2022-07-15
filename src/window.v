module vstorm

import gx
import gg

[heap]
struct StormWindow {
pub mut:
	gg &gg.Context = unsafe { 0 }
	latest_event &gg.Event = unsafe { 0 }
}

fn storm_default_event(e &gg.Event, mut app StormContext) {
	// Send the event down the nodes
	app.win.latest_event = unsafe { e }
	app.root.execute('event')
}

fn storm_default_frame(mut app StormContext) {
	// Emit update event
	app.root.execute("update")

	// Get gg context
	mut ggc := app.win.gg

	ggc.begin()

	// Emit draw event
	app.root.execute("draw")
	
	ggc.end()
}

// Gets current window scaling
pub fn (win StormWindow) get_app_scale() f32 {
	if win.gg.scale != 0 {
		return win.gg.scale
	}
	return 1
}

// Gets current mouse position
pub fn (win StormWindow) get_mouse_pos() NodeV2D {
	mut scale := win.get_app_scale()
	return NodeV2D{
		x: win.latest_event.mouse_x / scale
		y: win.latest_event.mouse_y / scale
	}
}

// Gets current window size
pub fn (mut win StormWindow) get_size() NodeV2D {
	mut size := win.gg.window_size()
	return NodeV2D{
		x: size.width + 1
		y: size.height + 1
	}
}

// Initialises the window
pub fn (mut win StormWindow) init(parent &StormContext, args StormWindowConfig) {
	win.gg = gg.new_context(
		bg_color: gx.rgb(0xFF, 0xFF, 0x00)
		width: args.width
		height: args.height
		window_title: args.title
		init_fn: args.init_fn
		frame_fn: storm_default_frame
		event_fn: storm_default_event
		font_bytes_normal: $embed_file('../assets/SourceCodePro-Regular.otf').to_bytes()
		font_bytes_bold:   $embed_file('../assets/SourceCodePro-Bold.otf').to_bytes()
		font_bytes_mono:   $embed_file('../assets/SourceCodePro-Light.otf').to_bytes()
		font_bytes_italic: $embed_file('../assets/SourceCodePro-It.otf').to_bytes()
		user_data: parent
	)
}

// Runs the window loop
pub fn (mut win StormWindow) run() {
	win.gg.run()
}
