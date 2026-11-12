extends Node2D
var clock:=0.0
var fish_textures:Array[Texture2D]=[]
func _ready()->void:
 _load_fish()
func _process(delta:float)->void:
 clock+=delta
 queue_redraw()
func _draw()->void:
 if not fish_textures.is_empty():_draw_fish()
func _event_age()->float:
 var cycle:=fposmod(clock,34.5)
 var last:=-100.0
 for onset in [7.4,16.7,24.9,34.5]:
  if cycle>=onset:last=onset
 return cycle-last
func _draw_fish()->void:
 var batch_age:=_event_age()
 # Five offset jumps per event; overlapping flights without simultaneous identical motion.
 for i in range(5):
  var age:=batch_age-float(i)*.24
  var duration:=1.25+float(i%3)*.13
  var origin:=Vector2(1248+float(i)*28,477+float(i%2)*8)
  var direction:float=1.0 if i==0 else -1.0
  var distance:float=36+float(i%3)*11
  var height:float=32+float(i%3)*13
  var length:float=35+float(i%3)*7
  if age>=0 and age<duration:
   var t:=age/duration
   var p:=origin+Vector2(direction*t*distance,-sin(t*PI)*height)
   var tangent:=Vector2(direction*distance,-cos(t*PI)*height*PI)
   var angle:=tangent.angle()
   draw_set_transform(p,angle)
   var art:Texture2D=fish_textures[i%fish_textures.size()]
   var fish_size:=Vector2(length,length*art.get_height()/art.get_width())
   draw_texture_rect(art,Rect2(-fish_size*.5,fish_size),false)
   draw_set_transform(Vector2.ZERO)
  for entry in [0,1]:
   var splash_time:float=0.0 if entry==0 else duration
   var a:float=age-splash_time
   if a>=0 and a<1.4:
    var center:=origin+Vector2(direction*distance if entry==1 else 0,0)
    draw_set_transform(center,0,Vector2(1,.30))
    draw_arc(Vector2.ZERO,4+a*17,0,TAU,40,Color(.79,.89,.88,(1-a/1.4)*.60),1,true)
    draw_set_transform(Vector2.ZERO)
    for drop in range(14):
     var v:=Vector2((float(drop)-6.5)*5*a,-sin(a/1.4*PI)*(11+drop%4*5))
     draw_circle(center+v,1.1+float(drop%3)*.4,Color(.84,.94,.94,(1-a/1.4)*.9))

func _load_fish()->void:
 var sheet:Texture2D=load("res://lobbies/wu/fish_atlas.png")
 for region in [Rect2(38,116,686,282),Rect2(814,118,678,274),Rect2(32,628,692,298),Rect2(799,633,694,284)]:
  var tex:=AtlasTexture.new()
  tex.atlas=sheet
  tex.region=region
  fish_textures.append(tex)
