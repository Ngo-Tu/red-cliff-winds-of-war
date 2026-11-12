extends Control
## Four-screen art preview. No authentication, account persistence or gameplay.
const Frame = preload("res://scripts/ornament.gd")
const LoginPanel = preload("res://scripts/login_panel.gd")
const LoginIconButton = preload("res://scripts/login_icon_button.gd")
const Atmosphere = preload("res://scripts/atmosphere.gd")
const SceneEffects = preload("res://scripts/scene_effects.gd")
const RaisedButton = preload("res://scripts/raised_button.gd")
const FactionScreen=preload("res://scripts/faction_screen.gd")
const FONT = preload("res://assets/fonts/Trirong-Regular.ttf")
const TITLES = preload("res://assets/titles.png")
const IDENTITY_TITLES=preload("res://assets/identity_titles.png")
const GAME_TITLE_LOGO = preload("res://assets/game_title_logo.png")
const WHEEL_SPIN_SFX = preload("res://assets/sounds/wheel_ratchet.wav")
const LOGIN_BG = preload("res://assets/login_bg.png")
const LOGIN_BG_STATIC = preload("res://assets/login_bg_video/bg_static.webp")
const LOGIN_BG_VIDEO = preload("res://assets/login_bg_video/bg_video.tscn")
const LOGIN_BG_AUDIO = "res://assets/login_bg_video/bg_audio.ogg"
const FACTION_BG=preload("res://assets/faction_bg.png")
const CHARACTER_BG = preload("res://assets/strategist_bg_video/bg_static.webp")
const STRATEGIST_BG_VIDEO = preload("res://assets/strategist_bg_video/bg_video.tscn")
const STRATEGIST_BG_AUDIO = "res://assets/strategist_bg_video/bg_audio.ogg"
const MERCHANT_BG_STATIC = preload("res://assets/merchant_bg_video/bg_static.webp")
const MERCHANT_BG_VIDEO = preload("res://assets/merchant_bg_video/bg_video.tscn")
const MERCHANT_BG_AUDIO = "res://assets/merchant_bg_video/bg_audio.ogg"
const COMMANDER_BG_STATIC = preload("res://assets/commander_bg_video/bg_static.webp")
const COMMANDER_BG_VIDEO = preload("res://assets/commander_bg_video/bg_video.tscn")
const COMMANDER_BG_AUDIO = "res://assets/commander_bg_video/bg_audio.ogg"
const FARMER_BG_STATIC = preload("res://assets/farmer_bg_video/bg_static.webp")
const FARMER_BG_VIDEO = preload("res://assets/farmer_bg_video/bg_video.tscn")
const FARMER_BG_AUDIO = "res://assets/farmer_bg_video/bg_audio.ogg"
const CRAFTSMAN_BG_STATIC = preload("res://assets/craftsman_bg_video/bg_static.webp")
const CRAFTSMAN_BG_VIDEO = preload("res://assets/craftsman_bg_video/bg_video.tscn")
const CRAFTSMAN_BG_AUDIO = "res://assets/craftsman_bg_video/bg_audio.ogg"
const CHAR_AUDIO_PATHS := [
	"res://assets/flow_idle/char_audio.ogg",
	"res://assets/female_flow_idle/char_audio.ogg",
	"res://assets/male_merchant_idle/char_audio.ogg",
	"res://assets/female_merchant_idle/char_audio.ogg",
	"res://assets/male_commander_idle/char_audio.ogg",
	"res://assets/female_commander_idle/char_audio.ogg",
	"res://assets/male_farmer_idle/char_audio.ogg",
	"res://assets/female_farmer_idle/char_audio.ogg",
	"res://assets/male_craftsman_idle/char_audio.ogg",
	"res://assets/female_craftsman_idle/char_audio.ogg",
]
const STRATEGIST_IDLE = preload("res://assets/flow_idle/idle.tscn")
const FEMALE_STRATEGIST_IDLE = preload("res://assets/female_flow_idle/idle.tscn")
const FEMALE_STRATEGIST_PORTRAIT = preload("res://assets/female_flow_idle/portrait.png")
const MALE_MERCHANT_IDLE = preload("res://assets/male_merchant_idle/idle.tscn")
const MALE_MERCHANT_PORTRAIT = preload("res://assets/male_merchant_idle/portrait.png")
const FEMALE_MERCHANT_IDLE = preload("res://assets/female_merchant_idle/idle.tscn")
const FEMALE_MERCHANT_PORTRAIT = preload("res://assets/female_merchant_idle/portrait.png")
const MALE_COMMANDER_IDLE = preload("res://assets/male_commander_idle/idle.tscn")
const MALE_COMMANDER_PORTRAIT = preload("res://assets/male_commander_idle/portrait.png")
const FEMALE_COMMANDER_IDLE = preload("res://assets/female_commander_idle/idle.tscn")
const FEMALE_COMMANDER_PORTRAIT = preload("res://assets/female_commander_idle/portrait.png")
const MALE_FARMER_IDLE = preload("res://assets/male_farmer_idle/idle.tscn")
const MALE_FARMER_PORTRAIT = preload("res://assets/male_farmer_idle/portrait.png")
const FEMALE_FARMER_IDLE = preload("res://assets/female_farmer_idle/idle.tscn")
const FEMALE_FARMER_PORTRAIT = preload("res://assets/female_farmer_idle/portrait.png")
const MALE_CRAFTSMAN_IDLE = preload("res://assets/male_craftsman_idle/idle.tscn")
const MALE_CRAFTSMAN_PORTRAIT = preload("res://assets/male_craftsman_idle/portrait.png")
const FEMALE_CRAFTSMAN_IDLE = preload("res://assets/female_craftsman_idle/idle.tscn")
const FEMALE_CRAFTSMAN_PORTRAIT = preload("res://assets/female_craftsman_idle/portrait.png")

# V6 Character Screen Ornamental Textures
const V6_TOP_BANNER = preload("res://assets/char_v6/top_banner.png")
const V6_WHEEL_TRACK = preload("res://assets/char_v6/wheel_track.png")
const V6_BUFF_PANEL_BG = preload("res://assets/char_v6/buff_panel_bg.png")
const V6_GENDER_MALE_ON = preload("res://assets/char_v6/gender_male_active.png")
const V6_GENDER_MALE_OFF = preload("res://assets/char_v6/gender_male_inactive.png")
const V6_GENDER_FEM_ON = preload("res://assets/char_v6/gender_female_active.png")
const V6_GENDER_FEM_OFF = preload("res://assets/char_v6/gender_female_inactive.png")
const V6_GENDER_BRIDGE = preload("res://assets/char_v6/gender_bridge.png")
const V6_NAME_BOX_BG = preload("res://assets/char_v6/name_box_bg.png")
const V6_CONFIRM_BTN = preload("res://assets/char_v6/confirm_btn.png")
const V6_CLASS_NORMAL := [
	preload("res://assets/char_v6/class_normal_0.png"),
	preload("res://assets/char_v6/class_normal_1.png"),
	preload("res://assets/char_v6/class_normal_2.png"),
	preload("res://assets/char_v6/class_normal_3.png"),
	preload("res://assets/char_v6/class_normal_4.png"),
]
const V6_CLASS_ACTIVE := [
	preload("res://assets/char_v6/class_active_0.png"),
	preload("res://assets/char_v6/class_active_1.png"),
	preload("res://assets/char_v6/class_active_2.png"),
	preload("res://assets/char_v6/class_active_3.png"),
	preload("res://assets/char_v6/class_active_4.png"),
]

# Indices follow FactionScreen.NAMES (Ngụy, Thục, Ngô).
const LOBBY_SCENES := [
	"res://lobbies/wei/main.tscn",
	"res://lobbies/shu/main.tscn",
	"res://lobbies/wu/main.tscn",
]
const INK = Color("242321")
const BRONZE = Color("a58b62")
const GOLD = Color("e8c88e")
const IVORY = Color("eee5d4")
const MUTED = Color("b6ad9e")

var custom_pointer: CanvasLayer
var stage: Control
var login: Control
var creation: Control
var lobby: Control
var active_lobby: Node2D
var lobby_back: Button
var login_bg_video: AnimatedSprite2D
var wheel_sfx_player: AudioStreamPlayer
var notice_popup: Control
var bg_video: AnimatedSprite2D
var merchant_bg_video: AnimatedSprite2D
var commander_bg_video: AnimatedSprite2D
var farmer_bg_video: AnimatedSprite2D
var craftsman_bg_video: AnimatedSprite2D
var bg_audio_player: AudioStreamPlayer
var bg_audio_streams: Dictionary = {}
var current_bg_audio_key: String = ""
var char_audio_player: AudioStreamPlayer
var char_audio_streams: Array[AudioStream] = []
var strategist_previews: Array[AnimatedSprite2D] = []
var strategist_choices: Array[Button] = []
var wheel_track_tex: TextureRect
var wheel_holders: Array[Control] = []
var wheel_nodes: Array[Button] = []
var wheel_normal_tex: Array[TextureRect] = []
var wheel_active_tex: Array[TextureRect] = []
var wheel_pos := 2.0
var wheel_tween: Tween
var male_btn_tex: TextureRect
var fem_btn_tex: TextureRect
var buff_header_label: Label
var buff_title_labels: Array[Label] = []
var buff_desc_labels: Array[Label] = []
var contact_shadow: ColorRect
var shadow_material: ShaderMaterial
var selected_strategist := 0
var selected_class_wheel := 2

