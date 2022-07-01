module vstorm

import gx

[heap]
struct StormContext {
mut:
	win &StormWindow
}

// Default draw function
pub fn storm_default_draw(mut app StormContext) {
	mut ggc := &app.win.gg
	ggc.begin()

	// TODO: state managing and stuff has to do their drawing here
	ggc.draw_rect_filled(10, 10, 60, 60, gx.blue)

	ggc.end()
}

// Runs the context
pub fn (mut app StormContext) run() {
	app.win.run()
}

// Makes a new storm context for app usage
pub fn new_storm_context(args StormConfig) &StormContext {
	// Declare all Storm modules
	mut app := &StormContext{
		win: &StormWindow{
			gg: 0
		}
	}

	// Init all modules
	app.win.init(app, args.winconfig)

	return app
}
