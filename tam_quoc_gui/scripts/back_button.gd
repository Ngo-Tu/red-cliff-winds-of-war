extends "res://scripts/raised_button.gd"
## Original neutral frame; only the return icon is replaced.
func _ready()->void:
 super._ready()
 tooltip_text="Quay lại"
 mouse_default_cursor_shape=Control.CURSOR_POINTING_HAND
func _draw()->void:
 super._draw()
 var center:=size*0.5+Vector2(0,lift-1)
 var arrow:=PackedVector2Array([Vector2(3,-9),Vector2(-7,0),Vector2(3,9),Vector2(6,6),Vector2(0,1.8),Vector2(10,1.8),Vector2(10,-1.8),Vector2(0,-1.8),Vector2(6,-6)])
 var shadow:=PackedVector2Array()
 var face:=PackedVector2Array()
 var colors:=PackedColorArray()
 for v in arrow:
  shadow.append(v+center+Vector2(0,1.5))
  face.append(v+center)
  colors.append(Color("fff2d6").lerp(Color("bda47b"),(v.y+9)/18.0))
 draw_colored_polygon(shadow,Color("17140f"))
 draw_polygon(face,colors)
 draw_polyline(PackedVector2Array([center+Vector2(3,-9),center+Vector2(-7,0),center+Vector2(3,9)]),Color("eee5d4"),0.7,true)
