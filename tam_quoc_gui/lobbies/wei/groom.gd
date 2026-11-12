extends Node2D
## Foreground caretaker, feet pinned; one continuous silhouette stays above horses and dust.
var clock:=0.0
var source:Texture2D
var silhouette:=PackedVector2Array()
func _ready()->void:
 source=load("res://lobbies/wei/base.png")
 var local_points=[Vector2(141,542),Vector2(139,535),Vector2(164,523),Vector2(175,500),Vector2(173,452),Vector2(151,428),Vector2(153,374),Vector2(137,361),Vector2(152,252),Vector2(161,228),Vector2(151,215),Vector2(150,180),Vector2(112,182),Vector2(88,163),Vector2(61,99),Vector2(67,83),Vector2(86,86),Vector2(102,70),Vector2(120,75),Vector2(129,95),Vector2(163,106),Vector2(171,91),Vector2(149,64),Vector2(147,35),Vector2(156,15),Vector2(185,7),Vector2(193,0),Vector2(212,0),Vector2(218,17),Vector2(214,27),Vector2(214,65),Vector2(222,72),Vector2(242,91),Vector2(262,118),Vector2(261,150),Vector2(265,207),Vector2(246,215),Vector2(267,254),Vector2(294,357),Vector2(282,369),Vector2(291,417),Vector2(287,443),Vector2(284,488),Vector2(289,535),Vector2(282,542),Vector2(248,542),Vector2(220,535),Vector2(218,523),Vector2(240,513),Vector2(240,461),Vector2(223,431),Vector2(220,383),Vector2(211,382),Vector2(208,425),Vector2(205,449),Vector2(204,489),Vector2(207,534),Vector2(201,543)]
 for p in local_points:silhouette.append(Vector2(1290,425)+p/3.0)
func _process(delta:float)->void:
 clock+=delta
 queue_redraw()
func _draw()->void:
 var moved:=PackedVector2Array()
 var uv:=PackedVector2Array()
 for p in silhouette:
  var weight:=clampf((602-p.y)/160.0,0,1)
  moved.append(p+Vector2(sin(clock*1.1)*.8*weight,sin(clock*1.8)*.35*weight))
  uv.append(p/Vector2(source.get_size()))
 draw_polygon(moved,PackedColorArray([Color.WHITE]),uv,source)
