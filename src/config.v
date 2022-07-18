module vstorm

// Used to initialise the window
pub struct StormWindowConfig {
pub mut:
	title string
	width int
	height int
	fullscreen bool
	init_fn fn(&StormContext)
}

// Used to initialise the framework
pub struct StormConfig {
pub mut:
	winconfig StormWindowConfig
}
