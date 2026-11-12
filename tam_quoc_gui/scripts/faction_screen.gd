extends Control
signal back_requested
signal faction_changed(index: int)
signal confirmed(index: int)
const Frame=preload("res://scripts/ornament.gd")
const Ring=preload("res://scripts/faction_ring.gd")
const Raised=preload("res://scripts/raised_button.gd")
const FONT=preload("res://assets/fonts/Trirong-Regular.ttf")
const WORDS=preload("res://assets/faction_words.png")
const WORLD=preload("res://assets/faction_worlds.png")
const WORD_REGIONS=[Rect2(169,99,1198,212),Rect2(59,395,459,190),Rect2(571,395,441,193),Rect2(1095,372,376,212),Rect2(84,680,611,210),Rect2(771,693,696,192)]
const IVORY=Color("eee5d4")
const NAMES=["Ngụy","Thục","Ngô"]
const MATERIALS=["Đá & Bạc","Mực & Ngọc","Gỗ & Đồng"]
const DESCRIPTIONS=["Thành đá phương Bắc","Sơn thành giữa núi","Thủy thành ven sông"]
const GLOWS=[Color("77cfff"),Color("65ffb0"),Color("ffbe67")]
const ACCENTS=[Color("a9adb0"),Color("8fb4a1"),Color("c49b65")]
var cards: Array[Control]=[]
var lifts: Array[Tween]=[]
var selected: int=-1
var buttons: Array[Button]=[]
var rings: Array[Control]=[]
var confirm_button: Button
var confirm_word: TextureRect
var back_button: Button
var status: Label
var subtitle: Label

func _ready() -> void:
 name="FactionSelectionScreen"
 size=Vector2(1600,900)
 var shade:=ColorRect.new()
 shade.color=Color(0.035,0.04,0.045,0.25)
 shade.size=size
 shade.mouse_filter=Control.MOUSE_FILTER_IGNORE
 add_child(shade)
 add_word(self,0,Rect2(560,30,480,92))
 subtitle=_label(self,"Chọn thế lực đồng hành cùng chúa công",Rect2(250,129,1100,40),23,IVORY)
 back_button=preload("res://scripts/back_button.gd").new()
 back_button.position=Vector2(42,34)
 back_button.size=Vector2(66,56)
 add_child(back_button)
 back_button.pressed.connect(func():back_requested.emit())
 for i in range(3):
  _card(i,Rect2(149+i*446,205,410,500))
 status=_label(self,"Chọn một phe để tiếp tục",Rect2(350,734,900,40),24,IVORY)
 status.add_theme_constant_override("outline_size",5)
 status.add_theme_color_override("font_outline_color",Color(0,0,0,0.85))
 confirm_button=_button(self,"",Rect2(625,793,350,67))
 confirm_word=add_word(confirm_button,5,Rect2(48,12,254,42),0)
 confirm_button.disabled=true
 confirm_button.modulate=Color(0.55,0.55,0.55,0.75)
 confirm_button.pressed.connect(_confirm)

func _card(index: int, rect: Rect2) -> void:
 var card:=Control.new()
 card.position=rect.position
 card.size=rect.size
 add_child(card)
 cards.append(card)
 lifts.append(null)
 var frame:=Control.new()
 frame.set_script(Frame)
 frame.faction_index=index
 frame.size=rect.size
 card.add_child(frame)
 var atlas:=AtlasTexture.new()
 atlas.atlas=WORLD
 var w:=WORLD.get_width()/3
 atlas.region=Rect2(index*w,0,w,WORLD.get_height())
 atlas.filter_clip=true
 var art:=TextureRect.new()
 art.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
 art.texture=atlas
 art.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_COVERED
 art.position=Vector2(27,27)
 art.size=Vector2(356,255)
 art.mouse_filter=Control.MOUSE_FILTER_IGNORE
 card.add_child(art)
 add_word(card,index+1,Rect2(85,307,240,66),index)
 _label(card,MATERIALS[index],Rect2(27,382,356,40),24,ACCENTS[index])
 _label(card,DESCRIPTIONS[index],Rect2(27,433,356,34),19,IVORY)
 var ring:=Control.new()
 ring.set_script(Ring)
 ring.size=rect.size
 ring.accent=GLOWS[index]
 card.add_child(ring)
 rings.append(ring)
 var hit:=Button.new()
 hit.name="Choose"+NAMES[index]
 hit.size=rect.size
 hit.mouse_default_cursor_shape=Control.CURSOR_POINTING_HAND
 var empty:=StyleBoxEmpty.new()
 for state in ["normal","hover","pressed","focus"]:
  hit.add_theme_stylebox_override(state,empty)
 hit.pressed.connect(func():select_faction(index))
 hit.mouse_entered.connect(func():ring.hovered=true;ring.queue_redraw())
 hit.mouse_exited.connect(func():ring.hovered=false;ring.queue_redraw())
 card.add_child(hit)
 buttons.append(hit)