const WHEEL_CX := 1688.0
const WHEEL_CY := 450.0
const WHEEL_RADIUS := 380.0
const WHEEL_STEP_DEG := 26.5
var factions: Control
var continue_button: Button
var selected_faction: int=-1
var background: TextureRect
var fog_material: ShaderMaterial
var background_material: ShaderMaterial
var cloud_material: ShaderMaterial
var scene_fx: Node2D
var cloud_layer: ColorRect
var dust: Node2D
var play_button: Button
var google_button: Button
var guest_button: Button
var back_button: Button
var name_input: LineEdit
var portrait_slots: Array[Control] = []
var screen := "login"
var method := "guest"
var motion_on := true
var elapsed := 0.0
var motion_button: Button
var transitioning := false

const HERO_BUFF_DATA := [
	{
		"header": "ĐẶC QUYỀN NGHỀ NGHIỆP · KỲ TÁ (MƯU SĨ NAM)",
		"wheel_index": 2,
		"is_female": false,
		"titles": ["◆ Bát Quái Kỳ Trận:", "◆ Thần Cơ Hỏa Kế:", "◆ Vương Tá Chi Tài:"],
		"descs": [
			"+20% tầm nhìn Sương mù & soi phục binh.",
			"+15% sát thương Hỏa công & -10% hồi chiêu.",
			"+15% tốc độ sinh Hổ phù tại Tướng phủ."
		]
	},
	{
		"header": "ĐẶC QUYỀN NGHỀ NGHIỆP · KỲ TÁ (MƯU SĨ NỮ)",
		"wheel_index": 2,
		"is_female": true,
		"titles": ["◆ Tinh Vân Chiêm Bốc:", "◆ Lạc Thủy Linh Kế:", "◆ Nội Chính Hiền Tài:"],
		"descs": [
			"+25% tầm nhìn ban đêm & kháng mưu kế.",
			"+15% sát thương Thủy/Hỏa kế & hồi năng lượng.",
			"-10% lương thảo duy trì quân đội toàn trận."
		]
	},
	{
		"header": "ĐẶC QUYỀN NGHỀ NGHIỆP · PHÚ THƯƠNG (THƯƠNG NHÂN NAM)",
		"wheel_index": 1,
		"is_female": false,
		"titles": ["◆ Phú Giáp Thiên Hạ:", "◆ Thông Thương Lộ Tuyến:", "◆ Trọng Thưởng Dũng Phu:"],
		"descs": [
			"+25% sản lượng Lương thảo & Bạc mỗi phút.",
			"-15% chi phí xây dựng công trình kinh tế.",
			"+10% tốc độ chiêu mộ binh lính tại doanh trại."
		]
	},
	{
		"header": "ĐẶC QUYỀN NGHỀ NGHIỆP · PHÚ THƯƠNG (THƯƠNG NHÂN NỮ)",
		"wheel_index": 1,
		"is_female": true,
		"titles": ["◆ Toán Lộ Thông Minh:", "◆ Tích Trữ Lương Tiền:", "◆ Thiên Hạ Hối Đoái:"],
		"descs": [
			"+30% sản lượng Lương thảo & Bạc mỗi phút.",
			"-20% hao tổn kinh tế khi bị bao vây.",
			"+15% giá trị trao đổi khi giao thương liên quốc."
		]
	},
	{
		"header": "ĐẶC QUYỀN NGHỀ NGHIỆP · TRẤN QUÂN (VÕ TƯỚNG NAM)",
		"wheel_index": 4,
		"is_female": false,
		"titles": ["◆ Vạn Quân Bạt Trại:", "◆ Thần Uy Thiết Giáp:", "◆ Hiệu Lệnh Ba Quân:"],
		"descs": [
			"+20% công thành & phá hủy chướng ngại vật.",
			"+15% phòng thủ thiết kỵ & giảm sát thương cung tiễn.",
			"+15% sĩ khí toàn quân khi trực tiếp lĩnh binh."
		]
	},
	{
		"header": "ĐẶC QUYỀN NGHỀ NGHIỆP · TRẤN QUÂN (VÕ TƯỚNG NỮ)",
		"wheel_index": 4,
		"is_female": true,
		"titles": ["◆ Lạc Nhạn Kiếm Quyết:", "◆ Hồng Trang Thiết Kỵ:", "◆ Thống Lĩnh Ba Quân:"],
		"descs": [
			"+25% tốc đánh & né tránh khi áp sát.",
			"+15% công kích kỵ binh & xuyên giáp.",
			"+15% phòng ngự toàn đội khi tử chiến."
		]
	},
	{
		"header": "ĐẶC QUYỀN NGHỀ NGHIỆP · ĐỐC LƯƠNG (NÔNG DÂN NAM)",
		"wheel_index": 0,
		"is_female": false,
		"titles": ["◆ Phong Điều Vũ Thuận:", "◆ Đồn Điền Tích Trữ:", "◆ Nông Chính Bản Vị:"],
		"descs": [
			"+35% sản lượng Lương thảo toàn bản đồ.",
			"-20% thời gian nâng cấp kho lương & đồn điền.",
			"+15% hồi phục sinh lực và độ no của quân đội."
		]
	},
	{
		"header": "ĐẶC QUYỀN NGHỀ NGHIỆP · ĐỐC LƯƠNG (NÔNG DÂN NỮ)",
		"wheel_index": 0,
		"is_female": true,
		"titles": ["◆ Xuân Canh Vũ Nhuận:", "◆ Tang Ma Chức Dệt:", "◆ Ẩm Thực Túc Binh:"],
		"descs": [
			"+40% tốc độ thu hoạch và sản lượng lúa mạch.",
			"-25% tiêu hao quân nhu khi di chuyển đường dài.",
			"+20% kháng bệnh tật và tăng tốc độ hồi phục quân nhu."
		]
	},
	{
		"header": "ĐẶC QUYỀN NGHỀ NGHIỆP · THIÊN CÔNG (THỢ THỦ CÔNG NAM)",
		"wheel_index": 3,
		"is_female": false,
		"titles": ["◆ Khai Vật Khởi Trí:", "◆ Thần Cơ Nỏ Máy:", "◆ Luyện Binh Đúc Giáp:"],
		"descs": [
			"+25% tốc độ chế tạo & sửa chữa chiến cụ.",
			"+15% sát thương công thành & tầm bắn tháp tiễn.",
			"-15% chi phí nâng cấp trang bị & độ bền chiến xa."
		]
	},
	{
		"header": "ĐẶC QUYỀN NGHỀ NGHIỆP · THIÊN CÔNG (THỢ THỦ CÔNG NỮ)",
		"wheel_index": 3,
		"is_female": true,
		"titles": ["◆ Xảo Đoạt Thiên Công:", "◆ Mặc Gia Cơ Quan:", "◆ Đúc Binh Luyện Khí:"],
		"descs": [
			"+25% tốc độ xây dựng & nâng cấp thành trì.",
			"+20% sát thương xe công thành & cạm bẫy phòng thủ.",
			"+15% chỉ số trang bị vũ khí/giáp trụ của toàn quân."
		]
	}
]

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color("141414"))
	custom_pointer=preload("res://scripts/gui_pointer.gd").new()
	add_child(custom_pointer)
	stage = Control.new()
	stage.name = "DesignCanvas1600x900"
	stage.size = Vector2(1600,900)
	add_child(stage)
	background = _texture(stage, LOGIN_BG, Rect2(0,0,1600,900))
	background.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	background_material=ShaderMaterial.new()
	background_material.shader=preload("res://scripts/background_motion.gdshader")
	background.material=background_material
	scene_fx=SceneEffects.new()
	stage.add_child(scene_fx)
	cloud_layer=ColorRect.new()
	cloud_layer.set_script(preload("res://scripts/cloud_sprites.gd"))
	cloud_layer.name="DriftingClouds"
	cloud_layer.size=Vector2(1600,900)
	cloud_layer.mouse_filter=Control.MOUSE_FILTER_IGNORE
	cloud_material=ShaderMaterial.new()
	cloud_material.shader=preload("res://scripts/clouds.gdshader")
	cloud_layer.material=cloud_material
	stage.add_child(cloud_layer)
	_build_login()
	_build_creation()
	creation.hide()
	factions=FactionScreen.new()
	stage.add_child(factions)
	factions.hide()
	factions.back_requested.connect(_back)
	factions.faction_changed.connect(func(index: int):selected_faction=index)
	factions.confirmed.connect(_enter_lobby)
	lobby = Control.new()
	lobby.name = "FactionLobby"
	lobby.size = Vector2(1600,900)
	lobby.mouse_filter = Control.MOUSE_FILTER_IGNORE
	stage.add_child(lobby)
	lobby.hide()
	lobby_back = _button(lobby,"‹  Chọn phe",Rect2(635,14,155,46),false)
	lobby_back.add_theme_font_size_override("font_size",18)
	lobby_back.z_index = 10
	lobby_back.pressed.connect(_back)
	var fog := ColorRect.new()
	fog.size = Vector2(1600,900)
	fog.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fog_material = ShaderMaterial.new()
	fog_material.shader = preload("res://scripts/fog.gdshader")
	fog.material = fog_material
	stage.add_child(fog)
	# Keep haze behind controls, above the scene background.
	stage.move_child(fog,1)
	dust = Atmosphere.new()
	dust.name = "WindDust"
	stage.add_child(dust)
	bg_audio_player = AudioStreamPlayer.new()
	bg_audio_player.name = "BackgroundAudioPlayer"
	bg_audio_player.bus = &"Master"
	stage.add_child(bg_audio_player)
	for key in ["login", "strategist", "merchant", "commander", "farmer", "craftsman"]:
		var audio_path: String = {
			"login": LOGIN_BG_AUDIO,
			"strategist": STRATEGIST_BG_AUDIO,
			"merchant": MERCHANT_BG_AUDIO,
			"commander": COMMANDER_BG_AUDIO,
			"farmer": FARMER_BG_AUDIO,
			"craftsman": CRAFTSMAN_BG_AUDIO,
		}[key]
		if FileAccess.file_exists(audio_path):
			var stream := AudioStreamOggVorbis.load_from_file(audio_path)
			if stream:
				stream.loop = true
				bg_audio_streams[key] = stream

	char_audio_player = AudioStreamPlayer.new()
	char_audio_player.name = "CharacterAudioPlayer"
	char_audio_player.bus = &"Master"
	stage.add_child(char_audio_player)

	wheel_sfx_player = AudioStreamPlayer.new()
	wheel_sfx_player.name = "WheelSpinSFXPlayer"
	wheel_sfx_player.stream = WHEEL_SPIN_SFX
	wheel_sfx_player.volume_db = -2.0
	stage.add_child(wheel_sfx_player)
	for path in CHAR_AUDIO_PATHS:
		if FileAccess.file_exists(path):
			var stream := AudioStreamOggVorbis.load_from_file(path)
			if stream:
				stream.loop = true
				char_audio_streams.append(stream)
			else:
				char_audio_streams.append(null)
		else:
			char_audio_streams.append(null)
	motion_button = _button(stage,"Gió & thở: Bật",Rect2(1330,838,226,42),false)
	motion_button.add_theme_font_size_override("font_size",17)
	motion_button.pressed.connect(_toggle_motion)
	motion_button.hide()
	resized.connect(_fit_canvas)
	_fit_canvas()
	# Start the login screen's ambient loop (and video state) right away.
	_sync_idle_playback()
	if "--lobby-tour" in OS.get_cmdline_user_args():
		_lobby_movie.call_deferred()
	if "--lobby" in OS.get_cmdline_user_args():
		name_input.text="Cẩm Tú"
		_enter_lobby(0)
	if "--verify" in OS.get_cmdline_user_args():
		_verify.call_deferred()
	if "--capture-chars" in OS.get_cmdline_user_args():
		_capture_chars.call_deferred()
	if "--capture" in OS.get_cmdline_user_args():
		_capture.call_deferred()
	if "--tour" in OS.get_cmdline_user_args():
		_tour.call_deferred()

