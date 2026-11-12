extends Control
signal closed
var selected:=0
var level:=0
var category:=0
var font:Font
var atlas:Texture2D
var display:TextureRect
var title:Label
var hq_title:TextureRect
var description:Label
var roles:Label
var art_hint:Label
var rows:Array[Button]=[]
var tabs:Array[Button]=[]
var filters:Array[Button]=[]
var descriptions=["Trung tâm điều hành và phát triển quân doanh.","Công trình huấn luyện lực lượng bộ binh.","Công trình huấn luyện lực lượng cung binh.","Công trình huấn luyện lực lượng kỵ binh.","Công trình chế tạo khí giới công thành.","Công trình dự trữ lương thực của quân doanh."]
const NAMES=["Đại bản doanh","Trại bộ binh","Trại cung binh","Trại kỵ binh","Xưởng công thành","Kho lương"]
func _ready()->void:
 size=Vector2(1672,941)
 mouse_filter=Control.MOUSE_FILTER_STOP
 font=load("res://lobbies/wei/Trirong-Regular.ttf")
 atlas=load("res://lobbies/wei/buildings/building_atlas.png")
 var background:=ColorRect.new();background.size=size;background.mouse_filter=Control.MOUSE_FILTER_IGNORE
 var shader:=Shader.new()
 shader.code="shader_type canvas_item; float h(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}float n(vec2 p){vec2 i=floor(p),f=fract(p);f=f*f*(3.-2.*f);return mix(mix(h(i),h(i+vec2(1,0)),f.x),mix(h(i+vec2(0,1)),h(i+vec2(1,1)),f.x),f.y);}void fragment(){vec2 p=UV*vec2(1672.,941.);float grain=h(p)*.025;float veins=n(vec2(p.x*.014+p.y*.025,p.y*.021))* .045+n(p*.08)*.015;float shade=.86+.14*sin(UV.x*3.14159);COLOR=vec4((vec3(.045,.094,.132)+veins+grain)*shade,1.);}"
 var material:=ShaderMaterial.new();material.shader=shader;background.material=material;add_child(background)
 var decor:=Node2D.new();decor.draw.connect(func():
  decor.draw_line(Vector2(32,88),Vector2(1640,88),Color(.65,.73,.77,.45),1,true)
  decor.draw_line(Vector2(450,124),Vector2(450,877),Color(.65,.73,.77,.16),1,true)
  decor.draw_line(Vector2(1152,124),Vector2(1152,877),Color(.65,.73,.77,.16),1,true)
 );add_child(decor)
 var back=load("res://lobbies/wei/buildings/base_back.gd").new();back.position=Vector2(39,19);back.size=Vector2(85,46)
 back.pressed.connect(func():closed.emit());add_child(back)
 var heading:=TextureRect.new();heading.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
 var ht:=AtlasTexture.new();ht.atlas=load("res://lobbies/wei/buildings/reference.png");ht.region=Rect2(145,0,290,61)
 heading.texture=ht;heading.position=Vector2(148,18);heading.size=Vector2(235,49)
 var white:=Shader.new();white.code="shader_type canvas_item;void fragment(){vec4 c=texture(TEXTURE,UV);float l=min(c.r,min(c.g,c.b));COLOR=vec4(c.rgb,smoothstep(.39,.63,l));}"
 var white_mat:=ShaderMaterial.new();white_mat.shader=white;heading.material=white_mat;add_child(heading)
 var currency=load("res://lobbies/wei/wei_currency_header.gd").new();currency.name="CurrencyHeader";add_child(currency)
 for i in range(3):
  var b=_tab(["Tất cả","Quân sự","Kinh tế"][i],Vector2(32+i*132,117),Vector2(124,45));b.pressed.connect(_filter.bind(i));filters.append(b)
 for i in range(6):
  var row:=Button.new();row.position=Vector2(32,195+i*108);row.size=Vector2(395,101);row.flat=false;row.tooltip_text=NAMES[i]
  row.mouse_default_cursor_shape=Control.CURSOR_POINTING_HAND
  var normal:=StyleBoxFlat.new();normal.bg_color=Color(0,0,0,0);row.add_theme_stylebox_override("normal",normal)
  var hover:=StyleBoxFlat.new();hover.bg_color=Color(.24,.46,.58,.13);row.add_theme_stylebox_override("hover",hover)
  var active:=StyleBoxFlat.new();active.bg_color=Color(.12,.39,.50,.24);active.border_width_left=3;active.border_color=Color("83d9e4");row.add_theme_stylebox_override("pressed",active)
  row.toggle_mode=true;row.pressed.connect(_select.bind(i));add_child(row);rows.append(row)
  var icon:=TextureRect.new();icon.expand_mode=TextureRect.EXPAND_IGNORE_SIZE;icon.texture=_building(i);icon.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
  icon.position=Vector2(7,-5);icon.size=Vector2(166,105);icon.mouse_filter=Control.MOUSE_FILTER_IGNORE;row.add_child(icon)
  var name_label=_label(NAMES[i],Vector2(176,29),Vector2(215,45),22);remove_child(name_label);row.add_child(name_label)
 title=_label(NAMES[0].to_upper(),Vector2(480,117),Vector2(643,64),36);title.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
 hq_title=TextureRect.new();hq_title.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
 var calligraphy:=AtlasTexture.new();calligraphy.atlas=load("res://lobbies/wei/buildings/approved_base.jpg");calligraphy.region=Rect2(450,87,570,88)
 hq_title.texture=calligraphy;hq_title.position=Vector2(476,96);hq_title.size=Vector2(649,100)
 hq_title.material=white_mat;hq_title.mouse_filter=Control.MOUSE_FILTER_IGNORE;add_child(hq_title)
 for i in range(3):
  var tab=_tab("Cấp "+str(i+1),Vector2(543+i*174,207),Vector2(160,49));tab.pressed.connect(_level.bind(i));tabs.append(tab)
 display=TextureRect.new();display.expand_mode=TextureRect.EXPAND_IGNORE_SIZE;display.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
 display.position=Vector2(464,280);display.size=Vector2(674,446);add_child(display)
 roles=_label("Công trình trung tâm",Vector2(479,742),Vector2(644,42),27);roles.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
 art_hint=_label("",Vector2(479,802),Vector2(644,35),19);art_hint.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
 _label("THÔNG TIN CÔNG TRÌNH",Vector2(1190,121),Vector2(435,48),27)
 description=_label("",Vector2(1190,183),Vector2(430,84),24);description.autowrap_mode=TextServer.AUTOWRAP_WORD_SMART
 _label("THÔNG SỐ",Vector2(1190,289),Vector2(430,44),28)
 for i in range(5):
  _label(["Độ bền","Phòng thủ","Chi phí xây","Thời gian xây","Diện tích"][i],Vector2(1190,350+i*44),Vector2(340,42),24)
  _label("—",Vector2(1576,350+i*44),Vector2(45,42),24)
 _label("MỞ KHÓA THEO CẤP",Vector2(1190,608),Vector2(435,48),27)
 # Intentionally empty below this heading. No icons, placeholders or actions.
 var rules:=Node2D.new();rules.draw.connect(func():
  for y in [172,336,390,434,478,522,566,661]:rules.draw_line(Vector2(1188,y),Vector2(1624,y),Color(.67,.75,.78,.28),1,true)
 );add_child(rules)
 _filter(0);_select(0)
