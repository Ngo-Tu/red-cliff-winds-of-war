extends Button
var source:Texture2D
func _ready()->void:
 source=load("res://lobbies/wei/buildings/approved_base.jpg")
 mouse_default_cursor_shape=Control.CURSOR_POINTING_HAND;tooltip_text="Quay lại sảnh"
 for state in ["normal","hover","pressed","focus"]:add_theme_stylebox_override(state,StyleBoxEmpty.new())
 mouse_entered.connect(queue_redraw);mouse_exited.connect(queue_redraw)
func _draw()->void:
 if source==null:return
 var shape:=PackedVector2Array([Vector2(52,17),Vector2(101,17),Vector2(116,37),Vector2(101,59),Vector2(52,59),Vector2(37,39)])
 var points:=PackedVector2Array();var uv:=PackedVector2Array()
 for p in shape:
  points.append((p-Vector2(37,17))*Vector2(size.x/79,size.y/42));uv.append(p/Vector2(source.get_size()))
 draw_polygon(points,PackedColorArray([Color(1.1,1.1,1.1) if is_hovered() else Color.WHITE]),uv,source)
