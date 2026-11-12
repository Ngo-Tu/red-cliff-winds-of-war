extends Control
signal action_requested(action:String)
var faction:=0
var selected:=-1
var hovered:=-1
var font:Font
var base:Texture2D
var palette:Color
const ACTIONS=["Tướng","Chiêu mộ","Quân đội","Công trình","Kho","Cửa hàng"]
const W:=1196.0
const H:=132.0
var buttons:Array[Button]=[]
func _ready()->void:
 position=Vector2(12,790)
 size=Vector2(W,H)
 font=load("res://lobbies/wu/Trirong-Regular.ttf")
 base=load("res://lobbies/wu/base.png")
 palette=[Color("bac6d0"),Color("d6ac65"),Color("a7c8b0")][faction]
 # Preserve the ORIGINAL frame and corner ornament artwork, including all faction differences.
 var frame:=NinePatchRect.new()
 frame.texture=base
 frame.region_rect=Rect2(12,790,1196,132)
 frame.size=size
 frame.patch_margin_left=50;frame.patch_margin_right=50
 frame.patch_margin_top=12;frame.patch_margin_bottom=6
 frame.draw_center=false
 frame.mouse_filter=Control.MOUSE_FILTER_IGNORE
 add_child(frame)
 # Sample only existing empty material; no regenerated icon or frame artwork.
 var face:=ColorRect.new();face.position=Vector2(50,12);face.size=Vector2(W-100,H-18)
 face.mouse_filter=Control.MOUSE_FILTER_IGNORE
 var shader:=Shader.new()
 shader.code="shader_type canvas_item; uniform sampler2D original; void fragment(){vec2 q=UV;vec2 uv=(vec2(196.,803.)+q*vec2(45.,90.))/vec2(1672.,941.);COLOR=texture(original,uv);}"
 var mat:=ShaderMaterial.new();mat.shader=shader;mat.set_shader_parameter("original",base)
 face.material=mat;add_child(face);move_child(face,0)
 var decor:=Node2D.new();decor.name="Decor";decor.draw.connect(_draw_decor);add_child(decor)
 var regions=[Rect2(80,793,112,87),Rect2(),Rect2(318,798,116,80),Rect2(555,800,125,79),Rect2(801,799,118,79),Rect2(1041,799,126,80)]
 for i in range(6):
  var button:=Button.new();button.position=Vector2(14+i*194.7,7);button.size=Vector2(194.7,116)
  button.flat=true;button.mouse_default_cursor_shape=Control.CURSOR_POINTING_HAND;button.tooltip_text=ACTIONS[i]
  for state in ["normal","hover","pressed","focus"]:button.add_theme_stylebox_override(state,StyleBoxEmpty.new())
  button.mouse_entered.connect(func():hovered=i;_redraw())
  button.mouse_exited.connect(func():hovered=-1;_redraw())
  button.pressed.connect(_select.bind(i));add_child(button);buttons.append(button)
  var icon:=TextureRect.new()
  icon.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
  if i==1:
   var drum:=AtlasTexture.new();drum.atlas=load("res://lobbies/wu/recruit_drum.png");drum.region=Rect2(350,230,570,690)
   icon.texture=drum
   icon.position=Vector2(52,-2);icon.size=Vector2(91,87)
  else:
   var at:=AtlasTexture.new();at.atlas=base;at.region=regions[i];icon.texture=at
   icon.position=Vector2(37,-2);icon.size=Vector2(120,87)
  icon.expand_mode=TextureRect.EXPAND_IGNORE_SIZE;icon.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
  if i!=1:
   var feather:=Shader.new()
   feather.code="shader_type canvas_item; void fragment(){vec4 c=texture(TEXTURE,UV);float edge=smoothstep(0.,.07,UV.x)*smoothstep(0.,.07,UV.y)*(1.-smoothstep(.93,1.,UV.x))*(1.-smoothstep(.93,1.,UV.y));c.a*=edge;COLOR=c;}"
   var feather_mat:=ShaderMaterial.new();feather_mat.shader=feather;icon.material=feather_mat
  icon.mouse_filter=Control.MOUSE_FILTER_IGNORE;button.add_child(icon)
  var label:=Label.new();label.text=ACTIONS[i];label.position=Vector2(0,78);label.size=Vector2(194.7,38)
  label.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER;label.add_theme_font_override("font",font)
  label.add_theme_font_size_override("font_size",27)
  label.add_theme_color_override("font_color",Color("f2ebda"))
  label.add_theme_color_override("font_shadow_color",Color("171a18"))
  label.add_theme_constant_override("shadow_offset_x",1);label.add_theme_constant_override("shadow_offset_y",2)
  label.mouse_filter=Control.MOUSE_FILTER_IGNORE;button.add_child(label)
 _redraw()
func _select(i:int)->void:
 selected=i;_redraw();action_requested.emit(ACTIONS[i])
func _redraw()->void:
 if has_node("Decor"):get_node("Decor").queue_redraw()
func _draw_decor()->void:
 if base==null:return
 for i in range(1,6):get_node("Decor").draw_line(Vector2(14+i*194.7,25),Vector2(14+i*194.7,108),Color(palette,.55),1,true)
 for i in range(6):
  if i==hovered or i==selected:
   var rect:=Rect2(17+i*194.7,10,188,111)
   get_node("Decor").draw_rect(rect,Color(palette,.11 if i==hovered else .17))
   get_node("Decor").draw_line(Vector2(rect.position.x+24,121),Vector2(rect.end.x-24,121),palette,2,true)
   if i==selected:get_node("Decor").draw_circle(Vector2(rect.get_center().x,122),2.3,palette)