func _fit_canvas() -> void:
	var s := minf(size.x/1600.0,size.y/900.0)
	stage.scale = Vector2(s,s)
	stage.position = (size-Vector2(1600,900)*s)*0.5

func _process(delta: float) -> void:
	if motion_on:
		elapsed += delta
	if fog_material:
		fog_material.set_shader_parameter("motion_time",elapsed)
	if background_material:
		background_material.set_shader_parameter("motion_time",elapsed)
	if cloud_material:
		cloud_material.set_shader_parameter("motion_time",elapsed)
		cloud_layer.advance(delta,motion_on)
	if scene_fx:
		scene_fx.advance(delta,motion_on)

func _build_login() -> void:
	login = Control.new()
	login.name = "LoginScreen"
	login.size = Vector2(1600, 900)
	stage.add_child(login)

	# 1. Animated Video Background for Login Screen
	login_bg_video = LOGIN_BG_VIDEO.instantiate() as AnimatedSprite2D
	login_bg_video.name = "LoginBackgroundVideo"
	login_bg_video.position = Vector2.ZERO
	login_bg_video.scale = Vector2(1600.0 / 960.0, 900.0 / 540.0)
	login_bg_video.modulate = Color(0.90, 0.90, 0.93, 0.95)
	login.add_child(login_bg_video)
	login_bg_video.play(&"default")

	# 2. Top-Right Quick Action Icons: Notification & Switch Account (Arranged Vertically)
	var notif_btn := LoginIconButton.new()
	notif_btn.name = "NotificationButton"
	notif_btn.icon_type = "notification"
	notif_btn.has_unread = true
	notif_btn.position = Vector2(1524, 24)
	notif_btn.size = Vector2(44, 44)
	notif_btn.tooltip_text = "Thông báo máy chủ"
	login.add_child(notif_btn)

	var account_btn := LoginIconButton.new()
	account_btn.name = "AccountSwitchButton"
	account_btn.icon_type = "account"
	account_btn.position = Vector2(1524, 76)
	account_btn.size = Vector2(44, 44)
	account_btn.tooltip_text = "Đổi tài khoản"
	login.add_child(account_btn)

	# 2B. In-Game Announcement Popup (Toggled by Notification Button)
	notice_popup = Control.new()
	notice_popup.name = "ServerNoticePopup"
	notice_popup.position = Vector2(1024, 24)
	notice_popup.size = Vector2(480, 280)
	notice_popup.z_index = 20
	notice_popup.hide()
	login.add_child(notice_popup)

	var notice_bg := LoginPanel.new()
	notice_bg.size = notice_popup.size
	notice_popup.add_child(notice_bg)

	_label(notice_popup, "THÔNG BÁO MÁY CHỦ", Rect2(20, 20, 440, 28), 18, GOLD)
	var notice_content := "Chào mừng các vị Chúa công nhập thế Tam Quốc!\n\n• Máy chủ: S1 - Xích Bích (Closed Beta)\n• Quà tân thủ: 1000 Kim Nguyên Bảo & Thần Mã Xích Thố khi tạo nhân vật.\n• Tự động đồng bộ tiến trình qua tài khoản Google."
	var notice_lbl := _label(notice_popup, notice_content, Rect2(28, 56, 424, 150), 14, Color(0.92, 0.88, 0.82))
	notice_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	notice_lbl.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	notice_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

	var close_notice_btn := _button(notice_popup, "Đã hiểu", Rect2(170, 222, 140, 40), true)
	close_notice_btn.add_theme_font_size_override("font_size", 16)
	close_notice_btn.pressed.connect(func(): notice_popup.hide())

	notif_btn.pressed.connect(func(): notice_popup.visible = not notice_popup.visible)
	account_btn.pressed.connect(func(): _select_method("google"))

	# 4. Dedicated Three Kingdoms Login Panel (Custom Drawn, Not Buff Box!)
	const CARD_W := 540.0
	const CARD_H := 416.0
	const CARD_X := 530.0
	const CARD_Y := 252.0

	var panel := LoginPanel.new()
	panel.name = "DedicatedLoginPanel"
	panel.position = Vector2(CARD_X, CARD_Y)
	panel.size = Vector2(CARD_W, CARD_H)
	login.add_child(panel)

	# 3. Main Title Calligraphy Banner (XÍCH BÍCH PHONG VÂN - Hỏa Diễm Hoàng Kim)
	# Sized 540x262 at (530, 14) to match the approved Concept 1 mockup pixel-for-pixel,
	# rendered after panel so molten flame tips drape over the top lacquer frame.
	_title(login, 0, Rect2(CARD_X, 14, CARD_W, 262))

	# High contrast, crisp readable typography on dark lacquer backing
	_label(panel, "ĐĂNG NHẬP", Rect2(20, 22, 500, 32), 22, GOLD)
	_label(panel, "Khởi hành chiến trường · Định đoạt giang sơn", Rect2(20, 54, 500, 32), 15, Color(0.98, 0.96, 0.92))

	# 5. Buttons: Identical Dimensions (420 x 62), guest button removed
	const BTN_W := 420.0
	const BTN_H := 62.0
	const BTN_X := (CARD_W - BTN_W) * 0.5 # 60.0

	# 5A. Google Login Button
	google_button = _button(panel, "   Tiếp tục với Google", Rect2(BTN_X, 110, BTN_W, BTN_H), true)
	google_button.add_theme_font_size_override("font_size", 19)
	var google_mark := Control.new()
	google_mark.set_script(preload("res://scripts/google_mark.gd"))
	google_mark.position = Vector2(28, 15)
	google_mark.size = Vector2(32, 32)
	google_button.add_child(google_mark)
	google_button.pressed.connect(func(): _select_method("google"))

	# 5B. Play Now ("Chơi ngay") Button - exact same size (420 x 62), refined smaller text
	play_button = _button(panel, "", Rect2(BTN_X, 198, BTN_W, BTN_H), false)
	# Refined title text graphic scaled down to 190x38 (user requested "chữ chơi ngay hơi nhỏ lại")
	_title(play_button, 3, Rect2((BTN_W - 190) * 0.5, 12, 190, 38))
	play_button.pressed.connect(_play)

	# 5C. Security & cloud storage note
	_label(panel, "🔒 Tài khoản an toàn  ·  Tự động lưu trữ đám mây", Rect2(20, 314, 500, 32), 14, Color(0.90, 0.86, 0.80))

	# 6. Bottom Disclaimers with high-contrast dark pill backing
	var footer_pill := ColorRect.new()
	footer_pill.color = Color(0.04, 0.04, 0.04, 0.75)
	footer_pill.position = Vector2(520, 804)
	footer_pill.size = Vector2(560, 36)
	footer_pill.mouse_filter = Control.MOUSE_FILTER_IGNORE
	login.add_child(footer_pill)

	_label(login, "Điều khoản sử dụng    ·    Chính sách bảo mật", Rect2(520, 804, 560, 36), 15, Color(0.98, 0.96, 0.92))
	_select_method("google")