func select_faction(index: int) -> void:
 if index<0 or index>=3:return
 selected=index
 for i in range(3):
  rings[i].set_active(i==index)
  if lifts[i]:lifts[i].kill()
  lifts[i]=create_tween()
  lifts[i].tween_property(cards[i],"position:y",195.0 if i==index else 205.0,0.20).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
 status.text="Đã chọn: "+NAMES[index]+"  ·  "+MATERIALS[index]
 status.add_theme_color_override("font_color",GLOWS[index].lerp(IVORY,0.65))
 confirm_button.disabled=false
 confirm_button.modulate=Color.WHITE
 confirm_button.faction_index=index
 confirm_button.queue_redraw()
 confirm_word.material.set_shader_parameter("edge_tint",ACCENTS[index])
 confirm_word.material.set_shader_parameter("face_tint",[Color("e6e7e3"),Color("f2ebdd"),Color("efe3c8")][index])
 faction_changed.emit(index)

func _confirm() -> void:
 if selected<0:return
 status.text="Đã xác nhận phe "+NAMES[selected]
 confirmed.emit(selected)

func set_player_name(value: String) -> void:
 var clean:=value.strip_edges()
 subtitle.text=("Chúa công "+clean+", hãy chọn thế lực đồng hành") if not clean.is_empty() else "Chọn thế lực đồng hành cùng chúa công"

func _label(parent: Node, text: String, rect: Rect2, font_size: int, color: Color) -> Label:
 var l:=Label.new()
 l.text=text
 l.position=rect.position
 l.size=rect.size
 l.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
 l.vertical_alignment=VERTICAL_ALIGNMENT_CENTER
 l.add_theme_font_override("font",FONT)
 l.add_theme_font_size_override("font_size",font_size)
 l.add_theme_color_override("font_color",color)
 l.mouse_filter=Control.MOUSE_FILTER_IGNORE
 parent.add_child(l)
 return l

func _button(parent: Node,text: String,rect: Rect2) -> Button:
 var b:=Button.new()
 b.set_script(Raised)
 b.text=text
 b.position=rect.position
 b.size=rect.size
 b.add_theme_font_override("font",FONT)
 b.add_theme_font_size_override("font_size",25)
 b.mouse_default_cursor_shape=Control.CURSOR_POINTING_HAND
 parent.add_child(b)
 return b

static func add_word(parent: Node,index: int,rect: Rect2,faction_index: int=-1) -> TextureRect:

 var atlas:=AtlasTexture.new()
 atlas.atlas=WORDS
 atlas.region=WORD_REGIONS[index]
 var t:=TextureRect.new()
 t.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
 t.texture=atlas
 t.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
 t.position=rect.position
 t.size=rect.size
 t.mouse_filter=Control.MOUSE_FILTER_IGNORE
 if faction_index>=0:
  var tint:=ShaderMaterial.new()
  tint.shader=preload("res://scripts/faction_glyph.gdshader")
  tint.set_shader_parameter("edge_tint",ACCENTS[faction_index])
  tint.set_shader_parameter("face_tint",[Color("e6e7e3"),Color("f2ebdd"),Color("efe3c8")][faction_index])
  t.material=tint
 parent.add_child(t)
 return t
