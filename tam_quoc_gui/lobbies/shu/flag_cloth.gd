extends Node2D
## Only the isolated fabric polygon deforms; the background and its poles never move.
var texture:Texture2D
var outline:=PackedVector2Array()
var hanging:=true
var native_cloth:=false
var phase:=0.0
var clock:=0.0
var bounds:=Rect2()
var clean:Texture2D
var pieces:Array[PackedVector2Array]=[]
func _ready()->void:
 clean=load("res://lobbies/shu/flags_clean.png")
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
 if clean!=null:
  for patch in Geometry2D.offset_polygon(outline,12.0 if bounds.size.y>60 else 4.0):
   var patch_uv:=PackedVector2Array()
   for v in patch:patch_uv.append(v/Vector2(1672,941))
   draw_polygon(patch,PackedColorArray([Color.WHITE]),patch_uv,clean)
 for piece in pieces:
  var vertices:=PackedVector2Array()
  var uv:=PackedVector2Array()
  var colors:=PackedColorArray()
  for p in piece:
   var q:Vector2=(p-bounds.position)/bounds.size
   var weight:float=pow(q.y,1.25) if hanging else pow(q.x,1.25)
   var amplitude:=minf(8.0,bounds.size.x*.22)
   var offset:=Vector2(sin(q.y*5.5-clock*2.5+phase)*amplitude*weight,sin(q.y*6-clock*2.5+phase)*2.0*weight)
   if not hanging:offset=Vector2(sin(q.x*6-clock*2.7+phase)*1.4*weight,sin(q.x*6-clock*2.7+phase)*4.0*weight)
   vertices.append(p+offset)
   uv.append(p/Vector2(texture.get_size()))
   var shade:=1.0+sin(q.y*8-clock*1.7+phase)*.17*weight
   if native_cloth:
    var base:=Color("1b3158").lerp(Color("30496c"),q.x*.35)
    var fold:=1.0+sin(q.x*PI*4+clock*.8)*.055+sin(q.y*18+q.x*4)*.025
    colors.append(Color(base.r*shade*fold,base.g*shade*fold,base.b*shade*fold,1))
   else:colors.append(Color(shade,shade,shade,1))
  if absf((vertices[1]-vertices[0]).cross(vertices[2]-vertices[0]))>.01:
   if native_cloth:draw_primitive(vertices,colors,PackedVector2Array())
   else:draw_primitive(vertices,colors,uv,texture)

 if native_cloth:
  var border:=outline.duplicate()
  border.append(outline[0])
  draw_polyline(border,Color("c1a66c"),2.2,true)
  var inner:=PackedVector2Array()
  var center:=bounds.get_center()
  for v in outline:inner.append(center+(v-center)*Vector2(.82,.91))
  inner.append(inner[0])
  draw_polyline(inner,Color("d3bd88"),.8,true)