func _build_creation() -> void:
	creation = Control.new()
	creation.name = "CharacterScreen"
	creation.size = Vector2(1600,900)
	stage.add_child(creation)

	# 1. Background Videos (Strategist & Merchant)
	bg_video = STRATEGIST_BG_VIDEO.instantiate() as AnimatedSprite2D
	bg_video.name = "StrategistBackgroundVideo"
	bg_video.position = Vector2.ZERO
	bg_video.scale = Vector2(1600.0 / 960.0, 900.0 / 540.0)
	creation.add_child(bg_video)
	bg_video.stop()

	merchant_bg_video = MERCHANT_BG_VIDEO.instantiate() as AnimatedSprite2D
	merchant_bg_video.name = "MerchantBackgroundVideo"
	merchant_bg_video.position = Vector2.ZERO
	merchant_bg_video.scale = Vector2(1600.0 / 960.0, 900.0 / 540.0)
	creation.add_child(merchant_bg_video)
	merchant_bg_video.stop()
	merchant_bg_video.hide()

	commander_bg_video = COMMANDER_BG_VIDEO.instantiate() as AnimatedSprite2D
	commander_bg_video.name = "CommanderBackgroundVideo"
	commander_bg_video.position = Vector2.ZERO
	commander_bg_video.scale = Vector2(1600.0 / 960.0, 900.0 / 540.0)
	creation.add_child(commander_bg_video)
	commander_bg_video.stop()
	commander_bg_video.hide()

	farmer_bg_video = FARMER_BG_VIDEO.instantiate() as AnimatedSprite2D
	farmer_bg_video.name = "FarmerBackgroundVideo"
	farmer_bg_video.position = Vector2.ZERO
	farmer_bg_video.scale = Vector2(1600.0 / 960.0, 900.0 / 540.0)
	creation.add_child(farmer_bg_video)
	farmer_bg_video.stop()
	farmer_bg_video.hide()

	craftsman_bg_video = CRAFTSMAN_BG_VIDEO.instantiate() as AnimatedSprite2D
	craftsman_bg_video.name = "CraftsmanBackgroundVideo"
	craftsman_bg_video.position = Vector2.ZERO
	craftsman_bg_video.scale = Vector2(1600.0 / 960.0, 900.0 / 540.0)
	creation.add_child(craftsman_bg_video)
	craftsman_bg_video.stop()
	craftsman_bg_video.hide()

	# 2. Hero Animated Previews on the Foreground Stone Terrace (left side, beside the landing cranes)
	_build_hero()

	# 3. Top Banner ("TẠO NHÂN VẬT") + Back Button
	_texture(creation, V6_TOP_BANNER, Rect2(400, 12, 800, 84))
	_title(creation, 2, Rect2(595, 25, 410, 58))
	back_button = preload("res://scripts/back_button.gd").new()
	back_button.position = Vector2(28, 24)
	back_button.size = Vector2(56, 44)
	creation.add_child(back_button)
	back_button.pressed.connect(_back)

	# 4. Large Right Circular Class Wheel (Vòng chọn nghề hình tròn nối sát khung màn phải)
	wheel_track_tex = _texture(creation, V6_WHEEL_TRACK, Rect2(WHEEL_CX - 440.0, WHEEL_CY - 440.0, 880.0, 880.0))
	wheel_track_tex.pivot_offset = Vector2(440.0, 440.0)
	var class_titles := ["Đốc Lương", "Phú Thương", "Kỳ Tá · Mưu Sĩ", "Thiên Công", "Trấn Quân"]

	wheel_holders.clear()
	wheel_nodes.clear()
	wheel_normal_tex.clear()
	wheel_active_tex.clear()

	for i in range(5):
		var holder := Control.new()
		holder.name = ["DocLuongSlot", "MaleMerchantPortrait", "MaleStrategistPortrait", "ThienCongSlot", "TranQuanSlot"][i]
		holder.size = Vector2(236, 236)
		creation.add_child(holder)
		wheel_holders.append(holder)
		if i < 4:
			portrait_slots.append(holder)

		var norm_tex := _texture(holder, V6_CLASS_NORMAL[i], Rect2(38, 36, 160, 160))
		var act_tex := _texture(holder, V6_CLASS_ACTIVE[i], Rect2(0, 0, 236, 236))
		act_tex.visible = (i == 2)
		norm_tex.visible = (i != 2)
		wheel_normal_tex.append(norm_tex)
		wheel_active_tex.append(act_tex)

		var w_btn := Button.new()
		w_btn.flat = true
		w_btn.toggle_mode = true
		w_btn.position = Vector2(28, 18)
		w_btn.size = Vector2(180, 190)
		w_btn.tooltip_text = class_titles[i]
		w_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		var empty_sb := StyleBoxEmpty.new()
		for st in ["normal", "hover", "pressed", "focus", "disabled"]:
			w_btn.add_theme_stylebox_override(st, empty_sb)
		w_btn.pressed.connect(_on_wheel_class_pressed.bind(i))
		holder.add_child(w_btn)
		wheel_nodes.append(w_btn)

	_set_wheel_pos(2.0)

	# 5. Vertical Stack in the Lower-Right Pocket (x = 680..1166, y = 514..854)
	# Shifted left to provide clean breathing room from the Class Title Medallion banner
	const POCKET_X := 680.0
	const POCKET_Y := 514.0

	# 5A. Vertical Buff Panel (Bảng Buff dọc)
	_texture(creation, V6_BUFF_PANEL_BG, Rect2(POCKET_X, POCKET_Y, 486, 218))
	buff_header_label = _label(creation, HERO_BUFF_DATA[0]["header"], Rect2(POCKET_X + 8.0, POCKET_Y + 16.0, 470, 26), 14, GOLD)
	for r in range(3):
		var ry := POCKET_Y + 58.0 + float(r) * 46.0
		var t_lbl := _label(creation, HERO_BUFF_DATA[0]["titles"][r], Rect2(POCKET_X + 34.0, ry, 150, 38), 13, GOLD)
		t_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		buff_title_labels.append(t_lbl)

		var d_lbl := _label(creation, HERO_BUFF_DATA[0]["descs"][r], Rect2(POCKET_X + 182.0, ry, 276, 38), 13, IVORY)
		d_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		buff_desc_labels.append(d_lbl)

	# 5B. Ornate Gender Selector Buttons ("NAM NHÂN" / "NỮ NHÂN" connected by central Bagua bridge)
	_texture(creation, V6_GENDER_BRIDGE, Rect2(POCKET_X + 215.0, 730, 56, 56))

	male_btn_tex = _texture(creation, V6_GENDER_MALE_ON, Rect2(POCKET_X, 726, 228, 64))
	var male_btn := _make_invisible_button(creation, Rect2(POCKET_X + 8.0, 734, 212, 48), "Nam nhân")
	male_btn.pressed.connect(func():
		if selected_class_wheel == 0:
			_select_strategist(6)
		elif selected_class_wheel == 1:
			_select_strategist(2)
		elif selected_class_wheel == 3:
			_select_strategist(8)
		elif selected_class_wheel == 4:
			_select_strategist(4)
		else:
			_select_strategist(0)
	)

	fem_btn_tex = _texture(creation, V6_GENDER_FEM_OFF, Rect2(POCKET_X + 258.0, 726, 228, 64))
	var fem_btn := _make_invisible_button(creation, Rect2(POCKET_X + 266.0, 734, 212, 48), "Nữ nhân")
	fem_btn.pressed.connect(func():
		if selected_class_wheel == 0:
			_select_strategist(7)
		elif selected_class_wheel == 1:
			_select_strategist(3)
		elif selected_class_wheel == 3:
			_select_strategist(9)
		elif selected_class_wheel == 4:
			_select_strategist(5)
		else:
			_select_strategist(1)
	)

	# Wire strategist_choices [0: Mưu sĩ nam, 1: Mưu sĩ nữ, 2: Thương nhân nam, 3: Thương nhân nữ]
	strategist_choices.clear()
	strategist_choices.append(male_btn)
	strategist_choices.append(fem_btn)
	strategist_choices.append(wheel_nodes[1])

	# 5C. Compact Ornate Name Input Box + "XÁC NHẬN" Button
	_texture(creation, V6_NAME_BOX_BG, Rect2(POCKET_X, 786, 302, 68))
	name_input = LineEdit.new()
	name_input.position = Vector2(POCKET_X + 54.0, 794)
	name_input.size = Vector2(234, 52)
	name_input.placeholder_text = "Nhập tên Chúa công..."
	name_input.max_length = 24
	name_input.alignment = HORIZONTAL_ALIGNMENT_LEFT
	name_input.add_theme_font_override("font", FONT)
	name_input.add_theme_font_size_override("font_size", 16)
	name_input.add_theme_color_override("font_color", IVORY)
	name_input.add_theme_color_override("font_placeholder_color", Color("969087"))
	for state in ["normal", "focus"]:
		var st := StyleBoxFlat.new()
		st.bg_color = Color(0, 0, 0, 0)
		st.border_color = Color(0, 0, 0, 0)
		st.set_border_width_all(0)
		name_input.add_theme_stylebox_override(state, st)
	creation.add_child(name_input)

	_texture(creation, V6_CONFIRM_BTN, Rect2(POCKET_X + 298.0, 786, 188, 68))
	continue_button = _make_invisible_button(creation, Rect2(POCKET_X + 306.0, 794, 172, 52), "Xác nhận", false)
	continue_button.pressed.connect(_continue_to_factions)

	# Default selection when built: Mưu sĩ nam (index 0)
	_select_strategist(0, true, false)

