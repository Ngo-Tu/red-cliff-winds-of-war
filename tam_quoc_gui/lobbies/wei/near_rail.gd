extends Node2D
var texture:Texture2D
func _ready()->void:
 texture=load("res://lobbies/wei/flags_source.png")
func _draw()->void:
 if texture==null:return
 for r in [Rect2(917,504,527,14),Rect2(922,491,15,114),Rect2(1128,493,17,112),Rect2(1311,494,14,113),Rect2(1432,496,12,108)]:
  draw_texture_rect_region(texture,r,r)
