module vstorm

// Components can be ANY struct

// Entities are data encapsulators
// They have functions which can be called from anywhere
// And children too
[heap]
pub struct Node {
mut:
	components map[string]voidptr
	children map[string]&Node
	functions map[string]fn(&Node)
pub mut:
	parent &Node = unsafe { 0 }
	context &StormContext = unsafe { 0 }
}

// Adds a component
pub fn (mut e Node) add_component(what voidptr, str string) {
	e.components[str] = what
}

// Returns if a specific component has been used
pub fn(mut e Node) has_component(str string) bool {
	return (e.components[str] != voidptr(0))
}

// Deletes a component
pub fn (mut e Node) delete_component(str string) {
	e.components[str] = voidptr(0)
}

// Gets component with specified identifier - ! returns a ptr that needs to be converted !
pub fn (e Node) get_component(str string) voidptr {
	return e.components[str]
}

// Changes context (internal use only)
fn (mut e Node) change_context(newc &StormContext) {
	e.context = newc
	for _, mut x in e.children {
		x.change_context(newc)
	}
}

// Adds a child
pub fn (mut e Node) add_child(mut new &Node, str string) {
	e.children[str] = new
	new.change_context(e.context)
	new.parent = &e
}

// Returns if specific child string is used
pub fn(mut e Node) has_child(str string) bool {
	return (e.children[str] != voidptr(0))
}

// Removes a child
pub fn (mut e Node) remove_child(str string) {
	e.children[str].parent = voidptr(0)
	e.children[str] = voidptr(0)
}

// Adds a method
pub fn (mut e Node) add_function(new fn(&Node), str string) {
	e.functions[str] = new
}

// Executes a function on itself and the children if it also exists there
pub fn(mut e Node) execute(str string) {
	if v := e.functions[str] {
		e.execute_one(v)
	}
	for _, mut x in e.children {
		x.execute(str)
	}
}

// Executes an arbitrary function on ONE entity (no children)
// Add a new function to all the children instead and execute it that way if you want to do that.
pub fn(mut e Node) execute_one(func fn(&Node)) {
	func(&e)
}