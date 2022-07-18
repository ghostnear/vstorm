module vstorm

type Number = f32 | int

pub struct NodeV2D {
pub mut:
	x f32
	y f32
	r bool
}

// ! Operations do not care about relativeness, make sure you use .get_relative_to() !

pub fn (a NodeV2D) divide_by(b int) NodeV2D {
	return NodeV2D {
		x: a.x / b
		y: a.y / b
	}
}

// TODO: fix this duplicate mess
pub fn (a NodeV2D) multiply_by_float(b f32) NodeV2D {
	return NodeV2D {
		x: a.x * b
		y: a.y * b
	}
}

pub fn (a NodeV2D) multiply_by(b int) NodeV2D {
	return NodeV2D {
		x: a.x * b
		y: a.y * b
	}
}

pub fn (a NodeV2D) - (b NodeV2D) NodeV2D {
	return NodeV2D {
		x: a.x - b.x
		y: a.y - b.y
	}
}

pub fn (a NodeV2D) + (b NodeV2D) NodeV2D {
	return NodeV2D {
		x: a.x + b.x
		y: a.y + b.y
	}
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

pub struct NodeR2D {
pub mut:
	pos NodeV2D
	siz NodeV2D
}

pub fn (n NodeR2D) check_inside(what NodeV2D) bool {
	return  what.x >= n.pos.x && what.y >= n.pos.y &&
			what.x <= n.pos.x + n.siz.x && what.y <= n.pos.y + n.siz.y
}

pub fn (n NodeR2D) get_relative_to(what NodeV2D) NodeR2D {
	return NodeR2D{
		pos: n.pos.get_relative_to(what)
		siz: n.siz.get_relative_to(what)
	}
}