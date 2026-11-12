extends Control
func _ready() -> void:
 mouse_filter = Control.MOUSE_FILTER_IGNORE
func _draw() -> void:
 var center := Vector2(16,16)
 draw_arc(center,12,deg_to_rad(42),deg_to_rad(130),24,Color("4285f4"),5,true)
 draw_arc(center,12,deg_to_rad(130),deg_to_rad(198),24,Color("34a853"),5,true)
 draw_arc(center,12,deg_to_rad(198),deg_to_rad(243),18,Color("fbbc05"),5,true)
 draw_arc(center,12,deg_to_rad(243),deg_to_rad(309),24,Color("ea4335"),5,true)
 draw_line(Vector2(17,16),Vector2(29,16),Color("4285f4"),5,true)
 draw_line(Vector2(29,16),Vector2(29,23),Color("4285f4"),4,true)
