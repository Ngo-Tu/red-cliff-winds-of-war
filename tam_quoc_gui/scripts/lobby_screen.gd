extends Control
signal back_requested
const FONT=preload("res://assets/fonts/Trirong-Regular.ttf")
const HERO=preload("res://assets/commander.png")
const SlateFrame=preload("res://scripts/wei_panel.gd")
const WeiButton=preload("res://scripts/wei_button.gd")
const ICONS=["mission","mail","event","general","army","building","supplies","shop","coin","gem","friends","settings"]
var clock:=0.0
var motion_on:=true
var mode:=0
var mode_buttons:Array[Button]=[]
var navigation_buttons:Array[Button]=[]
var action_buttons:Array[Button]=[]
var play_button:Button
var return_button:Button
var title_name:Label
var blocker:ColorRect
var modal:Control
var message:Label
var hero_material:ShaderMaterial
var bg_material:ShaderMaterial
var wind_fx:Node2D
var message_text:=""
var animated_buttons:Array[Button]=[]
var ui:Control
var bold_font:FontVariation

func _ready()->void:
 name="WeiLobby"
 size=Vector2(1600,900)
 var bg:=TextureRect.new()
 bg.texture=preload("res://assets/lobby_bg.png")
 bg.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
 bg.size=size
 bg.mouse_filter=Control.MOUSE_FILTER_IGNORE
 bg_material=ShaderMaterial.new()
 bg_material.shader=preload("res://scripts/lobby_background.gdshader")
 bg.material=bg_material
 add_child(bg)
 # Separate alpha hero with a tessellated mesh: feet stay anchored.
 var shadow:=Polygon2D.new()
 var pts:=PackedVector2Array()
 for i in range(48):
  var a:=TAU*i/48.0
  pts.append(Vector2(746,711)+Vector2(cos(a)*90,sin(a)*14))
 shadow.polygon=pts
 shadow.color=Color(0.02,0.025,0.03,0.24)
 add_child(shadow)
 var hero:=Polygon2D.new()
 hero.texture=HERO
 hero.position=Vector2(555,177)
 var verts:=PackedVector2Array()
 var uvs:=PackedVector2Array()
 var tris:Array[PackedInt32Array]=[]
 for y in range(41):
  for x in range(25):
   var f:=Vector2(x/24.0,y/40.0)
   verts.append(f*Vector2(360,540))
   uvs.append(f*Vector2(HERO.get_size()))
 for y in range(40):
  for x in range(24):
   var i:=y*25+x
   tris.append(PackedInt32Array([i,i+1,i+26]))
   tris.append(PackedInt32Array([i,i+26,i+25]))
 hero.polygon=verts
 hero.uv=uvs
 hero.polygons=tris
 hero_material=ShaderMaterial.new()
 hero_material.shader=preload("res://scripts/character.gdshader")
 hero.material=hero_material
 add_child(hero)
 wind_fx=preload("res://scripts/lobby_wind.gd").new()
 add_child(wind_fx)
 # UI coordinates match the 1672x941 approved base; code scales them to the canvas.
 bold_font=FontVariation.new()
 bold_font.base_font=FONT
 bold_font.variation_embolden=0.4
 ui=Control.new()
 ui.size=Vector2(1672,941)
 ui.scale=Vector2(1600.0/1672,900.0/941)
 ui.mouse_filter=Control.MOUSE_FILTER_IGNORE
 add_child(ui)
 var name_plate:=_panel(ui,Rect2(114,18,265,47))
 name_plate.skin="name"
 name_plate.ornament=false
 var rank_plate:=_panel(ui,Rect2(153,66,180,37))
 rank_plate.skin="rank"
 rank_plate.ornament=false
 ui.move_child(name_plate,rank_plate.get_index())
 _portrait(ui,Rect2(12,0,134,134))
 title_name=_label(ui,"Cẩm Tú",Rect2(156,18,185,43),32)
 _label(ui,"Đô Úy",Rect2(168,67,140,33),24,true)
 var level:=_panel(ui,Rect2(111,78,47,47))
 level.skin="circle"
 level.ornament=false
 _label(level,"12",Rect2(0,0,47,47),25,true)
 # The base has no extra button under the profile. Esc returns to factions.
 return_button=_button(ui,Rect2(15,4,126,126),"Chọn phe · Esc",func():back_requested.emit(),"portrait_hit")
 for i in range(3):
  var index:=i
  var title:String=["Nhiệm vụ","Thư","Sự kiện"][i]
  var button:=_button(ui,Rect2(15,145+i*114,119,105),title,func():_select_action(index);_popup(title,"Nội dung đang chờ tích hợp."),"action")
  action_buttons.append(button)
  _icon(button.contents,i,Rect2(25,17,68,64))
  _label(button.contents,title,Rect2(-7,77,133,30),22,true)
  if i==0:_dot(button.contents,Vector2(85,17),9,Color("d34f37"))
 _currency(Rect2(1170,15,213,42),8,"12.500")
 _currency(Rect2(1393,15,201,42),9,"320")
 var settings:=_button(ui,Rect2(1606,7,59,58),"Cài đặt",func():_popup("Cài đặt","Nhấn M để bật/tắt hiệu ứng.\nEsc: chọn phe · F11: toàn màn hình"),"counter")
 _icon(settings.contents,11,Rect2(9,7,42,42))
 var friends:=_panel(ui,Rect2(1467,133,200,351))
 friends.stone_tint=Color(1.25,0.94,0.94)
 _icon(friends,10,Rect2(31,12,38,33))
 _label(friends,"Bạn bè",Rect2(83,11,108,37),26)
 _line(friends,Vector2(15,55),Vector2(185,55))
 for i in range(3):
  var row:=_button(friends,Rect2(14,65+i*70,176,62),"Bạn bè",func():_popup("Bạn bè","Danh sách đang dùng dữ liệu minh họa."),"plain")
  var frame:=_panel(row.contents,Rect2(0,0,53,53))
  frame.bevel=1
  frame.ornament=false
  var portrait:=TextureRect.new()
  portrait.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
  portrait.texture=load("res://assets/lobby/friend_%d.png"%i)
  portrait.position=Vector2(2,2)
  portrait.size=Vector2(49,49)
  portrait.mouse_filter=Control.MOUSE_FILTER_IGNORE
  row.contents.add_child(portrait)
  _label(row.contents,["Thanh Phong","Vân Sơn","Trường An"][i],Rect2(65,12,114,29),17)
  _dot(row.contents,Vector2(53,50),6,Color("67ba42"))
  _line(friends,Vector2(15,129+i*70),Vector2(185,129+i*70))
 var invite:=_button(friends,Rect2(17,282,168,56),"Mời bạn",func():_popup("Mời bạn","Chưa kết nối mạng hoặc gửi lời mời."),"invite")
 invite.face.ornament=false
 invite.face.stone_tint=Color(1.12,1.35,1.52)
 var invite_art:=preload("res://scripts/invite_content.gd").new()
 invite_art.size=invite.size
 invite_art.font=bold_font
 invite.contents.add_child(invite_art)
 var chat_strip:=ColorRect.new()
 chat_strip.position=Vector2(16,723)
 chat_strip.size=Vector2(1194,45)
 chat_strip.color=Color(0.035,0.06,0.08,0.26)
 chat_strip.mouse_filter=Control.MOUSE_FILTER_IGNORE
 ui.add_child(chat_strip)
 var channel:=_panel(ui,Rect2(16,723,153,45))
 channel.skin="counter"
 _chat_icon(channel,Vector2(15,13))
 _label(channel,"Thế giới",Rect2(51,3,100,38),25)
 _label(ui,"│  Sẵn sàng xuất trận!",Rect2(174,725,960,40),24)
 var nav:=_panel(ui,Rect2(12,787,1198,134))
 var nav_names:=["Tướng","Quân đội","Công trình","Kho","Cửa hàng"]
 for i in range(5):
  var index:=i
  var title:String=nav_names[i]
  var button:=_button(nav,Rect2(i*239.6+5,4,229.6,126),title,func():_select_navigation(index);_popup(title,"Chức năng "+title.to_lower()+" đang chờ tích hợp."),"plain")
  _icon(button.contents,i+3,Rect2(49,-4,136,103))
  _label(button.contents,title,Rect2(0,87,230,35),29,true)
  navigation_buttons.append(button)
  if i<4:_line(nav,Vector2((i+1)*239.6,26),Vector2((i+1)*239.6,108))
 for i in range(2):
  var index:=i
  var rect:=Rect2(1222,676,234,53) if i==0 else Rect2(1470,676,197,53)
  var b:=_button(ui,rect,"Chế độ",func():_select_mode(index),"mode")
  _label(b.contents,["Đấu thường  ▾","Xếp hạng"][i],Rect2(0,1,rect.size.x,50),27,true)
  mode_buttons.append(b)
 play_button=_button(ui,Rect2(1230,747,433,129),"Xuất chinh",_deploy,"primary")
 var word:=TextureRect.new()
 word.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
 word.texture=load("res://assets/lobby/deploy_word.png")
 word.position=Vector2(42,17)
 word.size=Vector2(350,96)
 word.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
 word.mouse_filter=Control.MOUSE_FILTER_IGNORE
 play_button.contents.add_child(word)
 play_button.set_selected(false)
 _build_modal()
 _select_mode(0)

