module vstorm

import gx

// Config for the text to draw with.
pub struct TextConfig {
pub mut:
	color          gx.Color
	size           f32
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
	}, 'config')
	node.add_function(fn (mut node Node) {
		// Get context info
		mut win := node.context.win
		mut ggc := win.gg
		w_size := win.get_size()
		scale := win.get_app_scale()
	
		// Get text config
		t := &TextConfig(node.get_component('config'))

		// Parent is guaranteed to be a button so get the properties so we know where to draw the text
		mut pos := (&NodeV2D(node.get_component('position'))).get_relative_to(w_size)

		// TODO: replace this workaround when the standard gg module works
		ggc.draw_text(
			int(pos.x), int(pos.y),
			t.text, gx.TextCfg{
			color: t.color
			size: int(t.size * win.force_scale / scale)
			italic: t.italic
			align: t.align
			vertical_align: t.vertical_align
		})
	}, 'draw')
	return node
}
