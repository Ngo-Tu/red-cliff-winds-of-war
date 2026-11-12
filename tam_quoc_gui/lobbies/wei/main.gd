extends Node2D
var building_layer:Node2D
var clock:=0.0
var surface:ShaderMaterial
var leaves:Node2D
var cavalry:Array[TextureRect]=[]
func _ready()->void:
 var scene:=Sprite2D.new()
 scene.texture=load("res://lobbies/wei/base.png")
 scene.centered=false
 scene.show_behind_parent=true
 add_child(scene)
 var currency=load("res://lobbies/wei/wei_currency_header.gd").new();currency.name="CurrencyHeader";add_child(currency)
 var menu=load("res://lobbies/wei/lobby_menu.gd").new()
 menu.faction=0
 menu.name="LobbyMenu"
 add_child(menu)
 menu.action_requested.connect(func(action:String):
  if action=="Công trình":_open_buildings()
 )
 leaves=load("res://lobbies/wei/art_leaves.gd").new()
 leaves.z_index=2
 add_child(leaves)
 var lane:=Control.new()
 lane.position=Vector2(935,344)
 lane.size=Vector2(529,87)
 lane.clip_contents=true
 add_child(lane)
 var atlas:=AtlasTexture.new()
 atlas.atlas=load("res://lobbies/wei/cavalry_group.png")
 atlas.region=Rect2(42,212,695,265)
 for i in range(6):
  var group:=TextureRect.new()
  group.texture=atlas
  group.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
  group.size=Vector2(195,66)
  group.modulate=Color(.79,.80,.77,1.0) if i%3<2 else Color.WHITE
  group.flip_h=i>=3
  group.pivot_offset=group.size*Vector2(.5,1)
  lane.add_child(group)
  cavalry.append(group)
 var dust_front:=Node2D.new()
 dust_front.z_index=1
 var dust_shader:=Shader.new()
 dust_shader.code="shader_type canvas_item; varying vec2 design_position; void vertex(){ design_position=VERTEX; } void fragment(){ vec4 c=COLOR; float a=smoothstep(0.85,1.05,length((design_position-vec2(1118.0,432.0))/vec2(39.0,51.0))); float b=smoothstep(0.85,1.05,length((design_position-vec2(1305.0,433.0))/vec2(35.0,51.0))); COLOR=vec4(c.rgb,c.a*a*b); }"
 var dust_material:=ShaderMaterial.new()
 dust_material.shader=dust_shader
 dust_front.material=dust_material
 add_child(dust_front)
 dust_front.draw.connect(_draw_hoof_dust.bind(dust_front))
 dust_front.name="HoofDust"
 _add_flags()
 _add_near_horses()
 var groom=load("res://lobbies/wei/groom.gd").new()
 groom.z_index=4
 add_child(groom)
func _process(delta:float)->void:
 clock+=delta

 for i in range(cavalry.size()):
  var rank:=i%3
  var pulse:=sin(clock*.5+rank*.8)*5.0
  var x:=8.0+rank*30+pulse if i<3 else 325.0-rank*30-pulse
  cavalry[i].position=Vector2(x,rank*6+sin(clock*.8+i)*.6)
  cavalry[i].rotation=sin(clock*.6+i)*.0015
 get_node("HoofDust").queue_redraw()

 queue_redraw()
func _cloud(center:Vector2,radius:Vector2,color:Color)->void:
 draw_set_transform(center,0,radius)
 for k in range(6,0,-1):
  var f:=float(k)/6.0
  draw_circle(Vector2.ZERO,f,Color(color.r,color.g,color.b,color.a*(1.0-f*.65)*.23))
 draw_set_transform(Vector2.ZERO)
func _gust_age()->float:
 var cycle:=fposmod(clock,34.5)
 var last:=-100.0
 for onset in [7.4,16.7,24.9,34.5]:
  if cycle>=onset:last=onset
 return cycle-last
