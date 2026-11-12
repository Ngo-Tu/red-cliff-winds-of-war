extends Button

const GOLD = Color("e8c88e")
const BRONZE = Color("a58b62")
const RED_PIP = Color("e03838")
const DARK_INK = Color(0.08, 0.07, 0.06, 0.88)

@export var icon_type: String = "notification" # "notification" or "account"
@export var has_unread: bool = true

var is_hover: bool = false

func _ready() -> void:
	flat = true
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	var empty := StyleBoxEmpty.new()
	for st in ["normal", "hover", "pressed", "focus", "disabled"]:
		add_theme_stylebox_override(st, empty)
	mouse_entered.connect(func(): is_hover = true; queue_redraw())
	mouse_exited.connect(func(): is_hover = false; queue_redraw())

func _draw() -> void:
	var center := size * 0.5
	var radius := minf(size.x, size.y) * 0.46

	# 1. Circular Background
	draw_circle(center, radius, DARK_INK)

	# 2. Outer Ring
	var border_color := GOLD if is_hover else BRONZE
	draw_arc(center, radius, 0, TAU, 32, border_color, 2.0)
	draw_arc(center, radius - 3.0, 0, TAU, 32, Color(border_color.r, border_color.g, border_color.b, 0.45), 1.0)

	var icon_color := Color(1.0, 0.95, 0.85) if is_hover else GOLD

	if icon_type == "notification":
		# Draw Antique Bell Icon
		var bell_top := center + Vector2(0, -9)
		draw_circle(bell_top + Vector2(0, -2), 2.5, icon_color)

		# Bell body
		var points := PackedVector2Array([
			center + Vector2(-3, -7),
			center + Vector2(3, -7),
			center + Vector2(6, 1),
			center + Vector2(10, 6),
			center + Vector2(-10, 6),
			center + Vector2(-6, 1)
		])
		draw_colored_polygon(points, icon_color)

		# Bell clapper
		draw_circle(center + Vector2(0, 8), 2.2, icon_color)
		draw_line(center + Vector2(-11, 6), center + Vector2(11, 6), icon_color, 1.8)

		# Red Notification Pip
		if has_unread:
			var pip_pos := center + Vector2(8, -8)
			draw_circle(pip_pos, 4.5, RED_PIP)
			draw_arc(pip_pos, 4.5, 0, TAU, 16, Color.WHITE, 1.0)

	elif icon_type == "account":
		# Draw User Switch Icon
		var head_center := center + Vector2(0, -5)
		draw_circle(head_center, 4.5, icon_color)

		# Torso / Shoulders arc
		draw_arc(center + Vector2(0, 8), 8.0, PI, TAU, 16, icon_color, 2.0)

		# Small switch arrows flanking
		draw_line(center + Vector2(-11, -1), center + Vector2(-11, 5), icon_color, 1.5)
		draw_line(center + Vector2(-11, -1), center + Vector2(-9, 1), icon_color, 1.5)

		draw_line(center + Vector2(11, 1), center + Vector2(11, -5), icon_color, 1.5)
		draw_line(center + Vector2(11, 1), center + Vector2(9, -1), icon_color, 1.5)