func _make_invisible_button(parent: Node, rect: Rect2, tooltip: String, is_toggle: bool = true) -> Button:
	var b := Button.new()
	b.flat = true
	b.toggle_mode = is_toggle
	b.position = rect.position
	b.size = rect.size
	b.tooltip_text = tooltip
	b.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	var empty_sb := StyleBoxEmpty.new()
	for st in ["normal", "hover", "pressed", "focus", "disabled"]:
		b.add_theme_stylebox_override(st, empty_sb)
	parent.add_child(b)
	return b

func _on_wheel_class_pressed(wheel_idx: int) -> void:
	var is_fem := (selected_strategist == 1 or selected_strategist == 3 or selected_strategist == 5 or selected_strategist == 7 or selected_strategist == 9)
	if wheel_idx == 0:
		# Đốc Lương · Nông Gia (Farmer)
		_select_strategist(7 if is_fem else 6)
	elif wheel_idx == 1:
		# Phú Thương: keep female if currently female
		_select_strategist(3 if is_fem else 2)
	elif wheel_idx == 2:
		# Kỳ Tá · Mưu Sĩ: keep female if currently female
		_select_strategist(1 if is_fem else 0)
	elif wheel_idx == 3:
		# Thiên Công · Thợ Thủ Công (Craftsman)
		_select_craftsman()
	elif wheel_idx == 4:
		# Trấn Quân · Võ Tướng: keep female if currently female
		_select_strategist(5 if is_fem else 4)
	else:
		_select_strategist(0, false)
		_update_wheel_visuals(wheel_idx, true)

func _select_farmer(animate_wheel: bool = true) -> void:
	var is_fem := (selected_strategist == 1 or selected_strategist == 3 or selected_strategist == 5 or selected_strategist == 7 or selected_strategist == 9)
	_select_strategist(7 if is_fem else 6, true, animate_wheel)

func _select_craftsman(animate_wheel: bool = true) -> void:
	var is_fem := (selected_strategist == 1 or selected_strategist == 3 or selected_strategist == 5 or selected_strategist == 7 or selected_strategist == 9)
	_select_strategist(9 if is_fem else 8, true, animate_wheel)

func _set_wheel_pos(p: float) -> void:
	wheel_pos = p
	if is_instance_valid(wheel_track_tex):
		wheel_track_tex.rotation = deg_to_rad((p - 2.0) * WHEEL_STEP_DEG)
	for i in range(wheel_holders.size()):
		var u := fposmod(p - float(i) + 2.5, 5.0) - 2.5
		var ang_deg := 180.0 + u * WHEEL_STEP_DEG
		var rad := deg_to_rad(ang_deg)
		var nx := WHEEL_CX + cos(rad) * WHEEL_RADIUS
		var ny := WHEEL_CY + sin(rad) * WHEEL_RADIUS
		wheel_holders[i].position = Vector2(nx - 118.0, ny - 108.0)

func _update_wheel_visuals(active_wheel_idx: int, animate: bool = true) -> void:
	selected_class_wheel = active_wheel_idx
	for i in range(wheel_nodes.size()):
		var is_act := (i == active_wheel_idx)
		wheel_active_tex[i].visible = is_act
		wheel_normal_tex[i].visible = not is_act
		wheel_holders[i].z_index = 2 if is_act else 1
		if wheel_nodes[i] != strategist_choices[2]:
			wheel_nodes[i].set_pressed_no_signal(is_act)

	var delta := fposmod(float(active_wheel_idx) - wheel_pos + 2.5, 5.0) - 2.5
	var target_pos := wheel_pos + delta
	if is_instance_valid(wheel_tween):
		wheel_tween.kill()
	if animate and absf(delta) > 0.001 and is_inside_tree():
		if is_instance_valid(wheel_sfx_player):
			wheel_sfx_player.play()
		wheel_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		wheel_tween.tween_method(_set_wheel_pos, wheel_pos, target_pos, 0.28)
	else:
		_set_wheel_pos(float(active_wheel_idx))

func _build_hero() -> void:
	contact_shadow = ColorRect.new()
	contact_shadow.name = "StrategistContactShadow"
	contact_shadow.position = Vector2(270, 812)
	contact_shadow.size = Vector2(420, 96)
	contact_shadow.mouse_filter = Control.MOUSE_FILTER_IGNORE
	shadow_material = ShaderMaterial.new()
	shadow_material.shader = preload("res://scripts/strategist_contact_shadow.gdshader")
	contact_shadow.material = shadow_material
	creation.add_child(contact_shadow)

	for scene in [STRATEGIST_IDLE, FEMALE_STRATEGIST_IDLE, MALE_MERCHANT_IDLE, FEMALE_MERCHANT_IDLE, MALE_COMMANDER_IDLE, FEMALE_COMMANDER_IDLE, MALE_FARMER_IDLE, FEMALE_FARMER_IDLE, MALE_CRAFTSMAN_IDLE, FEMALE_CRAFTSMAN_IDLE]:
		var preview := scene.instantiate() as AnimatedSprite2D
		preview.modulate = Color(0.97, 0.94, 0.90)
		preview.hide()
		creation.add_child(preview)
		preview.stop()
		strategist_previews.append(preview)

	# Enlarged and shifted right on the foreground stone terrace, closer to the info panel
	strategist_previews[0].position = Vector2(204, 114)
	strategist_previews[0].scale = Vector2.ONE * 0.98
	strategist_previews[1].position = Vector2(200, 113)
	strategist_previews[1].scale = Vector2.ONE * 1.00
	strategist_previews[2].position = Vector2(200, 115)
	strategist_previews[2].scale = Vector2.ONE * 1.00
	strategist_previews[3].position = Vector2(200, 115)
	strategist_previews[3].scale = Vector2.ONE * 1.00
	strategist_previews[4].position = Vector2(-170, 117)
	strategist_previews[4].scale = Vector2.ONE * 1.045
	strategist_previews[5].position = Vector2(-95, 116)
	strategist_previews[5].scale = Vector2.ONE * 1.048
	strategist_previews[6].position = Vector2(200, 115)
	strategist_previews[6].scale = Vector2.ONE * 1.00
	strategist_previews[7].position = Vector2(200, 115)
	strategist_previews[7].scale = Vector2.ONE * 1.00
	strategist_previews[8].position = Vector2(200, 115)
	strategist_previews[8].scale = Vector2.ONE * 1.00
	strategist_previews[9].position = Vector2(200, 115)
	strategist_previews[9].scale = Vector2.ONE * 1.00

	contact_shadow.hide()