func _draw()->void:
 for i in range(24):
  var phase:=fposmod(clock*.24+i*.173,1.0)
  var x:=940.0+fposmod(i*67.0+clock*9.0,510.0)
  var y:=412.0-sin(phase*PI)*5.0+float(i%3)*2.0
  _cloud(Vector2(x,y),Vector2(20+phase*20,4+phase*5),Color(.80,.69,.50,sin(phase*PI)*.14))
 var age:=_gust_age()
 if age<3.7:
  var envelope:=sin(age/3.7*PI)
  for i in range(17):
   var x:=-330+age*530+float(i%5)*88
   var y:=510+float(i%4)*54+sin(age+i)*12
   _cloud(Vector2(x,y),Vector2(100+i%3*24,8+i%4*4),Color(.72,.65,.49,envelope*.17))
  for i in range(34):
   var x:=fposmod(age*610+i*71.0,1850.0)-90
   var y:=460+fposmod(i*39.0+age*10,235.0)
   draw_line(Vector2(x,y),Vector2(x+5,y-1),Color(.73,.66,.49,envelope*.20),.7,true)

func _draw_hoof_dust(layer:Node2D)->void:
 # This layer is above the cavalry artwork: dense at the hoof line, soft at the top.
 for i in range(84):
  var phase:=fposmod(clock*.20+i*.137,1.0)
  var x:=944+fposmod(i*37.0+clock*(9 if i%2==0 else -7),510.0)
  var y:=420.0-float(i%4)*3.0+sin(phase*PI)*3.0
  var tint:=Color(.78,.69,.53,.23+sin(phase*PI)*.11)
  layer.draw_set_transform(Vector2(x,y),0,Vector2(34+phase*29,10+phase*9))
  for ring in range(6,0,-1):
   var f:=float(ring)/6.0
   layer.draw_circle(Vector2.ZERO,f,Color(tint.r,tint.g,tint.b,tint.a*(1-f*.65)))
 layer.draw_set_transform(Vector2.ZERO)

func _add_flags()->void:
 var tex:Texture2D=load("res://lobbies/wei/flags_source.png")
 var shapes:Array=[
  [false,[Vector2(450,136),Vector2(474,146),Vector2(489,153),Vector2(485,161),Vector2(490,178),Vector2(467,174),Vector2(450,169)]],
  [true,[Vector2(457,255),Vector2(496,261),Vector2(500,342),Vector2(480,365),Vector2(458,344)]],
  [true,[Vector2(618,279),Vector2(644,284),Vector2(648,355),Vector2(634,374),Vector2(620,357)]],
  [false,[Vector2(879,200),Vector2(899,207),Vector2(910,222),Vector2(880,218)]],
  [false,[Vector2(1038,291),Vector2(1060,300),Vector2(1078,303),Vector2(1073,313),Vector2(1079,329),Vector2(1055,325),Vector2(1038,324)]],
  [false,[Vector2(1208,313),Vector2(1231,320),Vector2(1237,334),Vector2(1210,332)]],
  [false,[Vector2(1329,322),Vector2(1351,330),Vector2(1357,341),Vector2(1330,338)]]]
 for i in range(shapes.size()):
  var flag=load("res://lobbies/wei/flag_cloth.gd").new()
  flag.texture=tex
  flag.hanging=shapes[i][0]
  flag.native_cloth=i==1 or i==2
  flag.outline=PackedVector2Array(shapes[i][1])
  flag.phase=float(i)*1.4
  add_child(flag)

func _add_near_horses()->void:
 for i in range(2):
  var horse=load("res://lobbies/wei/horse_frames.gd").new()
  horse.position=Vector2(915 if i==0 else 1100,380)
  horse.offset=float(i)*3.1
  horse.z_index=2
  horse.modulate=Color.WHITE if i==0 else Color(.90,.90,.91)
  add_child(horse)
 var rail=load("res://lobbies/wei/near_rail.gd").new()
 rail.z_index=3
 add_child(rail)

func _open_buildings()->void:
 if is_instance_valid(building_layer):return
 building_layer=Node2D.new();building_layer.z_index=60;building_layer.name="BuildingsLayer";add_child(building_layer)
 var page=load("res://lobbies/wei/buildings/buildings_page.gd").new();page.name="BuildingsPage"
 page.closed.connect(func():
  building_layer.queue_free()
  building_layer=null
 )
 building_layer.add_child(page)


func close_buildings() -> bool:
 if not is_instance_valid(building_layer):
  return false
 building_layer.get_child(0).closed.emit()
 return true
