extends Node2D
var clock:=0.0
var red:=false
var atlas:Texture2D
var regions:Array[Rect2]=[Rect2(200,20,480,492),Rect2(884,25,495,487),Rect2(158,512,537,470),Rect2(839,512,537,480)]
func _ready()->void:
 atlas=load("res://lobbies/wei/leaf_atlas.png")
func _process(delta:float)->void:
 clock+=delta
 queue_redraw()
func _draw()->void:
 if atlas==null:return
 for i in range(20):
  var onset:=float(i/2)*5.0+(2.2 if i%2 else 0.0)
  var age:=fposmod(clock-onset,50.0)
  var travel:=age*17.6
  var pos:=Vector2(-160+fposmod(i*397.0,1370)+travel*tan(PI/6)+sin(clock*.55+i)*6,-38+travel)
  if (pos.x<390 and pos.y<135) or (pos.x>1150 and pos.y<85):continue
  if pos.y>713 or pos.x<145 or (pos.x>1450 and pos.y<500):continue
  var alpha:=smoothstep(0,65,travel)*(1-smoothstep(690,800,travel))*.95
  var length:=34.0+float(i%3)*5.0 if red else 30.0+float(i%3)*4.0
  var idx:=2+i%2 if red else i%2
  var region:Rect2=regions[idx]
  var sz:=Vector2(length*region.size.x/region.size.y,length)
  draw_set_transform(pos,sin(clock*.55+i)*.8+float(i),Vector2(.5+absf(sin(clock*.65+i))*.5,1))
  draw_texture_rect_region(atlas,Rect2(-sz*.5,sz),region,Color(1,1,1,alpha))
 draw_set_transform(Vector2.ZERO)
