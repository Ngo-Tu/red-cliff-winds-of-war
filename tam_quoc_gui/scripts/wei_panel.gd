extends Control
## Wei slate + beveled silver. Ornament geometry follows the approved reference.
const SLATE=preload("res://assets/lobby/navy_slate.png")
var active:=false
var hovered:=false
var hover_strength:=0.0
var press_strength:=0.0
var selection_strength:=0.0
var click_position:=Vector2.ZERO
var click_age:=10.0
var pressed:=false
var ornament:=true
var clock:=0.0
var bevel:=12.0
var skin:="panel"
var stone_tint:=Color(1.44,1.07,1.086)
func _ready()->void:
 mouse_filter=Control.MOUSE_FILTER_IGNORE
 texture_repeat=CanvasItem.TEXTURE_REPEAT_ENABLED
 resized.connect(queue_redraw)
func _outline(inset:float)->PackedVector2Array:
 var w:=size.x-inset
 var h:=size.y-inset
 var c:=minf(bevel,minf(w,h)*0.2)
 if skin=="circle":
  var points:=PackedVector2Array()
  for i in range(64):
   var a:=TAU*i/64.0
   points.append(size*0.5+Vector2(cos(a),sin(a))*(minf(size.x,size.y)*0.5-inset))
  return points
 if skin=="action":
  var center:=Vector2(size.x*0.5,41)
  return PackedVector2Array([center+Vector2(0,-40+inset),center+Vector2(53-inset,10),center+Vector2(0,46-inset),center+Vector2(-53+inset,10)])
 if skin=="name" or skin=="rank":
  return PackedVector2Array([Vector2(inset,inset),Vector2(w,inset),Vector2(w-24,h),Vector2(inset,h)])
 if skin=="counter" or skin=="mode":c=13.0
 if skin=="primary":c=28.0
 return PackedVector2Array([Vector2(inset+c,inset),Vector2(w-c,inset),Vector2(w,inset+c),Vector2(w,h-c),Vector2(w-c,h),Vector2(inset+c,h),Vector2(inset,h-c),Vector2(inset,inset+c)])
func _closed(p:PackedVector2Array)->PackedVector2Array:
 var result:=p.duplicate()
 result.append(p[0])
 return result
func _ring(outside:float,inside:float,light:Color,dark:Color)->void:
 var outer:=_outline(outside)
 var inner:=_outline(inside)
 for i in range(outer.size()):
  var j:=(i+1)%outer.size()
  var tangent:=(outer[j]-outer[i]).normalized()
  var normal:=Vector2(tangent.y,-tangent.x)
  var illumination:=clampf(normal.dot(Vector2(-0.4,-0.9).normalized())*0.5+0.5,0,1)
  var face:=dark.lerp(light,illumination)
  var quad:=PackedVector2Array([outer[i],outer[j],inner[j],inner[i]])
  draw_polygon(quad,PackedColorArray([face,face,face.darkened(0.17),face.darkened(0.17)]))
func _metal(p:PackedVector2Array)->void:
 # Fine cast shadow + directional silver gradient + dark bevel, never a flat white blade.
 var shadow:=PackedVector2Array()
 for v in p:shadow.append(v+Vector2(0.7,1.5))
 draw_colored_polygon(shadow,Color(0.015,0.035,0.05,0.95))
 var top:=INF
 var bottom:=-INF
 for v in p:
  top=minf(top,v.y)
  bottom=maxf(bottom,v.y)
 var colors:=PackedColorArray()
 for v in p:colors.append(Color("d2d7df").lerp(Color("7d899d"),clampf((v.y-top)/maxf(bottom-top,1.0),0,1)))
 draw_polygon(p,colors)
 draw_polyline(_closed(p),Color("172534"),0.85,true)
 if p.size()>1:draw_line(p[0],p[1],Color("eef1f4"),0.95,true)
 if p.size()>2:draw_line(p[1],p[2],Color("b9c2cd"),0.65,true)
func _mapped(points:Array,origin:Vector2,scale:Vector2)->PackedVector2Array:
 var result:=PackedVector2Array()
 for v in points:result.append(origin+v*scale)
 return result