func _select_strategist(index: int, update_wheel: bool = true, animate_wheel: bool = true) -> void:
	if selected_strategist != index and selected_strategist >= 0 and selected_strategist < strategist_previews.size():
		strategist_previews[selected_strategist].stop()
	selected_strategist = index
	for i in range(strategist_choices.size()):
		strategist_choices[i].set_pressed_no_signal(i == selected_strategist)

	if index >= 0 and index < HERO_BUFF_DATA.size():
		var data: Dictionary = HERO_BUFF_DATA[index]
		if update_wheel:
			_update_wheel_visuals(int(data["wheel_index"]), animate_wheel)
		var is_fem: bool = data["is_female"]
		male_btn_tex.texture = V6_GENDER_MALE_OFF if is_fem else V6_GENDER_MALE_ON
		fem_btn_tex.texture = V6_GENDER_FEM_ON if is_fem else V6_GENDER_FEM_OFF
		buff_header_label.text = data["header"]
		for r in range(3):
			buff_title_labels[r].text = data["titles"][r]
			buff_desc_labels[r].text = data["descs"][r]

	if is_instance_valid(shadow_material):
		shadow_material.set_shader_parameter("canvas_size", contact_shadow.size)
		if index == 1:
			shadow_material.set_shader_parameter("left_sole_center", Vector2(135.0, 50.0))
			shadow_material.set_shader_parameter("left_sole_radius", Vector2(20.0, 5.2))
			shadow_material.set_shader_parameter("right_sole_center", Vector2(174.0, 50.0))
			shadow_material.set_shader_parameter("right_sole_radius", Vector2(29.0, 5.8))
		elif index == 2:
			shadow_material.set_shader_parameter("left_sole_center", Vector2(80.4, 51.0))
			shadow_material.set_shader_parameter("left_sole_radius", Vector2(23.0, 5.5))
			shadow_material.set_shader_parameter("right_sole_center", Vector2(219.2, 40.0))
			shadow_material.set_shader_parameter("right_sole_radius", Vector2(40.0, 6.0))
		elif index == 3:
			shadow_material.set_shader_parameter("left_sole_center", Vector2(131.0, 54.0))
			shadow_material.set_shader_parameter("left_sole_radius", Vector2(20.0, 5.0))
			shadow_material.set_shader_parameter("right_sole_center", Vector2(183.0, 54.5))
			shadow_material.set_shader_parameter("right_sole_radius", Vector2(24.0, 5.2))
		elif index == 4:
			shadow_material.set_shader_parameter("left_sole_center", Vector2(72.0, 52.0))
			shadow_material.set_shader_parameter("left_sole_radius", Vector2(38.0, 6.0))
			shadow_material.set_shader_parameter("right_sole_center", Vector2(177.0, 52.0))
			shadow_material.set_shader_parameter("right_sole_radius", Vector2(38.0, 6.0))
		elif index == 5:
			shadow_material.set_shader_parameter("left_sole_center", Vector2(43.0, 54.0))
			shadow_material.set_shader_parameter("left_sole_radius", Vector2(24.0, 6.0))
			shadow_material.set_shader_parameter("right_sole_center", Vector2(232.0, 54.0))
			shadow_material.set_shader_parameter("right_sole_radius", Vector2(24.0, 6.0))
		elif index == 6:
			shadow_material.set_shader_parameter("left_sole_center", Vector2(49.7, 62.0))
			shadow_material.set_shader_parameter("left_sole_radius", Vector2(36.0, 5.5))
			shadow_material.set_shader_parameter("right_sole_center", Vector2(215.3, 47.0))
			shadow_material.set_shader_parameter("right_sole_radius", Vector2(47.5, 5.5))
		elif index == 7:
			shadow_material.set_shader_parameter("left_sole_center", Vector2(63.5, 58.0))
			shadow_material.set_shader_parameter("left_sole_radius", Vector2(25.0, 5.5))
			shadow_material.set_shader_parameter("right_sole_center", Vector2(217.0, 43.0))
			shadow_material.set_shader_parameter("right_sole_radius", Vector2(35.0, 5.5))
		elif index == 8:
			shadow_material.set_shader_parameter("left_sole_center", Vector2(48.5, 58.0))
			shadow_material.set_shader_parameter("left_sole_radius", Vector2(32.0, 5.5))
			shadow_material.set_shader_parameter("right_sole_center", Vector2(244.0, 48.0))
			shadow_material.set_shader_parameter("right_sole_radius", Vector2(36.0, 5.5))
		elif index == 9:
			shadow_material.set_shader_parameter("left_sole_center", Vector2(58.0, 58.0))
			shadow_material.set_shader_parameter("left_sole_radius", Vector2(28.0, 5.5))
			shadow_material.set_shader_parameter("right_sole_center", Vector2(215.0, 48.0))
			shadow_material.set_shader_parameter("right_sole_radius", Vector2(32.0, 5.5))
		else:
			shadow_material.set_shader_parameter("left_sole_center", Vector2(84.3, 50.7))
			shadow_material.set_shader_parameter("left_sole_radius", Vector2(23.0, 5.5))
			shadow_material.set_shader_parameter("right_sole_center", Vector2(214.0, 48.8))
			shadow_material.set_shader_parameter("right_sole_radius", Vector2(41.0, 6.2))
	if screen == "character" and is_instance_valid(background):
		if selected_class_wheel == 3 or index == 8 or index == 9:
			background.texture = CRAFTSMAN_BG_STATIC
		elif selected_class_wheel == 0 or index == 6 or index == 7:
			background.texture = FARMER_BG_STATIC
		elif index == 4 or index == 5:
			background.texture = COMMANDER_BG_STATIC
		elif index == 2 or index == 3:
			background.texture = MERCHANT_BG_STATIC
		else:
			background.texture = CHARACTER_BG
	_sync_idle_playback()

func _select_method(value: String) -> void:
	method = value
	if is_instance_valid(google_button):
		google_button.modulate = Color.WHITE if value == "google" else Color(0.86,0.86,0.86)
	if is_instance_valid(guest_button):
		guest_button.modulate = Color(1.18,1.12,1.0) if value == "guest" else Color.WHITE

func _play() -> void:
	if screen == "login" and not transitioning:
		_change_screen("character")

func _continue_to_factions() -> void:
	if screen=="character" and not transitioning:
		factions.set_player_name(name_input.text)
		_change_screen("faction")

func _enter_lobby(index: int) -> void:
	if transitioning or index < 0 or index >= LOBBY_SCENES.size():
		return
	selected_faction = index
	var scene := load(LOBBY_SCENES[index]) as PackedScene
	active_lobby = scene.instantiate() as Node2D
	active_lobby.scale = Vector2(1600.0 / 1672.0,900.0 / 941.0)
	lobby.add_child(active_lobby)
	var player_name := name_input.text.strip_edges()
	if not player_name.is_empty() and player_name != "Cẩm Tú":
		var name_rect := Rect2(151,30,139,33)
		var plate := ColorRect.new()
		plate.color = [Color("182f40"), Color("1b302a"), Color("491e16")][index]
		plate.position = name_rect.position
		plate.size = name_rect.size
		plate.mouse_filter = Control.MOUSE_FILTER_IGNORE
		active_lobby.add_child(plate)
		var title := _label(plate,player_name,Rect2(Vector2.ZERO,name_rect.size),21,IVORY)
		title.clip_text = true
		title.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	_change_screen("lobby")

func _back() -> void:
	if transitioning:return
	if screen=="lobby":
		if active_lobby.has_method("close_buildings") and active_lobby.close_buildings():
			return
		_change_screen("faction")
	elif screen=="faction":_change_screen("character")
	elif screen=="character":_change_screen("login")

func _sync_idle_playback() -> void:
	var show_preview := screen == "character" and selected_strategist >= 0
	contact_shadow.visible = show_preview
	var is_craftsman := (selected_class_wheel == 3 or selected_strategist == 8 or selected_strategist == 9)
	var is_farmer := (selected_class_wheel == 0 or selected_strategist == 6 or selected_strategist == 7) and not is_craftsman
	var is_merchant := (selected_class_wheel == 1 or selected_strategist == 2 or selected_strategist == 3) and not is_farmer and not is_craftsman
	var is_commander := (selected_class_wheel == 4 or selected_strategist == 4 or selected_strategist == 5) and not is_farmer and not is_craftsman
	var is_strategist := not is_farmer and not is_merchant and not is_commander and not is_craftsman
	if is_instance_valid(login_bg_video):
		login_bg_video.visible = (screen == "login")
		if login_bg_video.visible and motion_on:
			login_bg_video.play(&"default")
		else:
			login_bg_video.pause()
	if is_instance_valid(bg_video):
		bg_video.visible = (screen == "character" and is_strategist)
		if bg_video.visible and motion_on:
			bg_video.play(&"default")
		else:
			bg_video.pause()
	if is_instance_valid(merchant_bg_video):
		merchant_bg_video.visible = (screen == "character" and is_merchant)
		if merchant_bg_video.visible and motion_on:
			merchant_bg_video.play(&"default")
		else:
			merchant_bg_video.pause()
	if is_instance_valid(commander_bg_video):
		commander_bg_video.visible = (screen == "character" and is_commander)
		if commander_bg_video.visible and motion_on:
			commander_bg_video.play(&"default")
		else:
			commander_bg_video.pause()
	if is_instance_valid(farmer_bg_video):
		farmer_bg_video.visible = (screen == "character" and is_farmer)
		if farmer_bg_video.visible and motion_on:
			farmer_bg_video.play(&"default")
		else:
			farmer_bg_video.pause()
	if is_instance_valid(craftsman_bg_video):
		craftsman_bg_video.visible = (screen == "character" and is_craftsman)
		if craftsman_bg_video.visible and motion_on:
			craftsman_bg_video.play(&"default")
		else:
			craftsman_bg_video.pause()
	for i in range(strategist_previews.size()):
		var preview := strategist_previews[i]
		preview.visible = show_preview and i == selected_strategist
		if preview.visible and motion_on:
			preview.play(&"idle")
		else:
			preview.pause()

	# Background Ambient Audio Playback
	if is_instance_valid(bg_audio_player):
		var target_key := ""
		if screen == "login":
			target_key = "login"
		elif screen == "character" and selected_strategist >= 0:
			target_key = "craftsman" if is_craftsman else ("farmer" if is_farmer else ("commander" if is_commander else ("merchant" if is_merchant else "strategist")))
		if target_key != "":
			if current_bg_audio_key != target_key:
				current_bg_audio_key = target_key
				if bg_audio_streams.has(target_key):
					bg_audio_player.stream = bg_audio_streams[target_key]
					if motion_on:
						bg_audio_player.play()
					else:
						bg_audio_player.stop()
				else:
					bg_audio_player.stop()
			elif motion_on:
				if not bg_audio_player.playing:
					bg_audio_player.play()
				elif bg_audio_player.stream_paused:
					bg_audio_player.stream_paused = false
			else:
				bg_audio_player.stream_paused = true
		else:
			current_bg_audio_key = ""
			bg_audio_player.stop()

	# Character SFX Audio Playback
	if is_instance_valid(char_audio_player):
		if screen == "character" and selected_strategist >= 0 and selected_strategist < char_audio_streams.size():
			var stream: AudioStream = char_audio_streams[selected_strategist]
			if stream and char_audio_player.stream != stream:
				char_audio_player.stream = stream
				if motion_on:
					char_audio_player.play()
				else:
					char_audio_player.stop()
			elif motion_on:
				if stream and not char_audio_player.playing:
					char_audio_player.play()
				elif char_audio_player.stream_paused:
					char_audio_player.stream_paused = false
			else:
				char_audio_player.stream_paused = true
		else:
			char_audio_player.stop()
			char_audio_player.stream = null

