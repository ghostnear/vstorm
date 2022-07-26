module vstorm

// Struct that represents a 2D vertex into memory.
// Can be relative to another 2D vertex.
pub struct NodeV2D {
pub mut:
	x f32
	y f32
	r bool
}

// ! Operations do not care about relativeness, make sure you use .get_relative_to() !

// Divide the vertex by a scalar.
pub fn (a NodeV2D) divide_by<T>(b T) NodeV2D {
	return NodeV2D{
		x: a.x / b
		y: a.y / b
	}
}

// Mulitiply the vertex by a scalar.
pub fn (a NodeV2D) multiply_by<T>(b T) NodeV2D {
	return NodeV2D{
		x: a.x * b
		y: a.y * b
	}
}

// Subtract a vertex from another.
fn (a NodeV2D) - (b NodeV2D) NodeV2D {
	return NodeV2D{
		x: a.x - b.x
		y: a.y - b.y
	}
}

// Add two vertexes.
fn (a NodeV2D) + (b NodeV2D) NodeV2D {
	return NodeV2D{
		x: a.x + b.x
		y: a.y + b.y
	}
}

// Returns a modified version of the current vertex relative to the argument vertex.
// This happens only if the relative flag is set to true, otherwise the original is returned.
pub fn (n NodeV2D) get_relative_to(what NodeV2D) NodeV2D {
	if n.r == true {
		return NodeV2D{
			x: what.x * n.x
			y: what.y * n.y
		}
	}
	return n
}

// Struct that represents a 2D rectangle into memory.
pub struct NodeR2D {
pub mut:
	// Position
	pos NodeV2D
	// Size
	siz NodeV2D
}

// Checks if a point represented by a 2D vertex is inside the rectangle.
pub fn (n NodeR2D) check_inside(what NodeV2D) bool {
	return what.x >= n.pos.x && what.y >= n.pos.y && what.x <= n.pos.x + n.siz.x
		&& what.y <= n.pos.y + n.siz.y
}

// Returns a modified version of the current rectangle relative to the argument vertex.
// It can return the original rectangle if the relative flag is not set for both the size and position.
pub fn (n NodeR2D) get_relative_to(what NodeV2D) NodeR2D {
	return NodeR2D{
		pos: n.pos.get_relative_to(what)
		siz: n.siz.get_relative_to(what)
	}
}