func _feather(origin:Vector2,scale:Vector2)->void:
 # One bent outer ribbon and TWO inset feathers separated by dark grooves.
 _metal(_mapped([Vector2(0,63),Vector2(37,75),Vector2(75,122),Vector2(34,84),Vector2(11,79)],origin,scale))
 _metal(_mapped([Vector2(13,84),Vector2(34,90),Vector2(46,102),Vector2(23,97)],origin,scale))
 _metal(_mapped([Vector2(24,100),Vector2(48,106),Vector2(58,116),Vector2(36,112)],origin,scale))
func _corner(origin:Vector2,scale:Vector2)->void:
 _metal(_mapped([Vector2(6,17),Vector2(16,6),Vector2(29,6),Vector2(22,14),Vector2(13,14),Vector2(6,23)],origin,scale))
 _metal(_mapped([Vector2(16,25),Vector2(33,6),Vector2(45,6),Vector2(26,25)],origin,scale))
 _metal(_mapped([Vector2(6,27),Vector2(15,17),Vector2(24,17),Vector2(6,36)],origin,scale))
func _glow_segment(a:Vector2,b:Vector2,strength:float)->void:
 # Tapered cyan bloom and an ivory core, concentrated in the centre like the base.
 for i in range(32):
  var t:=(i+0.5)/32.0
  var bloom:=exp(-pow((t-0.5)/0.29,2.0))*strength
  var start:=a.lerp(b,float(i)/32.0)
  var end:=a.lerp(b,float(i+1)/32.0)
  draw_line(start,end,Color(0.12,0.58,1.0,0.065*bloom),18,true)
  draw_line(start,end,Color(0.22,0.77,1.0,0.20*bloom),9,true)
  draw_line(start,end,Color(0.37,0.88,1.0,0.35*bloom),4,true)
  draw_line(start,end,Color(0.76,0.98,1.0,0.95*bloom),1.25,true)
func _sweep(p:PackedVector2Array,amount:float)->void:
 if amount<0.01:return
 var x:=fmod(clock*size.x*0.36,size.x+size.y+80)-size.y-40
 for i in range(7):
  var band_x:=x+i*5.0
  var band:=PackedVector2Array([Vector2(band_x,0),Vector2(band_x+6,0),Vector2(band_x+size.y+6,size.y),Vector2(band_x+size.y,size.y)])
  var clipped:=Geometry2D.intersect_polygons(p,band)
  for part in clipped:draw_colored_polygon(part,Color(0.66,0.90,1.0,0.045*amount*(1.0-absf(i-3)/4.0)))
func _choice_plain()->void:
 var strength:=maxf(hover_strength*0.6,selection_strength)
 if strength<0.005:return
 if skin=="portrait_hit":
  draw_arc(size*0.5,minf(size.x,size.y)*0.48,0,TAU,64,Color(0.5,0.87,1.0,strength*0.8),1.7,true)
  return
 var corners:=PackedVector2Array([Vector2(4,4),Vector2(size.x-4,4),size-Vector2(4,4),Vector2(4,size.y-4)])
 draw_polygon(corners,PackedColorArray([Color(0.1,0.3,0.5,strength*0.025),Color(0.1,0.3,0.5,strength*0.025),Color(0.14,0.58,0.84,strength*0.19),Color(0.14,0.58,0.84,strength*0.19)]))
 _sweep(corners,hover_strength)
 _glow_segment(Vector2(10,size.y-3),Vector2(size.x-10,size.y-3),strength*0.8)
 if selection_strength>0.01:
  var center:=Vector2(size.x*0.5,size.y-6)
  draw_colored_polygon(PackedVector2Array([center+Vector2(0,-4),center+Vector2(4,0),center+Vector2(0,4),center+Vector2(-4,0)]),Color(0.8,0.96,1.0,selection_strength))
