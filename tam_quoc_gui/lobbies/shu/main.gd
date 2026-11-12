extends Node2D
var clock:=0.0
var atmosphere:ShaderMaterial
func _ready()->void:
 var scene:=Sprite2D.new()
 scene.texture=load("res://lobbies/shu/base.png")
 scene.centered=false
 add_child(scene)
 var menu=load("res://lobbies/shu/lobby_menu.gd").new()
 menu.faction=2
 menu.name="LobbyMenu"
 add_child(menu)
 _flags()
 var air:=ColorRect.new()
 air.size=Vector2(1672,941)
 air.mouse_filter=Control.MOUSE_FILTER_IGNORE
 atmosphere=ShaderMaterial.new()
 atmosphere.shader=load("res://lobbies/shu/atmosphere.gdshader")
 air.material=atmosphere
 add_child(air)
 var leaves=load("res://lobbies/shu/bamboo_leaves.gd").new()
 add_child(leaves)
func _process(delta:float)->void:
 clock+=delta
 atmosphere.set_shader_parameter("clock",clock)
func _flags()->void:
 var shapes=[
  [true,[Vector2(476,150),Vector2(505,157),Vector2(505,235),Vector2(490,252),Vector2(475,235)]],
  [true,[Vector2(865,260),Vector2(886,267),Vector2(887,334),Vector2(876,347),Vector2(865,332)]],
  [true,[Vector2(1150,404),Vector2(1164,409),Vector2(1164,445),Vector2(1156,453),Vector2(1150,445)]],
  [true,[Vector2(1208,372),Vector2(1220,376),Vector2(1220,399),Vector2(1213,407),Vector2(1208,398)]],
  [true,[Vector2(1287,427),Vector2(1302,432),Vector2(1301,459),Vector2(1293,466),Vector2(1287,456)]],
  [false,[Vector2(1328,191),Vector2(1343,195),Vector2(1342,205),Vector2(1328,202)]],
  [false,[Vector2(1430,181),Vector2(1446,187),Vector2(1445,197),Vector2(1430,192)]]]
 for i in range(shapes.size()):
  var flag=load("res://lobbies/shu/flag_cloth.gd").new()
  flag.texture=load("res://lobbies/shu/base.png")
  flag.hanging=shapes[i][0]
  flag.outline=PackedVector2Array(shapes[i][1])
  flag.phase=float(i)*.8
  add_child(flag)
