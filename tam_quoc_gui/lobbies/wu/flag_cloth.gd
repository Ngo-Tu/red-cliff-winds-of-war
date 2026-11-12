extends Node2D
## Only the isolated fabric polygon deforms; the background and its poles never move.
var texture:Texture2D
var outline:=PackedVector2Array()
var hanging:=true
var phase:=0.0
var clock:=0.0
var bounds:=Rect2()
var pieces:Array[PackedVector2Array]=[]
func _ready()->void:
 bounds=Rect2(outline[0],Vector2.ZERO)
 for v in outline:bounds=bounds.expand(v)
 for row in range(14):
  for col in range(8):
   var a:=bounds.position+bounds.size*Vector2(float(col)/8,float(row)/14)
   var b:=bounds.position+bounds.size*Vector2(float(col+1)/8,float(row+1)/14)
   var quad:=PackedVector2Array([a,Vector2(b.x,a.y),b,Vector2(a.x,b.y)])
   for part in Geometry2D.intersect_polygons(quad,outline):
    for k in range(1,part.size()-1):
     var tri:=PackedVector2Array([part[0],part[k],part[k+1]])
     if absf((tri[1]-tri[0]).cross(tri[2]-tri[0]))>.02:pieces.append(tri)
func _process(delta:float)->void:
 clock+=delta
 queue_redraw()
func _draw()->void:
 if texture==null:return
 for piece in pieces:
  var vertices:=PackedVector2Array()
  var uv:=PackedVector2Array()
  var colors:=PackedColorArray()
  for p in piece:
   var q:Vector2=(p-bounds.position)/bounds.size
   var weight:float=q.y*q.y if hanging else q.x*q.x
   var amplitude:=1.5 if hanging else 2.4
   var offset:=Vector2(sin(q.y*7-clock*1.7+phase)*amplitude*weight,sin(q.x*6-clock*2+phase)*.6*weight)
   if not hanging:offset=Vector2(sin(q.x*7-clock*2+phase)*.5*weight,sin(q.x*7-clock*2+phase)*amplitude*weight)
   vertices.append(p+offset)
   uv.append(p/Vector2(texture.get_size()))
   var shade:=1.0+sin(q.y*8-clock*1.7+phase)*.035*weight
   colors.append(Color(shade,shade,shade,1))
  if absf((vertices[1]-vertices[0]).cross(vertices[2]-vertices[0]))>.01:
   draw_primitive(vertices,colors,uv,texture)