func _state_light()->void:
 var strength:=maxf(hover_strength*0.72,selection_strength)
 if strength>0.01 and skin!="primary":
  var p:=_outline(1.4)
  draw_polyline(_closed(p),Color(0.2,0.7,1.0,strength*0.06),10,true)
  draw_polyline(_closed(p),Color(0.35,0.82,1.0,strength*0.2),4,true)
  draw_polyline(_closed(p),Color(0.7,0.96,1.0,strength*0.8),1,true)
 if selection_strength>0.01 and skin in ["action","mode"]:
  var y:=76.0 if skin=="action" else size.y-7
  var c:=Vector2(size.x*0.5,y)
  draw_colored_polygon(PackedVector2Array([c+Vector2(0,-3),c+Vector2(3,0),c+Vector2(0,3),c+Vector2(-3,0)]),Color(0.8,0.97,1,selection_strength))
 if click_age<0.45:
  var t:=click_age/0.45
  draw_arc(click_position,3+20*t,0,TAU,40,Color(0.6,0.9,1,(1-t)*0.55),1.2,true)
func _draw()->void:
 if skin in ["plain","portrait_hit"]:
  _choice_plain()
  return
 var offset:=2.5*press_strength-0.8*hover_strength
 var p:=_outline(0)
 draw_set_transform(Vector2(0,offset+3))
 draw_colored_polygon(p,Color(0.01,0.02,0.03,0.65))
 draw_set_transform(Vector2(0,offset))
 var tint:=stone_tint
 if skin=="primary":tint=Color(1.13,1.34,1.41)
 elif skin=="action" or skin=="counter" or skin=="rank":tint=Color(0.88,0.93,0.99)
 tint=tint.lightened(0.035*hover_strength)
 var uv:=PackedVector2Array()
 for v in p:uv.append(v/Vector2(SLATE.get_size()))
 draw_polygon(p,PackedColorArray([tint]),uv,SLATE)
 if press_strength>0.001:draw_colored_polygon(p,Color(0.01,0.025,0.035,0.28*press_strength))
 _sweep(_outline(8),hover_strength)
 # Layered moulding reproduces bright outer edge / recessed dark groove / inner silver lip.
 var thin:=skin in ["action","name","rank","counter","circle","mode","invite"]
 var factor:=0.35 if skin in ["name","rank"] else (0.67 if thin else 1.0)
 _ring(0,1.0*factor,Color("273543"),Color("08121c"))
 _ring(1.0*factor,2.0*factor,Color("eef1f3"),Color("9aa5b2"))
 _ring(2.0*factor,5.0*factor,Color("c0c7d1"),Color("596576"))
 _ring(5.0*factor,6.3*factor,Color("324151"),Color("131f2c"))
 _ring(6.3*factor,7.7*factor,Color("c2cad5"),Color("7b8797"))
 _ring(7.7*factor,8.5*factor,Color("132635"),Color("07131e"))
 if skin=="action":
  draw_colored_polygon(PackedVector2Array([Vector2(20,78),Vector2(size.x-20,78),Vector2(size.x-25,size.y),Vector2(25,size.y)]),Color(0.06,0.10,0.14,0.9))
  _feather(Vector2(0,16),Vector2(0.5,0.5))
  _feather(Vector2(size.x,16),Vector2(-0.5,0.5))
 elif skin=="primary":
  _feather(Vector2.ZERO,Vector2.ONE)
  _feather(Vector2(size.x,0),Vector2(-1,1))
  var shimmer:=1.0+sin(clock*1.6)*0.06+hover_strength*0.55+selection_strength*0.2
  _glow_segment(Vector2(75,5),Vector2(size.x-75,5),shimmer)
  _glow_segment(Vector2(75,size.y-5),Vector2(size.x-75,size.y-5),shimmer)
 elif skin=="name":
  # The reference ornament hangs just below the nameplate instead of filling its corner.
  _metal(_mapped([Vector2(205,53),Vector2(225,33),Vector2(243,32),Vector2(236,40),Vector2(228,40),Vector2(214,53)],Vector2.ZERO,Vector2.ONE))
  _metal(_mapped([Vector2(238,40),Vector2(251,27),Vector2(262,26),Vector2(248,40)],Vector2.ZERO,Vector2.ONE))
  _metal(_mapped([Vector2(224,49),Vector2(229,44),Vector2(243,43),Vector2(238,48)],Vector2.ZERO,Vector2.ONE))
 elif ornament and skin=="panel":
  for i in range(4):
   _corner(Vector2(1 if i%2==0 else size.x-1,1 if i<2 else size.y-1),Vector2(1 if i%2==0 else -1,1 if i<2 else -1))
 _state_light()
 draw_set_transform(Vector2.ZERO)