func _panel(parent:Node,rect:Rect2)->Control:
 var frame:=SlateFrame.new()
 frame.position=rect.position
 frame.size=rect.size
 parent.add_child(frame)
 return frame

func _button(parent:Node,rect:Rect2,label:String,action:Callable,skin:String="panel")->Button:
 var b:=WeiButton.new()
 b.name=label
 b.tooltip_text=label if label in ["Cài đặt","Chọn phe · Esc"] else ""
 b.position=rect.position
 b.size=rect.size
 b.pressed.connect(action)
 parent.add_child(b)
 b.face.skin=skin
 animated_buttons.append(b)
 return b

func _icon(parent:Node,index:int,rect:Rect2)->TextureRect:
 var t:=TextureRect.new()
 t.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
 t.texture=load("res://assets/lobby/icons/"+ICONS[index]+".png")
 t.position=rect.position
 t.size=rect.size
 t.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
 t.size=rect.size
 t.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
 t.mouse_filter=Control.MOUSE_FILTER_IGNORE
 parent.add_child(t)
 t.set_deferred("size",rect.size)
 return t

func _portrait(parent:Node,rect:Rect2)->void:
 var t:=TextureRect.new()
 t.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
 t.texture=HERO
 t.position=rect.position
 t.size=rect.size
 t.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
 t.size=rect.size
 var mat:=ShaderMaterial.new()
 mat.shader=preload("res://scripts/circle_portrait.gdshader")
 t.material=mat
 t.mouse_filter=Control.MOUSE_FILTER_IGNORE
 parent.add_child(t)
 t.set_deferred("size",rect.size)