func _label(text_value:String,pos:Vector2,extent:Vector2,fs:int)->Label:
 var label:=Label.new();label.text=text_value;label.position=pos;label.size=extent
 label.add_theme_font_override("font",font);label.add_theme_font_size_override("font_size",fs);label.add_theme_color_override("font_color",Color("eee7d8"));label.mouse_filter=Control.MOUSE_FILTER_IGNORE;add_child(label);return label
func _tab(text_value:String,pos:Vector2,extent:Vector2)->Button:
 var b=load("res://lobbies/wei/buildings/text_tab.gd").new();b.caption=text_value;b.position=pos;b.size=extent;add_child(b);return b
func _building(i:int)->AtlasTexture:
 var b:=AtlasTexture.new();b.atlas=atlas
 var regions=[Rect2(0,50,560,420),Rect2(570,80,455,380),Rect2(1050,90,480,350),Rect2(0,570,515,365),Rect2(535,565,490,370),Rect2(1035,600,495,330)]
 b.region=regions[i];return b

func _select(i:int)->void:
 selected=i
 for k in range(rows.size()):rows[k].set_pressed_no_signal(k==i)
 title.visible=i!=0;hq_title.visible=i==0
 title.text=NAMES[i].to_upper();description.text=descriptions[i];display.texture=_building(i)
 roles.text="Công trình trung tâm" if i==0 else NAMES[i]
func _level(i:int)->void:
 level=i
 for k in range(tabs.size()):tabs[k].active=k==i;tabs[k].queue_redraw()
 if art_hint!=null:art_hint.text="" if i==0 else "Chưa cập nhật hình cấp "+str(i+1)
 # No unapproved level stats or architectural upgrades are invented.
func _filter(i:int)->void:
 category=i
 for k in range(filters.size()):filters[k].active=k==i;filters[k].queue_redraw()
 for k in range(rows.size()):rows[k].visible=i==0 or (i==1 and k in [1,2,3,4]) or (i==2 and k in [0,5])
 var n:=0
 for row in rows:
  if row.visible:row.position.y=195+n*108;n+=1
 if not rows[selected].visible:_select(1 if i==1 else 0)
 _level(level)
func _unhandled_key_input(event:InputEvent)->void:
 if event.is_action_pressed("ui_cancel"):closed.emit();get_viewport().set_input_as_handled()
