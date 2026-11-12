extends Button
## A tactile copper bezel: extruded base, bevel light, soft shadow and press travel.
const PHYSICAL=preload("res://assets/physical_surfaces.png")
const SOURCE = preload("res://assets/gui_reference.png")
const FACTION_SOURCE=preload("res://assets/faction_materials.png")
const FACTION_REGIONS=[Rect2(1136,534,513,208),Rect2(579,534,512,208),Rect2(23,534,511,208)]
@export var faction_index: int=-1
@export var light := false
var lift := -0.8
var surface: StyleBoxTexture
var face_material: ShaderMaterial

func _ready() -> void:
 face_material=ShaderMaterial.new()
 face_material.shader=preload("res://scripts/button_surface.gdshader")
 face_material.set_shader_parameter("physical_surfaces",PHYSICAL)
 material=face_material
 var empty:=StyleBoxEmpty.new()
 for state in ["normal","hover","pressed","focus","disabled"]:
  add_theme_stylebox_override(state,empty)
 var atlas:=AtlasTexture.new()
 atlas.atlas=SOURCE
 # The blank approved panel contains exactly the same ink and copper frame.
 atlas.region=Rect2(881,437,619,165)
 atlas.filter_clip=true
 surface=StyleBoxTexture.new()
 surface.texture=atlas
 for edge in [SIDE_LEFT,SIDE_TOP,SIDE_RIGHT,SIDE_BOTTOM]:
  surface.set_texture_margin(edge,22.0)
 mouse_entered.connect(queue_redraw)
 mouse_exited.connect(queue_redraw)
 button_down.connect(queue_redraw)
 button_up.connect(queue_redraw)

func _process(delta: float) -> void:
 face_material.set_shader_parameter("material_kind",faction_index)
 face_material.set_shader_parameter("frame_size",size)
 var target:=0.6 if button_pressed else (-1.6 if is_hovered() else -0.8)
 lift=lerpf(lift,target,1.0-exp(-delta*28.0))
 for child in get_children():
  if child is Control:
   if not child.has_meta("rest_position"): child.set_meta("rest_position",child.position)
   child.position=child.get_meta("rest_position")+Vector2(0,lift)
 queue_redraw()

func _shape(r: Rect2, cut: float=11.0) -> PackedVector2Array:
 var a:=r.position
 var b:=r.end
 return PackedVector2Array([a+Vector2(cut,0),Vector2(b.x-cut,a.y),Vector2(b.x,a.y+cut),b-Vector2(0,cut),b-Vector2(cut,0),Vector2(a.x+cut,b.y),Vector2(a.x,b.y-cut),a+Vector2(0,cut)])

func _stroke(points: PackedVector2Array,c: Color,width: float) -> void:
 var edge:=points.duplicate()
 edge.append(edge[0])
 draw_polyline(edge,c,width,true)

func _draw() -> void:
 if not surface: return
 var face:=Rect2(Vector2(0,lift),size-Vector2(0,1.5))
 for i in range(3,0,-1):
  var shadow:=Rect2(Vector2(-float(i)*0.7,1.5+float(i)*0.4),size+Vector2(float(i)*1.4,0))
  draw_colored_polygon(_shape(shadow),Color(0.02,0.015,0.01,0.030))
 var base:=_shape(Rect2(Vector2(0,1),size-Vector2(0,1)))
 draw_colored_polygon(base,[Color("243642"),Color("2c493f"),Color("493322")][faction_index] if faction_index>=0 else Color("51412b"))
 _stroke(base,Color("211b14"),1.0)
 draw_colored_polygon(_shape(face),Color("6e5535"))
 # Clip the texture with explicit polygon triangles, while preserving 9-slice corners.
 # The four outer paper triangles are covered by the exact silhouette's face below.
 if not light:
  _draw_sliced_face(face)
 else:
  var points:=_shape(face)
  var colors:=PackedColorArray()
  for v in points:
   colors.append(Color("f6eedf") if v.y<face.get_center().y else Color("d6c8b0"))
  draw_polygon(points,colors)
  _stroke(points,Color("a58b62"),2.3)
 var top:=PackedVector2Array([face.position+Vector2(12,1),Vector2(face.end.x-12,face.position.y+1),Vector2(face.end.x-1,face.position.y+12)])
 draw_polyline(top,Color(0.90,0.77,0.54,0.82 if is_hovered() else 0.60),1.5,true)
 var lower:=PackedVector2Array([Vector2(1,face.end.y-12),Vector2(12,face.end.y-1),Vector2(face.end.x-12,face.end.y-1)])
 draw_polyline(lower,Color("5b4125"),1.0,true)
 if is_hovered() and not button_pressed:
  draw_colored_polygon(_shape(face.grow(-7),8),Color(1.0,0.84,0.57,0.035))
 if has_focus():
  _stroke(_shape(face.grow(-6),8),Color(0.90,0.78,0.57,0.8),1.0)
 if not text.is_empty():
  var font:=get_theme_font("font")
  var font_size:=get_theme_font_size("font_size")
  var measure:=font.get_string_size(text,HORIZONTAL_ALIGNMENT_LEFT,-1,font_size)
  var baseline:=(size.y-font.get_height(font_size))*0.5+font.get_ascent(font_size)+lift-2
  var pos:=Vector2((size.x-measure.x)*0.5,baseline)
  if not light:
   draw_string(font,pos+Vector2(0,2),text,HORIZONTAL_ALIGNMENT_LEFT,-1,font_size,Color(0,0,0,0.8))
  draw_string(font,pos,text,HORIZONTAL_ALIGNMENT_LEFT,-1,font_size,Color("242321") if light else Color("eee5d4"))

func _draw_sliced_face(r: Rect2) -> void:
 # Build nine-slice as clipped textured polygons: no ivory corners from the style sheet.
 var source: Rect2=FACTION_REGIONS[faction_index] if faction_index>=0 else Rect2(881,437,619,165)
 var art: Texture2D=FACTION_SOURCE if faction_index>=0 else SOURCE
 var margin:=minf(30.0,(size.y-3.0)/2.4)
 var source_margin:=38.0
 var xs: Array[float]=[r.position.x,r.position.x+margin,r.end.x-margin,r.end.x]
 var ys: Array[float]=[r.position.y,r.position.y+margin,r.end.y-margin,r.end.y]
 var us: Array[float]=[source.position.x,source.position.x+source_margin,source.end.x-source_margin,source.end.x]
 var vs: Array[float]=[source.position.y,source.position.y+source_margin,source.end.y-source_margin,source.end.y]
 var texture_size:=Vector2(art.get_size())
 for row in range(3):
  for col in range(3):
   var quad:=PackedVector2Array([Vector2(xs[col],ys[row]),Vector2(xs[col+1],ys[row]),Vector2(xs[col+1],ys[row+1]),Vector2(xs[col],ys[row+1])])
   var uv:=PackedVector2Array([Vector2(us[col],vs[row]),Vector2(us[col+1],vs[row]),Vector2(us[col+1],vs[row+1]),Vector2(us[col],vs[row+1])])
   # Intersect with the bevelled outer polygon; map clipped vertices back to the source cell.
   var clips:=Geometry2D.intersect_polygons(quad,_shape(r))
   for clipped in clips:
    var mapped:=PackedVector2Array()
    for p in clipped:
     var f:=(p-quad[0])/(quad[2]-quad[0])
     mapped.append((uv[0]+f*(uv[2]-uv[0]))/texture_size)
    draw_polygon(clipped,PackedColorArray([Color.WHITE]),mapped,art)
