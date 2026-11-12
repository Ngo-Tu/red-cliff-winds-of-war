extends Control

const GOLD = Color("e8c88e")
const BRONZE = Color("a58b62")
const DARK_INK = Color(0.06, 0.05, 0.05, 0.90)

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	resized.connect(queue_redraw)

func _draw() -> void:
	var r := Rect2(Vector2.ZERO, size)

	# 1. Dark Lacquer Obsidian Backing
	draw_rect(r, DARK_INK, true)

	# 2. Outer Antique Bronze Border (2px)
	draw_rect(r, BRONZE, false, 2.0)

	# 3. Inner Gold Hairline Inset by 6px
	var inner_r := r.grow(-6.0)
	draw_rect(inner_r, Color(GOLD.r, GOLD.g, GOLD.b, 0.45), false, 1.0)

	# 4. Antique Corner Brackets & Rivets
	var bracket_len := 22.0
	var corners := [
		Vector2.ZERO,
		Vector2(size.x, 0),
		Vector2(size.x, size.y),
		Vector2(0, size.y)
	]
	var dirs := [
		[Vector2.RIGHT, Vector2.DOWN],
		[Vector2.LEFT, Vector2.DOWN],
		[Vector2.LEFT, Vector2.UP],
		[Vector2.RIGHT, Vector2.UP]
	]

	for i in range(4):
		var p: Vector2 = corners[i]
		var d1: Vector2 = dirs[i][0]
		var d2: Vector2 = dirs[i][1]

		# Outer decorative L-lines
		draw_line(p + d1 * 2.0, p + d1 * bracket_len, GOLD, 2.5)
		draw_line(p + d2 * 2.0, p + d2 * bracket_len, GOLD, 2.5)

		# Inner diagonal reinforcement
		draw_line(p + d1 * 8.0, p + d2 * 8.0, Color(GOLD.r, GOLD.g, GOLD.b, 0.6), 1.5)

		# Corner brass stud / rivet
		draw_circle(p + (d1 + d2) * 11.0, 2.5, GOLD)

	# 5. Top Center & Bottom Center Medallion Tabs
	var mid_top := Vector2(size.x * 0.5, 0)
	draw_circle(mid_top, 4.0, GOLD)
	draw_line(mid_top - Vector2(30, 0), mid_top + Vector2(30, 0), GOLD, 1.5)

	var mid_bot := Vector2(size.x * 0.5, size.y)
	draw_circle(mid_bot, 4.0, GOLD)
	draw_line(mid_bot - Vector2(30, 0), mid_bot + Vector2(30, 0), GOLD, 1.5)
