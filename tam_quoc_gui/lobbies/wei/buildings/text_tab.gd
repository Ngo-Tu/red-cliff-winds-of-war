extends Button
var active:=false
var caption:=""
var font:Font
var hovered:=false
func _ready()->void:
 font=load("res://lobbies/wei/Trirong-Regular.ttf")
 mouse_default_cursor_shape=Control.CURSOR_POINTING_HAND
 for state in ["normal","hover","pressed","focus"]:add_theme_stylebox_override(state,StyleBoxEmpty.new())
 mouse_entered.connect(func():hovered=true;queue_redraw())
 mouse_exited.connect(func():hovered=false;queue_redraw())
func _draw()->void:
 if font==null:return
 var fs:=26
 var extent:=font.get_string_size(caption,HORIZONTAL_ALIGNMENT_LEFT,-1,fs)
 var color:=Color("f7f0dd") if active or hovered else Color("d8d9d0")
 draw_string(font,Vector2((size.x-extent.x)/2,32),caption,HORIZONTAL_ALIGNMENT_LEFT,-1,fs,color)
 draw_line(Vector2(7,size.y-2),Vector2(size.x-7,size.y-2),Color(.65,.73,.76,.28),1,true)
 if active:
  draw_line(Vector2(12,size.y-2),Vector2(size.x-12,size.y-2),Color(.25,.85,.96,.10),10,true)
  draw_line(Vector2(12,size.y-2),Vector2(size.x-12,size.y-2),Color(.35,.89,.98,.25),5,true)
  draw_line(Vector2(12,size.y-2),Vector2(size.x-12,size.y-2),Color("a0f1f4"),2,true)
 elif hovered:draw_line(Vector2(18,size.y-2),Vector2(size.x-18,size.y-2),Color("a7bec6"),1.5,true)
