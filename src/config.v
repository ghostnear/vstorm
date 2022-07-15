module vstorm

// Used to initialise the window
pub struct StormWindowConfig {
	title string
	width int
	height int
	init_fn fn(&StormContext)
}

// Used to initialise the framework
pub struct StormConfig {
	winconfig StormWindowConfig
}