func _change_screen(next: String) -> void:
	transitioning = true
	var fade := ColorRect.new()
	fade.color = Color(0.06,0.06,0.05,0.0)
	fade.size = Vector2(1600,900)
	fade.mouse_filter = Control.MOUSE_FILTER_STOP
	fade.z_index = 100
	stage.add_child(fade)
	var tw := create_tween()
	tw.tween_property(fade,"color:a",1.0,0.18)
	tw.tween_callback(func():
		var prev_screen := screen
		screen = next
		if screen == "login":
			_select_strategist(-1)
		elif screen == "character" and (prev_screen == "login" or selected_strategist < 0):
			# Default to Mưu sĩ nam (0) when entering the character creation screen
			_select_strategist(0)
		login.visible = screen == "login"
		creation.visible = screen == "character"
		factions.visible=screen=="faction"
		lobby.visible=screen=="lobby"
		if screen != "lobby" and is_instance_valid(active_lobby):
			active_lobby.queue_free()
			active_lobby = null
		_sync_idle_playback()
		dust.visible=screen!="lobby"
		motion_button.visible = false
		var char_bg: Texture2D = CRAFTSMAN_BG_STATIC if (selected_class_wheel == 3 or selected_strategist == 8) else (FARMER_BG_STATIC if (selected_class_wheel == 0 or selected_strategist == 6 or selected_strategist == 7) else (COMMANDER_BG_STATIC if (selected_class_wheel == 4 or selected_strategist == 4 or selected_strategist == 5) else (MERCHANT_BG_STATIC if (selected_class_wheel == 1 or selected_strategist == 2 or selected_strategist == 3) else CHARACTER_BG)))
		background.texture = FACTION_BG if screen=="faction" else (char_bg if screen=="character" else LOGIN_BG_STATIC)
		background_material.set_shader_parameter("login_scene",screen=="login")
		cloud_layer.visible=screen=="login"
		scene_fx.set_scene(screen)
	)
	tw.tween_property(fade,"color:a",0.0,0.28)
	tw.tween_callback(func():
		fade.queue_free()
		transitioning = false
	)

func _toggle_motion() -> void:
	motion_on = not motion_on
	if is_instance_valid(motion_button):
		motion_button.text = "Gió & thở: Bật" if motion_on else "Gió & thở: Tắt"
	dust.set("amount",1.0 if motion_on else 0.0)
	_sync_idle_playback()

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			if screen in ["character","faction","lobby"]: _back()
		elif event.keycode==KEY_M and screen=="lobby":
			var running := not active_lobby.is_processing()
			active_lobby.set_process(running)
			for child in active_lobby.get_children():
				if child.has_method("_process"):
					child.set_process(running)
		elif event.keycode == KEY_F11:
			var mode := DisplayServer.window_get_mode()
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED if mode == DisplayServer.WINDOW_MODE_FULLSCREEN else DisplayServer.WINDOW_MODE_FULLSCREEN)

func _panel(parent: Node, rect: Rect2, color: Color, portrait: bool=false) -> Control:
	var p := Control.new()
	p.set_script(Frame)
	p.position = rect.position
	p.size = rect.size
	p.fill_color = color
	p.portrait=portrait
	parent.add_child(p)
	return p

func _label(parent: Node, text: String, rect: Rect2, font_size: int, color: Color) -> Label:
	var l := Label.new()
	l.text = text
	l.position = rect.position
	l.size = rect.size
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	l.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	l.add_theme_font_override("font",FONT)
	l.add_theme_font_size_override("font_size",font_size)
	l.add_theme_color_override("font_color",color)
	l.add_theme_constant_override("outline_size", 2)
	l.add_theme_color_override("font_outline_color", Color(0.04, 0.03, 0.02, 0.95))
	l.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(l)
	return l

func _button(parent: Node, text: String, rect: Rect2, light: bool) -> Button:
	var b:=Button.new()
	b.set_script(RaisedButton)
	b.position=rect.position
	b.size=rect.size
	b.text=text
	b.light=light
	b.mouse_default_cursor_shape=Control.CURSOR_POINTING_HAND
	b.add_theme_font_override("font",FONT)
	b.add_theme_font_size_override("font_size",25)
	b.add_theme_color_override("font_color",INK if light else IVORY)
	parent.add_child(b)
	return b

func _texture(parent: Node, texture: Texture2D, rect: Rect2) -> TextureRect:
	var t := TextureRect.new()
	t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	t.texture = texture
	t.position = rect.position
	t.size = rect.size
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	t.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(t)
	return t

func _title(parent: Node, row: int, rect: Rect2) -> void:
	if row == 0:
		_texture(parent, GAME_TITLE_LOGO, rect)
		return
	var regions := [Rect2(300,0,950,278),Rect2(240,282,1060,260),Rect2(145,550,1250,235),Rect2(250,804,1040,213)]
	var atlas := AtlasTexture.new()
	atlas.atlas = IDENTITY_TITLES if row==2 else TITLES
	atlas.region = Rect2(160,690,1220,194) if row==2 else regions[row]
	_texture(parent,atlas,rect)

func _verify() -> void:
	await get_tree().create_timer(0.2).timeout
	assert(screen == "login" and login.visible and not creation.visible)
	assert(login_bg_video.visible and login_bg_video.is_playing() and login_bg_video.sprite_frames.get_frame_count(&"default") == 192)
	assert(bg_audio_streams.has("login") and bg_audio_player.playing and current_bg_audio_key == "login")
	var cloud_x: float=cloud_layer.banks[0].position.x
	await get_tree().create_timer(0.25).timeout
	assert(absf(cloud_layer.banks[0].position.x-cloud_x)>4.0)
	google_button.pressed.emit()
	assert(method == "google")
	await _click(play_button)
	await get_tree().create_timer(0.6).timeout
	assert(screen == "character" and creation.visible and not login.visible)
	assert(portrait_slots.size() == 4)
	assert(scene_fx.lantern.visible)
	assert(not cloud_layer.visible)
	assert(not background_material.get_shader_parameter("login_scene"))
	assert(bg_video.visible and bg_video.is_playing() and bg_video.sprite_frames.get_frame_count(&"default") == 96)
	assert(not merchant_bg_video.visible and merchant_bg_video.sprite_frames.get_frame_count(&"default") == 144)
	assert(not commander_bg_video.visible and commander_bg_video.sprite_frames.get_frame_count(&"default") == 192)
	assert(not farmer_bg_video.visible and farmer_bg_video.sprite_frames.get_frame_count(&"default") == 96)
	assert(not craftsman_bg_video.visible and craftsman_bg_video.sprite_frames.get_frame_count(&"default") == 144)
	# Default character on entry is Mưu sĩ nam (index 0)
	assert(selected_strategist == 0 and contact_shadow.visible)
	assert(strategist_previews[0].visible and strategist_previews[0].is_playing())
	assert(bg_audio_player != null and bg_audio_player.playing and current_bg_audio_key == "strategist")
	assert(char_audio_player != null and char_audio_player.playing)
	for i in range(strategist_previews.size()):
		assert(strategist_previews[i].sprite_frames.get_frame_count(&"idle") == [144, 190, 192, 144, 144, 144, 144, 144, 144, 144][i])
	for index in [1, 3, 4, 5, 6, 7, 8, 9, 0, 2]:
		_select_strategist(index)
		await get_tree().create_timer(0.32).timeout
		assert(selected_strategist == index and contact_shadow.visible)
		for i in range(strategist_previews.size()):
			assert(strategist_previews[i].visible == (i == index))
			assert(strategist_previews[i].is_playing() == (i == index))
		if index == 8 or index == 9:
			assert(craftsman_bg_video.visible and craftsman_bg_video.is_playing())
			assert(not bg_video.visible and not merchant_bg_video.visible and not commander_bg_video.visible and not farmer_bg_video.visible)
			assert(current_bg_audio_key == "craftsman" and bg_audio_player.playing)
		elif index == 6 or index == 7:
			assert(farmer_bg_video.visible and farmer_bg_video.is_playing())
			assert(not bg_video.visible and not merchant_bg_video.visible and not commander_bg_video.visible and not craftsman_bg_video.visible)
			assert(current_bg_audio_key == "farmer" and bg_audio_player.playing)
		elif index == 4 or index == 5:
			assert(commander_bg_video.visible and commander_bg_video.is_playing())
			assert(not bg_video.visible and not merchant_bg_video.visible and not farmer_bg_video.visible and not craftsman_bg_video.visible)
			assert(current_bg_audio_key == "commander" and bg_audio_player.playing)
		elif index == 2 or index == 3:
			assert(merchant_bg_video.visible and merchant_bg_video.is_playing())
			assert(not bg_video.visible and not commander_bg_video.visible and not farmer_bg_video.visible and not craftsman_bg_video.visible)
			assert(current_bg_audio_key == "merchant" and bg_audio_player.playing)
		else:
			assert(bg_video.visible and bg_video.is_playing())
			assert(not merchant_bg_video.visible and not commander_bg_video.visible and not farmer_bg_video.visible and not craftsman_bg_video.visible)
			assert(current_bg_audio_key == "strategist" and bg_audio_player.playing)
		assert(char_audio_player != null and char_audio_player.playing)
	# Test Craftsman (Thiên Công - wheel 3)
	_on_wheel_class_pressed(3)
	await get_tree().create_timer(0.32).timeout
	assert(selected_class_wheel == 3 and selected_strategist == 8)
	assert(craftsman_bg_video.visible and craftsman_bg_video.is_playing())
	assert(not bg_video.visible and not merchant_bg_video.visible and not commander_bg_video.visible and not farmer_bg_video.visible)
	assert(current_bg_audio_key == "craftsman" and bg_audio_player.playing)
	assert(background.texture == CRAFTSMAN_BG_STATIC)
	assert(strategist_previews[8].visible and strategist_previews[8].is_playing())
	assert(char_audio_player != null and char_audio_player.playing)
	# Test Farmer (Đốc Lương - wheel 0)
	_on_wheel_class_pressed(0)
	await get_tree().create_timer(0.32).timeout
	assert(selected_class_wheel == 0 and selected_strategist == 6)
	assert(farmer_bg_video.visible and farmer_bg_video.is_playing())
	assert(not bg_video.visible and not merchant_bg_video.visible and not commander_bg_video.visible and not craftsman_bg_video.visible)
	assert(current_bg_audio_key == "farmer" and bg_audio_player.playing)
	assert(background.texture == FARMER_BG_STATIC)
	assert(strategist_previews[6].visible and strategist_previews[6].is_playing())
	assert(char_audio_player != null and char_audio_player.playing)
	# Test Female Farmer (index 7)
	_select_strategist(7)
	await get_tree().create_timer(0.32).timeout
	assert(selected_class_wheel == 0 and selected_strategist == 7)
	assert(farmer_bg_video.visible and farmer_bg_video.is_playing())
	assert(strategist_previews[7].visible and strategist_previews[7].is_playing())
	assert(char_audio_player != null and char_audio_player.playing)
	# Switch back to Merchant (index 2) before continuing to faction
	_select_strategist(2)
	await get_tree().create_timer(0.32).timeout
	assert(selected_class_wheel == 1 and selected_strategist == 2)
	assert(merchant_bg_video.visible and merchant_bg_video.is_playing())
	assert(not farmer_bg_video.visible and not craftsman_bg_video.visible)
	name_input.text = "Cẩm Tú"
	assert(name_input.text == "Cẩm Tú")
	var before := elapsed
	await get_tree().create_timer(0.3).timeout
	assert(elapsed > before)
	_toggle_motion()
	before = elapsed
	var fx_before: float=scene_fx.clock
	await get_tree().create_timer(0.2).timeout
	assert(not strategist_previews[2].is_playing() and strategist_previews[2].visible)
	assert(not bg_video.is_playing() and not merchant_bg_video.is_playing() and not commander_bg_video.is_playing() and not farmer_bg_video.is_playing() and not craftsman_bg_video.is_playing())
	assert(bg_audio_player.stream_paused and char_audio_player.stream_paused)
	assert(is_equal_approx(elapsed,before))
	assert(is_equal_approx(scene_fx.clock,fx_before))
	_toggle_motion()
	assert(merchant_bg_video.is_playing())
	assert(not bg_audio_player.stream_paused and bg_audio_player.playing)
	assert(not char_audio_player.stream_paused and char_audio_player.playing)
	await _click(continue_button)
	await get_tree().create_timer(0.6).timeout
	assert(screen=="faction" and factions.visible and not creation.visible)
	assert(not bg_audio_player.playing and not char_audio_player.playing)
	assert(factions.confirm_button.disabled)
	for index in range(3):
		await _click(factions.buttons[index])
		assert(factions.selected==index and selected_faction==index)
		await _click(factions.confirm_button)
		await get_tree().create_timer(0.6).timeout
		assert(screen=="lobby" and lobby.visible)
		assert(active_lobby.scene_file_path==LOBBY_SCENES[index])
		for preview in strategist_previews:
			assert(not preview.visible and not preview.is_playing())
		if index==0:
			var build_button: Button = active_lobby.get_node("LobbyMenu").buttons[3]
			await _click(build_button)
			await get_tree().process_frame
			assert(active_lobby.get_node_or_null("BuildingsLayer") != null)
			_back()
			await get_tree().process_frame
			assert(screen=="lobby" and active_lobby.get_node_or_null("BuildingsLayer")==null)
		await _click(lobby_back)
		await get_tree().create_timer(0.6).timeout
		assert(screen=="faction" and not is_instance_valid(active_lobby))
	await _click(factions.back_button)
	await get_tree().create_timer(0.6).timeout
	assert(screen=="character" and name_input.text=="Cẩm Tú")
	assert(strategist_previews[2].visible and strategist_previews[2].is_playing())
	assert(current_bg_audio_key == "merchant" and bg_audio_player.playing)
	await _click(back_button)
	await get_tree().create_timer(0.6).timeout
	assert(screen == "login" and login.visible)
	assert(current_bg_audio_key == "login" and bg_audio_player.playing)
	assert(login_bg_video.visible and login_bg_video.is_playing())
	assert(not scene_fx.lantern.visible)
	assert(cloud_layer.visible)
	print("GUI_VERIFY_OK: V6 layout with animated background video, right class wheel, vertical buff panel, male/female tokens, and 4-screen flow")
	get_tree().quit()