func _label(parent:Node,value:String,rect:Rect2,font_size:int,center:bool=false)->Label:
 var l:=Label.new()
 l.text=value
 l.position=rect.position
 l.size=rect.size
 l.vertical_alignment=VERTICAL_ALIGNMENT_CENTER
 l.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER if center else HORIZONTAL_ALIGNMENT_LEFT
 l.add_theme_font_override("font",bold_font if bold_font else FONT)
 l.add_theme_font_size_override("font_size",font_size)
 l.add_theme_color_override("font_color",Color("e6e7e3"))
 l.add_theme_color_override("font_outline_color",Color("14212d"))
 l.add_theme_constant_override("outline_size",2)
 l.mouse_filter=Control.MOUSE_FILTER_IGNORE
 parent.add_child(l)
 return l

func _currency(rect:Rect2,index:int,value:String)->void:
 var panel:=_panel(ui,rect)
 panel.skin="counter"
 panel.ornament=false
 _icon(panel,index,Rect2(12,2,36,38))
 _label(panel,value,Rect2(59,0,112,41),28,true)
 var plus:=_button(panel,Rect2(rect.size.x-37,3,31,36),"Số dư minh họa",func():_popup("Số dư","Dữ liệu minh họa, chưa có chức năng mua hoặc nạp."),"plain")
 plus.face.ornament=false
 _label(plus.contents,"+",Rect2(0,-2,31,36),34,true)

