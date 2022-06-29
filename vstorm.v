module vstorm

import gg
import gx

struct StormContext
{
mut:
	gg &gg.Context
}

// Runs the context
pub fn (mut app StormContext) run()
{
	app.gg.run()
}

// Makes a new storm context for app usage
pub fn new_storm_context() &StormContext {
	mut app := &StormContext{
		gg: 0
	}
	app.gg = gg.new_context(
		bg_color: gx.black
		width: 960
		height: 540
		window_title: "VStorm app"
	)
	return app
}