module vstorm

// Used to initialise the framework
pub struct AppConfig {
pub mut:
	winconfig WindowConfig
}

[heap]
pub struct AppContext {
pub mut:
	win &AppWindow
	root &Node
}

// Runs the context
pub fn (mut app AppContext) run() {
	app.win.run()
}

// Makes a new storm context for app usage
pub fn new_storm_context(args AppConfig) &AppContext {
	// Declare all Storm things
	mut app := &AppContext{
		win: &AppWindow{}
		root: &Node {}
	}
	app.root.context = app

	// Init all modules
	app.win.init(app, args.winconfig)

	return app
}
