module vstorm

// Used to initialise the framework.
pub struct AppConfig {
pub mut:
	winconfig WindowConfig
}

// Struct that contains all the data about the app.
[heap]
pub struct AppContext {
pub mut:
	win  &AppWindow
	root &Node
}

// Runs the created app context.
[inline]
pub fn (mut app AppContext) run() {
	app.win.run()
}

// Creates a new app context.
pub fn new_storm_context(mut args AppConfig) &AppContext {
	// Declare all Storm things
	mut app := &AppContext{
		win: &AppWindow{}
		root: &Node{}
	}
	app.root.context = app

	// Init all modules
	app.win.init(app, mut args.winconfig)

	return app
}
