extends Node2D
var clock:=0.0
var atlas:Texture2D
var leaves:Array[AtlasTexture]=[]
func _ready()->void:
 atlas=load("res://lobbies/shu/bamboo_leaves.png")
 for i in range(4):
  var leaf:=AtlasTexture.new()
  leaf.atlas=atlas
  leaf.region=Rect2(float(i)*atlas.get_width()/4,0,atlas.get_width()/4.0,atlas.get_height())
  leaves.append(leaf)
func _process(delta:float)->void:
 clock+=delta
 queue_redraw()
func _draw()->void:
 if leaves.is_empty():return
 for i in range(18):
  var t:=fposmod(clock*.041+float(i)*.0617,1.0)
  var start:=float(i%6)*215.0-50
  var p:=Vector2(start+t*360+sin(clock*.7+i)*20,-80+t*890)
  var angle:=.5+sin(clock*1.1+i)*.7+t*2
  var size:=Vector2(84,43)*(0.73+float(i%3)*.15)
  var alpha:=smoothstep(0.,.09,t)*(1.-smoothstep(.82,1.,t))*.9
  draw_set_transform(p,angle,Vector2(1,.65+abs(sin(clock*.9+i))*.35))
  draw_texture_rect(leaves[i%4],Rect2(-size/2,size),false,Color(1,1,1,alpha))
 draw_set_transform(Vector2.ZERO)
