extends Node2D
## Shared by lobby and subpages. Source artwork, screen positions and scale are identical.
var source:Texture2D
var COUNTERS=[PackedVector2Array([Vector2(1187,14),Vector2(1368,14),Vector2(1384,36),Vector2(1368,59),Vector2(1187,59),Vector2(1168,36)]),PackedVector2Array([Vector2(1407,14),Vector2(1578,14),Vector2(1596,36),Vector2(1578,59),Vector2(1407,59),Vector2(1388,36)]),PackedVector2Array([Vector2(1613,7),Vector2(1648,7),Vector2(1667,35),Vector2(1648,66),Vector2(1613,66),Vector2(1595,35)])]
func _ready()->void:source=load("res://lobbies/wei/base.png")
func _draw()->void:
 if source==null:return
 for shape in COUNTERS:
  var uv:=PackedVector2Array()
  for p in shape:uv.append(p/Vector2(source.get_size()))
  draw_polygon(shape,PackedColorArray([Color.WHITE]),uv,source)
