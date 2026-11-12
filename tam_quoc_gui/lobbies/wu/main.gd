extends Node2D
var clock:=0.0
var surface:ShaderMaterial
var boats:Array[Node2D]=[]
var fish_textures:Array[Texture2D]=[]
func _ready()->void:
 var scene:=Sprite2D.new()
 scene.texture=load("res://lobbies/wu/base.png")
 scene.centered=false
 scene.show_behind_parent=true
 add_child(scene)
 var menu=load("res://lobbies/wu/lobby_menu.gd").new()
 menu.faction=1
 menu.name="LobbyMenu"
 add_child(menu)
 var leaf_fx=load("res://lobbies/wu/art_leaves.gd").new()
 leaf_fx.red=true
 leaf_fx.z_index=5
 add_child(leaf_fx)
 _add_flags()
 _add_boats()
 var fish=load("res://lobbies/wu/fish_fx.gd").new()
 fish.z_index=3
 add_child(fish)
func _process(delta:float)->void:
 clock+=delta
 for i in range(boats.size()):
  var boat:Node2D=boats[i]
  var rest:Vector2=boat.get_meta("rest")
  var phase:=clock*(.75+i*.08)+i*2.1
  boat.position=rest+Vector2(sin(clock*.22+i)*1.5,sin(phase)*(3.6-float(i)*.8))
  boat.rotation=sin(clock*(.94+i*.075)+i*2.1)*(.035-float(i)*.005)
  boat.get_child(0).material.set_shader_parameter("clock",clock)
  boat.get_child(1).material.set_shader_parameter("clock",clock)
 queue_redraw()
func _draw()->void:
 _draw_wakes()

func _add_flags()->void:
 var tex:Texture2D=load("res://lobbies/wu/flags_source.png")
 var shapes:Array=[
  [Vector2(869,160),Vector2(928,176),Vector2(940,357),Vector2(879,332),Vector2(868,339)],
  [Vector2(1037,209),Vector2(1087,221),Vector2(1095,367),Vector2(1043,343),Vector2(1037,351)]]
 for i in range(shapes.size()):
  var flag=load("res://lobbies/wu/flag_cloth.gd").new()
  flag.texture=tex
  flag.outline=PackedVector2Array(shapes[i])
  flag.phase=float(i)*1.7
  add_child(flag)
func _add_boats()->void:
 var river:=Control.new()
 river.position=Vector2(1092,210)
 river.size=Vector2(373,320)
 river.clip_contents=true
 add_child(river)
 for i in range(3):
  var boat:=Node2D.new()
  var sprite:=Sprite2D.new()
  sprite.texture=load("res://lobbies/wu/ship.png")
  sprite.centered=false
  sprite.position=Vector2(-768,-1005)
  var material:=ShaderMaterial.new()
  material.shader=load("res://lobbies/wu/boat_surface.gdshader")
  material.set_shader_parameter("phase",float(i)*1.7)
  sprite.material=material
  sprite.modulate=Color(.86,.89,.88) if i==0 else Color(.77,.84,.85,.9)
  boat.add_child(sprite)
  var reflection:=Sprite2D.new()
  reflection.texture=sprite.texture
  reflection.centered=false
  reflection.position=Vector2(-768,150.75)
  reflection.scale=Vector2(1,-.15)
  var reflected_material:=ShaderMaterial.new()
  reflected_material.shader=load("res://lobbies/wu/reflection.gdshader")
  reflection.material=reflected_material
  boat.add_child(reflection)
  var factor:float=[.20,.105,.067][i]
  boat.scale=Vector2(factor,factor)
  var rest:Vector2=[Vector2(292,231),Vector2(133,192),Vector2(53,175)][i]
  boat.position=rest
  boat.set_meta("rest",rest)
  river.add_child(boat)
  river.move_child(boat,0)
  boats.append(boat)

func _draw_wakes()->void:
 for i in range(3):
  var center:Vector2=[Vector2(1384,441),Vector2(1225,402),Vector2(1145,385)][i]
  for k in range(3):
   var radius:=88.0-float(i)*23.0+float(k)*5.0
   var points:=PackedVector2Array()
   for j in range(25):
    var t:=float(j)/24.0
    points.append(center+Vector2((t-.5)*radius*2+sin(clock*.22+i)*1.5,2+float(k)*2+sin(t*10+clock*.8+i)*.6+sin(clock*(.75+i*.08)+i*2.1)*(3.6-i*.8)))
   draw_polyline(points,Color(.73,.86,.86,.14-float(k)*.025),.8,true)
