module vstorm

pub struct NodeV2D {
pub mut:
	x f32
	y f32

	// If values are relative to something or absolute
	r bool
}

pub fn (n NodeV2D) get_relative_to(what NodeV2D) NodeV2D {
	if n.r == true {
		return NodeV2D{
			x: what.x * n.x
			y: what.y * n.y
		}
	}
	return n
}