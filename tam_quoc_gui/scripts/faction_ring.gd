extends Control
var active:=false
var hovered:=false
var accent:=Color("77cfff")
var clock:=0.0
var burst:=0.0
func _ready() -> void:
 mouse_filter=Control.MOUSE_FILTER_IGNORE
func set_active(value: bool) -> void:
 if value and not active:burst=1.0
 active=value
 queue_redraw()
func _process(delta: float) -> void:
 clock+=delta
 burst=maxf(0.0,burst-delta*0.85)
 if active or hovered:queue_redraw()
func _shape(r: Rect2) -> PackedVector2Array:
 var a:=r.position
 var b:=r.end
 return PackedVector2Array([a+Vector2(15,0),Vector2(b.x-15,a.y),Vector2(b.x,a.y+15),b-Vector2(0,15),b-Vector2(15,0),Vector2(a.x+15,b.y),Vector2(a.x,b.y-15),a+Vector2(0,15),a+Vector2(15,0)])
func _along(points: PackedVector2Array,t: float) -> Vector2:
 var total:=0.0
 for i in range(points.size()-1):total+=points[i].distance_to(points[i+1])
 var distance:=fposmod(t,1.0)*total
 for i in range(points.size()-1):
  var length:=points[i].distance_to(points[i+1])
  if distance<=length:return points[i].lerp(points[i+1],distance/length)
  distance-=length
 return points[0]
func _draw() -> void:
 if not active and not hovered:return
 var points:=_shape(Rect2(Vector2(1,1),size-Vector2(2,2)))
 if not active:
  draw_polyline(points,Color(accent,0.48),2.0,true)
  return
 var pulse:=0.84+sin(clock*2.7)*0.16
 # Layered soft halo, luminous core and orbiting light points.
 for i in range(8,0,-1):
  draw_polyline(points,Color(accent,0.020*pulse),float(i)*3.2,true)
 draw_polyline(points,Color(accent,0.90),3.4,true)
 draw_polyline(points,Color(0.93,1.0,0.96,0.90),1.1,true)
 for i in range(5):
  var p:=_along(points,clock*0.085+float(i)*0.20)
  for j in range(5,0,-1):draw_circle(p,float(j)*2.2,Color(accent,0.035*float(6-j)))
  draw_circle(p,2.0,Color(1,1,1,0.95))
  draw_line(p-Vector2(7,0),p+Vector2(7,0),Color(accent,0.6),1.0,true)
  draw_line(p-Vector2(0,7),p+Vector2(0,7),Color(accent,0.6),1.0,true)
 if burst>0.0:
  var expansion:=(1.0-burst)*36.0
  draw_polyline(_shape(Rect2(Vector2.ZERO,size).grow(expansion)),Color(accent,burst*0.5),2.2,true)
  for i in range(18):
   var start:=_along(points,float(i)/18.0)
   var direction:=(start-size*0.5).normalized()
   var p:=start+direction*expansion
   draw_circle(p,1.5+burst,Color(accent,burst*0.70))
 var center:=Vector2(size.x-40,40)
 for j in range(5,0,-1):draw_circle(center,17.0+float(j)*3.0,Color(accent,0.045))
 draw_circle(center,17,Color("20272a"))
 draw_arc(center,17,0,TAU,40,accent,2.2,true)
 draw_polyline(PackedVector2Array([center+Vector2(-8,0),center+Vector2(-2,6),center+Vector2(9,-7)]),Color(0.95,1,0.97),3.0,true)
