module vstorm

[heap]
pub struct StormContext {
pub mut:
	win &StormWindow
	root &Node
}

// Runs the context
pub fn (mut app StormContext) run() {
	app.win.run()
}

// Makes a new storm context for app usage
pub fn new_storm_context(args StormConfig) &StormContext {
	// Declare all Storm modules
	mut app := &StormContext{
		win: &StormWindow{}
		root: &Node {}
	}
	app.root.context = app

	// Init all modules
	app.win.init(app, args.winconfig)

	return app
}
