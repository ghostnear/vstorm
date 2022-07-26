# module ghostnear.vstorm

## Contents
- [storm_default_frame](#storm_default_frame)
- [new_text_node](#new_text_node)
- [new_storm_context](#new_storm_context)
- [storm_default_event](#storm_default_event)
- [Node](#Node)
  - [add_component](#add_component)
  - [has_component](#has_component)
  - [delete_component](#delete_component)
  - [get_component](#get_component)
  - [change_context](#change_context)
  - [add_child](#add_child)
  - [has_child](#has_child)
  - [get_child](#get_child)
  - [remove_child](#remove_child)
  - [add_function](#add_function)
  - [execute](#execute)
  - [execute_one](#execute_one)
  - [execute_all](#execute_all)
- [NodeR2D](#NodeR2D)
  - [check_inside](#check_inside)
  - [get_relative_to](#get_relative_to)
- [NodeV2D](#NodeV2D)
  - [divide_by](#divide_by)
  - [multiply_by](#multiply_by)
  - [-](#-)
  - [+](#+)
  - [get_relative_to](#get_relative_to)
- [AppContext](#AppContext)
  - [run](#run)
- [AppWindow](#AppWindow)
  - [get_app_scale](#get_app_scale)
  - [get_touches](#get_touches)
  - [get_mouse_pos](#get_mouse_pos)
  - [get_size](#get_size)
  - [init](#init)
  - [run](#run)
- [AppConfig](#AppConfig)
- [TextConfig](#TextConfig)
- [TouchList](#TouchList)
- [WindowConfig](#WindowConfig)

## storm_default_frame
```v
fn storm_default_frame(mut app AppContext)
```

Function run by default when a frame needs to be shown. (internal use only)

[[Return to contents]](#Contents)

## new_text_node
```v
pub fn new_text_node(config TextConfig, text string) &Node
```

Creates a new text node with the specified config and string.  

[[Return to contents]](#Contents)

## new_storm_context
```v
pub fn new_storm_context(args AppConfig) &AppContext
```

Creates a new app context.  

[[Return to contents]](#Contents)

## storm_default_event
```v
fn storm_default_event(e &gg.Event, mut app AppContext)
```

Function run by default when an event occured. (internal use only)

[[Return to contents]](#Contents)

## Node
```v
[heap]
pub struct Node {
mut:
	// Components are containers holding data as any struct.
	components map[string]voidptr
	// Children are other nodes that have the current node as parent.
	children map[string]&Node
	// Functions are methods that can be executed ON the node.
	functions map[string]fn (&Node)
pub mut:
	parent  &Node       = unsafe { 0 }
	context &AppContext = unsafe { 0 }
}
```


[[Return to contents]](#Contents)

## add_component
```v
pub fn (mut e Node) add_component(what voidptr, str string)
```

Adds a component to the node.  
The component can be any struct and is saved as a refference to the original data.  

[[Return to contents]](#Contents)

## has_component
```v
pub fn (mut e Node) has_component(str string) bool
```

Checks if a component with a specific name exists.  

[[Return to contents]](#Contents)

## delete_component
```v
pub fn (mut e Node) delete_component(str string)
```

Deletes a component from the node.  

[[Return to contents]](#Contents)

## get_component
```v
pub fn (e Node) get_component(str string) voidptr
```

Gets a specific component.  
! Returns a voidptr that needs to be converted to the intended data struct !

[[Return to contents]](#Contents)

## change_context
```v
fn (mut e Node) change_context(newc &AppContext)
```

Changes the context of the node (internal use only).  

[[Return to contents]](#Contents)

## add_child
```v
pub fn (mut e Node) add_child(mut new Node, str string)
```

Adds a child to the node.  

[[Return to contents]](#Contents)

## has_child
```v
pub fn (mut e Node) has_child(str string) bool
```

Returns if the child with the specified name exists.  

[[Return to contents]](#Contents)

## get_child
```v
pub fn (mut e Node) get_child(str string) &Node
```

Gets a child with a specified name.  

[[Return to contents]](#Contents)

## remove_child
```v
pub fn (mut e Node) remove_child(str string)
```

Removes a child with a specified name.  

[[Return to contents]](#Contents)

## add_function
```v
pub fn (mut e Node) add_function(new fn (&Node), str string)
```

Adds a method with a specified name.  

[[Return to contents]](#Contents)

## execute
```v
pub fn (mut e Node) execute(str string)
```

Executes a function on itself going down recursively if it also exists there.  

[[Return to contents]](#Contents)

## execute_one
```v
pub fn (mut e Node) execute_one(func fn (&Node))
```

Executes a specific function of the current entity.  

[[Return to contents]](#Contents)

## execute_all
```v
pub fn (mut e Node) execute_all(func fn (&Node))
```

Executes a specific function on the current entity AND its children.  

[[Return to contents]](#Contents)

## NodeR2D
```v
pub struct NodeR2D {
pub mut:
	// Position
	pos NodeV2D
	// Size
	siz NodeV2D
}
```

Struct that represents a 2D rectangle into memory.  

[[Return to contents]](#Contents)

## check_inside
```v
pub fn (n NodeR2D) check_inside(what NodeV2D) bool
```

Checks if a point represented by a 2D vertex is inside the rectangle.  

[[Return to contents]](#Contents)

## get_relative_to
```v
pub fn (n NodeR2D) get_relative_to(what NodeV2D) NodeR2D
```

Returns a modified version of the current rectangle relative to the argument vertex.  
It can return the original rectangle if the relative flag is not set for both the size and position.  

[[Return to contents]](#Contents)

## NodeV2D
```v
pub struct NodeV2D {
pub mut:
	x f32
	y f32
	r bool
}
```

Struct that represents a 2D vertex into memory.  
Can be relative to another 2D vertex.  

[[Return to contents]](#Contents)

## divide_by
```v
pub fn (a NodeV2D) divide_by<T>(b T) NodeV2D
```

Divide the vertex by a scalar.  

[[Return to contents]](#Contents)

## multiply_by
```v
pub fn (a NodeV2D) multiply_by<T>(b T) NodeV2D
```

Mulitiply the vertex by a scalar.  

[[Return to contents]](#Contents)

## -
```v
fn (a NodeV2D) - (b NodeV2D) NodeV2D
```

Subtract a vertex from another.  

[[Return to contents]](#Contents)

## +
```v
fn (a NodeV2D) + (b NodeV2D) NodeV2D
```

Add two vertexes.  

[[Return to contents]](#Contents)

## get_relative_to
```v
pub fn (n NodeV2D) get_relative_to(what NodeV2D) NodeV2D
```

Returns a modified version of the current vertex relative to the argument vertex.  
This happens only if the relative flag is set to true, otherwise the original is returned.  

[[Return to contents]](#Contents)

## AppContext
```v
[heap]
pub struct AppContext {
pub mut:
	win  &AppWindow
	root &Node
}
```

Struct that contains all the data about the app.  

[[Return to contents]](#Contents)

## run
```v
pub fn (mut app AppContext) run()
```

Runs the created app context.  

[[Return to contents]](#Contents)

## AppWindow
```v
[heap]
struct AppWindow {
pub mut:
	gg           &gg.Context = unsafe { 0 }
	latest_event &gg.Event   = unsafe { 0 }
}
```

Struct containing all the info about the window

[[Return to contents]](#Contents)

## get_app_scale
```v
pub fn (win AppWindow) get_app_scale() f32
```

Gets current window scaling to be used with drawing functions.  

[[Return to contents]](#Contents)

## get_touches
```v
pub fn (win AppWindow) get_touches() TouchList
```

Gets current touches state.  

[[Return to contents]](#Contents)

## get_mouse_pos
```v
pub fn (win AppWindow) get_mouse_pos() NodeV2D
```

Gets current mouse position.  

[[Return to contents]](#Contents)

## get_size
```v
pub fn (win AppWindow) get_size() NodeV2D
```

Gets current window size.  

[[Return to contents]](#Contents)

## init
```v
fn (mut win AppWindow) init(parent &AppContext, args WindowConfig)
```

Initialises the app window using the specified window config.  

[[Return to contents]](#Contents)

## run
```v
fn (mut win AppWindow) run()
```

Starts the window.  

[[Return to contents]](#Contents)

## AppConfig
```v
pub struct AppConfig {
pub mut:
	winconfig WindowConfig
}
```

Used to initialise the framework.  

[[Return to contents]](#Contents)

## TextConfig
```v
pub struct TextConfig {
pub mut:
	color          gx.Color
	size           int
	italic         bool
	relative       bool
	text           string
	position       NodeV2D
	align          gx.HorizontalAlign
	vertical_align gx.VerticalAlign
}
```

Config for the text to draw with.  

[[Return to contents]](#Contents)

## TouchList
```v
struct TouchList {
pub:
	count int
	list  []NodeV2D
}
```

Struct containing all the info about the touches.  

[[Return to contents]](#Contents)

## WindowConfig
```v
pub struct WindowConfig {
pub mut:
	title      string
	size       NodeV2D
	fullscreen bool
	ui_mode    bool
	init_fn    fn (&AppContext)
}
```

Used to initialise the window.  

[[Return to contents]](#Contents)

#### Powered by vdoc. Generated on: 26 Jul 2022 15:24:36
