module vstorm

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

// Adds a component to the node.
// The component can be any struct and is saved as a refference to the original data.
pub fn (mut e Node) add_component(what voidptr, str string) {
	e.components[str] = what
}

// Checks if a component with a specific name exists.
pub fn (mut e Node) has_component(str string) bool {
	return e.components[str] != voidptr(0)
}

// Deletes a component from the node.
pub fn (mut e Node) delete_component(str string) {
	e.components[str] = voidptr(0)
}

// Gets a specific component.
// ! Returns a voidptr that needs to be converted to the intended data struct !
pub fn (e Node) get_component(str string) voidptr {
	return e.components[str]
}

// Changes the context of the node (internal use only).
fn (mut e Node) change_context(newc &AppContext) {
	e.context = newc
	for _, mut x in e.children {
		x.change_context(newc)
	}
}

// Adds a child to the node.
pub fn (mut e Node) add_child(mut new Node, str string) {
	e.children[str] = new
	new.change_context(e.context)
	new.parent = &e
}

// Returns if the child with the specified name exists.
pub fn (mut e Node) has_child(str string) bool {
	return e.children[str] != voidptr(0)
}

// Removes a child with a specified name.
pub fn (mut e Node) remove_child(str string) {
	e.children[str].parent = voidptr(0)
	e.children[str] = voidptr(0)
}

// Adds a method with a specified name.
pub fn (mut e Node) add_function(new fn (&Node), str string) {
	e.functions[str] = new
}

// Executes a function on itself going down recursively if it also exists there.
pub fn (mut e Node) execute(str string) {
	if v := e.functions[str] {
		e.execute_one(v)
	}
	for _, mut x in e.children {
		x.execute(str)
	}
}

// Executes a specific function of the current entity.
pub fn (mut e Node) execute_one(func fn (&Node)) {
	func(&e)
}

// Executes a specific function on the current entity AND its children.
pub fn (mut e Node) execute_all(func fn (&Node)) {
	e.execute_one(func)
	for _, mut x in e.children {
		x.execute_one(func)
	}
}