func set_player_name(value:String)->void:
 title_name.text=value.strip_edges() if not value.strip_edges().is_empty() else "Chúa công"

func _select_mode(index:int)->void:
 mode=index
 for i in range(mode_buttons.size()):mode_buttons[i].set_selected(i==index)

func _build_modal()->void:
 blocker=ColorRect.new()
 blocker.size=size
 blocker.color=Color(0,0,0,0.36)
 add_child(blocker)
 blocker.hide()
 modal=_panel(self,Rect2(465,310,670,264))
 # Unlike decorative panels this popup consumes clicks in its area.
 modal.mouse_filter=Control.MOUSE_FILTER_STOP
 message=_label(modal,"",Rect2(25,24,620,140),23,true)
 var close:=_button(modal,Rect2(245,188,180,49),"Đóng",close_popup)
 _label(close.contents,"Đóng",Rect2(0,0,180,49),23,true)
 modal.hide()

func _popup(title:String,body:String)->void:
 message_text=title+"\n"+body
 message.text=message_text
 blocker.show()
 move_child(blocker,get_child_count()-1)
 modal.show()
 move_child(modal,get_child_count()-1)

func close_popup()->void:
 modal.hide()
 blocker.hide()

func _process(delta:float)->void:
 if not visible:return
 if motion_on:clock+=delta
 hero_material.set_shader_parameter("motion_time",clock)
 bg_material.set_shader_parameter("motion_time",clock)
 wind_fx.clock=clock
 wind_fx.queue_redraw()
 for b in animated_buttons:
  if b.selected:b.face.queue_redraw()

func _line(parent:Node,a:Vector2,b:Vector2)->void:
 var line:=Line2D.new()
 line.points=PackedVector2Array([a,b])
 line.width=1.0
 line.default_color=Color(0.66,0.70,0.71,0.65)
 parent.add_child(line)

func _dot(parent:Node,center:Vector2,radius:float,color:Color)->void:
 var shape:=Polygon2D.new()
 var points:=PackedVector2Array()
 for i in range(32):points.append(center+Vector2(cos(TAU*i/32.0),sin(TAU*i/32.0))*radius)
 shape.polygon=points
 shape.color=color
 parent.add_child(shape)

func _rank_badge(parent:Node,center:Vector2)->void:
 var polygon:=Polygon2D.new()
 polygon.polygon=PackedVector2Array([center+Vector2(-15,-15),center+Vector2(15,-15),center+Vector2(15,10),center+Vector2(0,22),center+Vector2(-15,10)])
 polygon.color=Color("293842")
 parent.add_child(polygon)
 var line:=Line2D.new()
 var outline:=polygon.polygon.duplicate()
 outline.append(outline[0])
 line.points=outline
 line.default_color=Color("a9adb0")
 line.width=2
 parent.add_child(line)
 for y in [-7,0,7]:
  var v:=Line2D.new()
  v.points=PackedVector2Array([center+Vector2(-9,y),center+Vector2(0,y+7),center+Vector2(9,y)])
  v.default_color=Color("e6e7e3")
  v.width=3
  parent.add_child(v)

func _chat_icon(parent:Node,point:Vector2)->void:
 var shape:=Polygon2D.new()
 shape.polygon=PackedVector2Array([point,point+Vector2(27,0),point+Vector2(27,19),point+Vector2(12,19),point+Vector2(6,25),point+Vector2(6,19),point+Vector2(0,19)])
 shape.color=Color("e6e7e3")
 parent.add_child(shape)
 for x in [7,14,21]:_dot(parent,point+Vector2(x,9),2,Color("263741"))

func _select_action(index:int)->void:
 for i in range(action_buttons.size()):action_buttons[i].set_selected(i==index)

func _select_navigation(index:int)->void:
 for i in range(navigation_buttons.size()):navigation_buttons[i].set_selected(i==index)

func _deploy()->void:
 play_button.set_selected(true)
 _popup("Xuất chinh",("Đấu thường 1v1" if mode==0 else "Xếp hạng 1v1")+"\nBản GUI chưa kết nối tìm trận.")
