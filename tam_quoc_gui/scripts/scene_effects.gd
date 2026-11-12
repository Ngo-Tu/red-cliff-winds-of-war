extends Node2D
## All coordinates use the 1600x900 design canvas. Decorative layers never intercept clicks.
const ORIGINAL=preload("res://assets/character_bg_original.png")
var scene_name:="login"
var clock:=0.0
var enabled:=true
var lantern: Node2D
var lamp_light: Node2D
var smoke: ColorRect
var smoke_material: ShaderMaterial

func _ready() -> void:
 name="SceneEffects"
 _create_lantern()
 smoke=ColorRect.new()
 smoke.name="DiffusingIncenseSmoke"
 smoke.position=Vector2(90,335)
 smoke.size=Vector2(170,230)
 smoke.mouse_filter=Control.MOUSE_FILTER_IGNORE
 smoke_material=ShaderMaterial.new()
 smoke_material.shader=preload("res://scripts/incense_smoke.gdshader")
 smoke.material=smoke_material
 add_child(smoke)

func _create_lantern() -> void:
 lantern=Node2D.new()
 lantern.name="LanternPivot"
 var s:=1600.0/1672.0
 # Hinge at the tip of the wooden bracket; exact original lamp pixels below it.
 var pivot:=Vector2(153,79)
 lantern.position=pivot*s
 add_child(lantern)
 var poly:=Polygon2D.new()
 poly.texture=ORIGINAL
 var outline:=PackedVector2Array([
  Vector2(148,82),Vector2(158,82),Vector2(158,133),Vector2(178,140),
  Vector2(191,150),Vector2(198,159),Vector2(195,168),Vector2(192,257),
  Vector2(199,275),Vector2(190,282),Vector2(176,293),Vector2(163,301),
  Vector2(161,316),Vector2(165,328),Vector2(162,343),Vector2(169,409),
  Vector2(161,416),Vector2(145,415),Vector2(141,410),Vector2(149,342),
  Vector2(145,329),Vector2(150,315),Vector2(147,301),Vector2(130,291),
  Vector2(115,280),Vector2(108,274),Vector2(115,255),Vector2(113,164),
  Vector2(111,152),Vector2(125,143),Vector2(147,134)])
 var points:=PackedVector2Array()
 for v in outline: points.append((v-pivot)*s)
 poly.polygon=points
 poly.uv=outline
 poly.visible=false
 lantern.add_child(poly)
 lantern.visible=false

func set_scene(value: String) -> void:
 scene_name=value
 lantern.visible=value=="character"
 smoke.visible=value=="login"
 queue_redraw()

func advance(delta: float, running: bool) -> void:
 enabled=running
 if running: clock+=delta
 if smoke_material: smoke_material.set_shader_parameter("motion_time",clock)
 if lantern:
  lantern.rotation=sin(clock*0.92)*0.024+sin(clock*1.7)*0.003
 queue_redraw()

func _draw() -> void:
 if scene_name=="character":
  _falling_leaves()

func _lantern_glow() -> void:
 var center:=lantern.position+Vector2(-3,127).rotated(lantern.rotation)
 for ring in range(9,0,-1):
  var a:=(0.005+0.0015*sin(clock*2.4))*float(10-ring)/9.0
  draw_circle(center,12.0+float(ring)*7.0,Color(1.0,0.66,0.24,a))

func _falling_leaves() -> void:
 for i in range(13):
  var index:=float(i)
  var duration:=8.0+fmod(index*1.37,4.0)
  var age:=fposmod(clock+index*1.83,duration)/duration
  var origin:=Vector2(190.0+fmod(index*29.7,135.0),82.0+fmod(index*41.0,170.0))
  var p:=origin+Vector2(age*(160.0+fmod(index*31.,130.0))+sin(age*13.+index)*24.0,age*640.0)
  var angle:=age*5.0+index+sin(clock*1.3+index)*0.65
  var len:=5.0+fmod(index*1.9,5.0)
  var width:=2.6+fmod(index,2.0)
  var flip:=0.45+absf(sin(clock*1.6+index))*0.55
  var color:=Color("86714b") if i%3==0 else (Color("6e7652") if i%3==1 else Color("9b8052"))
  color.a=smoothstep(0.0,0.06,age)*(1.0-smoothstep(0.88,1.0,age))*0.85
  var vertices:=PackedVector2Array()
  for v in [Vector2(-len,0),Vector2(-len*.15,-width*flip),Vector2(len,0),Vector2(-len*.15,width*flip)]:
   vertices.append(p+v.rotated(angle))
  draw_colored_polygon(vertices,color)
  draw_line(p+Vector2(-len*.75,0).rotated(angle),p+Vector2(len*.8,0).rotated(angle),Color(0.75,0.66,0.43,color.a*0.65),0.6,true)
