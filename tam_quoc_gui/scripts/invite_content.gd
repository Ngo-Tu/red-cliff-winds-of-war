extends Control
var font:Font
func _ready()->void:
 mouse_filter=Control.MOUSE_FILTER_IGNORE
func _draw()->void:
 if font==null:return
 var fs:=23
 var text_width:=font.get_string_size("Mời bạn",HORIZONTAL_ALIGNMENT_LEFT,-1,fs).x
 var left:float=(size.x-36.0-14.0-text_width)*0.5
 var center:=Vector2(left+18,size.y*0.5)
 draw_circle(center,18,Color("16364a"))
 draw_arc(center+Vector2(0,1),17,0,TAU,64,Color("081823"),2.0,true)
 draw_arc(center,17,0,TAU,64,Color("b6d5e0"),1.5,true)
 draw_line(center-Vector2(8,0),center+Vector2(8,0),Color("e8f1ee"),2.5,true)
 draw_line(center-Vector2(0,8),center+Vector2(0,8),Color("e8f1ee"),2.5,true)
 var baseline:float=(size.y-font.get_height(fs))*0.5+font.get_ascent(fs)-1
 draw_string(font,Vector2(left+50,baseline),"Mời bạn",HORIZONTAL_ALIGNMENT_LEFT,-1,fs,Color("e8f1ee"))
