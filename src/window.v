module vstorm

import gx
import gg

// Used to initialise the window.
pub struct WindowConfig {
pub mut:
	title      string
	size       NodeV2D
	fullscreen bool
	init_fn    fn (&AppContext)
}

// Struct containing all the info about the window
[heap]
struct AppWindow {
pub mut:
	gg           &gg.Context = unsafe { 0 }
	latest_event &gg.Event   = unsafe { 0 }
}

// Struct containing all the info about the touches.
struct TouchList {
pub:
	count int
	list  []NodeV2D
}

// Function run by default when an event occured. (internal use only)
fn storm_default_event(e &gg.Event, mut app AppContext) {
	// Send the event down the nodes
	app.win.latest_event = unsafe { e }
	app.root.execute('event')
}

// Function run by default when a frame needs to be shown. (internal use only)
fn storm_default_frame(mut app AppContext) {
	// Emit update event
	app.root.execute('update')

	// Get gg context
	mut ggc := app.win.gg

	ggc.begin()

	// Emit draw event
	app.root.execute('draw')

	ggc.end()
}

// Gets current window scaling to be used with drawing functions.
pub fn (win AppWindow) get_app_scale() f32 {
	if win.gg.scale != 0 {
		return win.gg.scale
	}
	return 1
}

// Gets current touches state.
pub fn (win AppWindow) get_touches() TouchList {
	// Get data
	mut result := []NodeV2D{}
	scale := win.get_app_scale()
	e := win.latest_event

	// Build list
	for i := 0; i < e.num_touches; i++ {
		result << NodeV2D{
			x: e.touches[i].pos_x / scale
			y: e.touches[i].pos_y / scale
		}
	}

	// Send result
	return TouchList{
		count: e.num_touches
		list: result
	}
}

// Gets current mouse position.
pub fn (win AppWindow) get_mouse_pos() NodeV2D {
	mut scale := win.get_app_scale()
	e := win.latest_event
	return NodeV2D{
		x: e.mouse_x / scale
		y: e.mouse_y / scale
	}
}

// Gets current window size.
pub fn (win AppWindow) get_size() NodeV2D {
	mut size := win.gg.window_size()
	return NodeV2D{
		x: size.width + 1
		y: size.height + 1
	}
}

// Initialises the app window using the specified window config.
fn (mut win AppWindow) init(parent &AppContext, args WindowConfig) {
	win.gg = gg.new_context(
		bg_color: gx.rgb(0xFF, 0xFF, 0x00)
		width: args.size.x
		height: args.size.y
		window_title: args.title
		init_fn: args.init_fn
		fullscreen: args.fullscreen
		frame_fn: storm_default_frame
		event_fn: storm_default_event
		font_bytes_normal: $embed_file('../assets/SourceCodePro-Regular.otf').to_bytes()
		font_bytes_bold: $embed_file('../assets/SourceCodePro-Bold.otf').to_bytes()
		font_bytes_mono: $embed_file('../assets/SourceCodePro-Light.otf').to_bytes()
		font_bytes_italic: $embed_file('../assets/SourceCodePro-It.otf').to_bytes()
		user_data: parent
	)
}

// Starts the window.
fn (mut win AppWindow) run() {
	win.gg.run()
}
