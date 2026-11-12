extends Button
const SlateFrame=preload("res://scripts/wei_panel.gd")
var face:Control
var contents:Control
var selected:=false
var hover_mix:=0.0
var press_mix:=0.0
var selection_mix:=0.0
var effect_time:=0.0
var click_age:=10.0
func _ready()->void:
 mouse_default_cursor_shape=Control.CURSOR_POINTING_HAND
 for state in ["normal","hover","pressed","focus","disabled"]:add_theme_stylebox_override(state,StyleBoxEmpty.new())
 face=SlateFrame.new()
 face.size=size
 add_child(face)
 move_child(face,0)
 contents=Control.new()
 contents.size=size
 contents.mouse_filter=Control.MOUSE_FILTER_IGNORE
 add_child(contents)
 resized.connect(func():face.size=size;contents.size=size)
 button_down.connect(func():
  click_age=0.0
  face.click_position=Vector2(clampf(get_local_mouse_position().x,15,size.x-15),clampf(get_local_mouse_position().y,15,size.y-15))
 )
func _process(delta:float)->void:
 if not is_visible_in_tree():return
 effect_time+=delta
 click_age+=delta
 var was_hover:=hover_mix
 var was_press:=press_mix
 var was_selection:=selection_mix
 var h:=1.0 if is_hovered() and not disabled else 0.0
 var p:=1.0 if button_pressed else 0.0
 var ease:=1.0-exp(-delta*14.0)
 hover_mix=lerpf(hover_mix,h,ease)
 press_mix=lerpf(press_mix,p,1.0-exp(-delta*24.0))
 selection_mix=lerpf(selection_mix,1.0 if selected else 0.0,ease)
 face.hovered=h>0.5
 face.pressed=button_pressed
 face.hover_strength=hover_mix
 face.press_strength=press_mix
 face.selection_strength=selection_mix
 face.clock=effect_time
 face.click_age=click_age
 contents.position.y=-1.2*hover_mix+2.5*press_mix
 contents.modulate=Color.WHITE.lerp(Color(1.06,1.10,1.13),hover_mix*0.7)
 if h>0 or selected or click_age<0.5 or absf(was_hover-hover_mix)>0.001 or absf(was_press-press_mix)>0.001 or absf(was_selection-selection_mix)>0.001:face.queue_redraw()
func set_selected(value:bool)->void:
 selected=value
 face.active=value
 face.queue_redraw()
