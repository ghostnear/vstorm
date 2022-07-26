module vstorm

import gx

// Config for the text to draw with.
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

// Creates a new text node with the specified config and string.
pub fn new_text_node(config TextConfig, text string) &Node {
	mut node := &Node{}
	node.add_component(&NodeV2D{
		x: config.position.x
		y: config.position.y
		r: config.position.r
	}, 'position')
	node.add_component(&TextConfig{
		color: config.color
		size: config.size
		italic: config.italic
		relative: config.relative
		text: text
		align: config.align
		vertical_align: config.vertical_align
	}, 'cfg')
	node.add_function(fn (mut node Node) {
		// Get text config
		t := &TextConfig(node.get_component('cfg'))

		// Get context info
		mut win := node.context.win
		mut ggc := win.gg
		w_size := win.get_size()
		scale := win.get_app_scale()

		// Parent is guaranteed to be a button so get the properties so we know where to draw the text
		mut pos := (&NodeV2D(node.get_component('position'))).get_relative_to(w_size)
		ggc.draw_text(int(pos.x), int(pos.y), t.text, gx.TextCfg{
			color: t.color
			size: int(t.size * scale)
			italic: t.italic
			align: t.align
			vertical_align: t.vertical_align
		})
	}, 'draw')
	return node
}