func _mouse_button(target: Control, pressed: bool) -> void:
	var e:=InputEventMouseButton.new()
	e.position=target.get_global_rect().get_center()
	e.global_position=e.position
	e.button_index=MOUSE_BUTTON_LEFT
	e.pressed=pressed
	e.button_mask=MOUSE_BUTTON_MASK_LEFT if pressed else 0
	get_viewport().push_input(e,true)

func _hover(target: Control) -> void:
	custom_pointer.move_to(target.get_global_rect().get_center())
	var e:=InputEventMouseMotion.new()
	e.position=target.get_global_rect().get_center()
	e.global_position=e.position
	get_viewport().push_input(e,true)

func _click(target: Control) -> void:
	_hover(target)
	_mouse_button(target,true)
	await get_tree().create_timer(0.14).timeout
	if not target.toggle_mode:
		assert(target.button_pressed)
	_mouse_button(target,false)

func _snapshot(path: String) -> void:
	await get_tree().process_frame
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png(path)

func _capture_chars() -> void:
	await get_tree().create_timer(0.4).timeout
	_play()
	await get_tree().create_timer(1.0).timeout
	_select_strategist(0)
	await get_tree().create_timer(0.5).timeout
	await _snapshot("res://preview_char_male_strategist.png")
	_select_strategist(1)
	await get_tree().create_timer(0.5).timeout
	await _snapshot("res://preview_char_female_strategist.png")
	_select_strategist(2)
	await get_tree().create_timer(0.5).timeout
	await _snapshot("res://preview_char_male_merchant.png")
	_select_strategist(3)
	await get_tree().create_timer(0.5).timeout
	await _snapshot("res://preview_char_female_merchant.png")
	_select_strategist(4)
	await get_tree().create_timer(0.5).timeout
	await _snapshot("res://preview_char_male_commander.png")
	_select_strategist(5)
	await get_tree().create_timer(0.5).timeout
	await _snapshot("res://preview_char_female_commander.png")
	_select_strategist(6)
	await get_tree().create_timer(0.5).timeout
	await _snapshot("res://preview_char_male_farmer.png")
	_select_strategist(7)
	await get_tree().create_timer(0.5).timeout
	await _snapshot("res://preview_char_female_farmer.png")
	_select_strategist(8)
	await get_tree().create_timer(0.5).timeout
	await _snapshot("res://preview_char_male_craftsman.png")
	_select_strategist(9)
	await get_tree().create_timer(0.5).timeout
	await _snapshot("res://preview_char_female_craftsman.png")
	print("CHARS_CAPTURED_OK")
	get_tree().quit()

func _capture() -> void:
	await get_tree().create_timer(1.0).timeout
	await _snapshot("res://preview_login.png")
	await get_tree().create_timer(2.0).timeout
	await _snapshot("res://preview_login_motion.png")
	_hover(play_button)
	await get_tree().create_timer(0.3).timeout
	_mouse_button(play_button,true)
	await get_tree().create_timer(0.2).timeout
	await _snapshot("res://preview_button_pressed.png")
	_mouse_button(play_button,false)
	await get_tree().create_timer(1.0).timeout
	await _snapshot("res://preview_character.png")
	await get_tree().create_timer(4.5).timeout
	await _snapshot("res://preview_character_motion.png")
	name_input.text="Cẩm Tú"
	await _click(continue_button)
	await get_tree().create_timer(0.7).timeout
	await _click(factions.buttons[0])
	await get_tree().create_timer(0.35).timeout
	await _snapshot("res://preview_faction.png")
	await _click(factions.buttons[1])
	await get_tree().create_timer(0.35).timeout
	await _snapshot("res://preview_faction_shu.png")
	await _click(factions.buttons[2])
	await get_tree().create_timer(0.35).timeout
	await _snapshot("res://preview_faction_wu.png")
	await _click(factions.buttons[0])
	await _click(factions.confirm_button)
	await get_tree().create_timer(0.8).timeout
	await _snapshot("res://preview_lobby.png")
	get_tree().quit()

func _tour() -> void:
	await get_tree().create_timer(3.0).timeout
	await _click(play_button)
	await get_tree().create_timer(0.6).timeout
	await _click(strategist_choices[0])
	await get_tree().create_timer(1.9).timeout
	name_input.text="Cẩm Tú"
	await get_tree().create_timer(0.5).timeout
	await _click(continue_button)
	await get_tree().create_timer(0.8).timeout
	for index in range(3):
		await _click(factions.buttons[index])
		await get_tree().create_timer(2.2).timeout
	await _click(factions.buttons[0])
	await _click(factions.confirm_button)
	await get_tree().create_timer(4.0).timeout
	await _snapshot("res://preview_lobby.png")
	assert(screen=="lobby")
	get_tree().quit()

func _lobby_movie()->void:
	name_input.text="Cẩm Tú"
	_enter_lobby(0)
	await get_tree().create_timer(1.0).timeout
	await _snapshot("res://preview_lobby.png")
	await get_tree().create_timer(2.0).timeout
	await _snapshot("res://preview_lobby_motion.png")
	get_tree().quit()
