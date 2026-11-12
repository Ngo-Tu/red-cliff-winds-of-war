extends CanvasLayer
## Software-rendered themed pointer so the same cursor is visible in Godot movie capture.
const ARROW=preload("res://assets/cursor/common_arrow_3d.png")
const TEXT=preload("res://assets/cursor/common_text.svg")
const SURFACE=preload("res://scripts/cursor_surface.gdshader")
class ClickInk extends Control:
 var point:=Vector2.ZERO
 var age:=10.0
 func _draw()->void:
  if age>0.4:return
  var t:=age/0.4
  draw_arc(point,4+t*15,0,TAU,40,Color(0.82,0.72,0.52,(1-t)*0.30),1.0,true)
var sprite:TextureRect
var surface:ShaderMaterial
var arrow_hotspot:=Vector2.ZERO
var hover_mix:=0.0
var press_mix:=0.0
var ink:ClickInk
var point:=Vector2(800,450)
var focused:=true
var pressed:=false
var interactive:=false
var text_mode:=false
func _ready()->void:
 name="SharedNeutralCursor"
 layer=100
 ink=ClickInk.new()
 ink.mouse_filter=Control.MOUSE_FILTER_IGNORE
 ink.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
 add_child(ink)
 sprite=TextureRect.new()
 sprite.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
 sprite.texture=ARROW
 sprite.size=Vector2(56,56)
 sprite.mouse_filter=Control.MOUSE_FILTER_IGNORE
 surface=ShaderMaterial.new()
 surface.shader=SURFACE
 sprite.material=surface
 add_child(sprite)
 var config=JSON.parse_string(FileAccess.get_file_as_string("res://assets/cursor/common_arrow_3d.json"))
 assert(config is Dictionary and config.has("hotspot_uv"))
 arrow_hotspot=Vector2(float(config.hotspot_uv[0]),float(config.hotspot_uv[1]))*sprite.size
 point=get_viewport().get_mouse_position()
 if DisplayServer.get_name()!="headless":Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
func _notification(what:int)->void:
 if what==NOTIFICATION_WM_WINDOW_FOCUS_OUT:
  focused=false
  Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
 elif what==NOTIFICATION_WM_WINDOW_FOCUS_IN:
  focused=true
  if DisplayServer.get_name()!="headless":Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
func _exit_tree()->void:
 Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func move_to(value:Vector2)->void:
 point=value
func _input(event:InputEvent)->void:
 if event is InputEventMouseMotion:point=event.position
 if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
  pressed=event.pressed
  point=event.position
  if pressed:
   ink.point=point
   ink.age=0.0
func _process(delta:float)->void:
 ink.age+=delta
 ink.queue_redraw()
 interactive=false
 text_mode=false
 var hit:=get_viewport().gui_get_hovered_control()
 while hit:
  if hit is LineEdit:
   text_mode=true
   break
  if hit is BaseButton:
   interactive=not hit.disabled
   break
  hit=hit.get_parent() as Control
 hover_mix=lerpf(hover_mix,1.0 if interactive else 0.0,1.0-exp(-delta*15.0))
 press_mix=lerpf(press_mix,1.0 if pressed else 0.0,1.0-exp(-delta*25.0))
 surface.set_shader_parameter("hover_amount",hover_mix)
 surface.set_shader_parameter("press_amount",press_mix)
 var texture:Texture2D=TEXT if text_mode else ARROW
 sprite.texture=texture
 var hotspot:=sprite.size*0.5 if text_mode else arrow_hotspot
 sprite.position=point-hotspot
 sprite.visible=focused and get_viewport().get_visible_rect().has_point(point)
