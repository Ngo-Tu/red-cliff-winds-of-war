extends Control
## Uses the approved ink/copper artwork itself, as a nine-slice texture.
const PHYSICAL=preload("res://assets/physical_surfaces.png")
const SOURCE = preload("res://assets/gui_reference.png")
const FACTION_SOURCE=preload("res://assets/faction_materials.png")
const FACTION_REGIONS=[Rect2(1136,534,513,208),Rect2(579,534,512,208),Rect2(23,534,511,208)]
@export var faction_index: int=-1
@export var fill_color := Color("242321")
@export var border_color := Color("a58b62")
@export var corners := true
@export var inset := 6.0
@export var portrait := false
var surface: StyleBoxTexture
var clip_material: ShaderMaterial

func _ready() -> void:
 mouse_filter = Control.MOUSE_FILTER_IGNORE
 surface = StyleBoxTexture.new()
 var atlas := AtlasTexture.new()
 atlas.atlas=FACTION_SOURCE if faction_index>=0 else SOURCE
 atlas.region=FACTION_REGIONS[faction_index] if faction_index>=0 else (Rect2(694,766,111,110) if portrait else Rect2(881,437,619,165))
 atlas.filter_clip=true
 surface.texture=atlas
 surface.texture_margin_left=19 if portrait else 38
 surface.texture_margin_right=19 if portrait else 38
 surface.texture_margin_top=19 if portrait else 38
 surface.texture_margin_bottom=19 if portrait else 38
 clip_material=ShaderMaterial.new()
 clip_material.shader=preload("res://scripts/frame_clip.gdshader")
 clip_material.set_shader_parameter("physical_surfaces",PHYSICAL)
 material=clip_material
 resized.connect(queue_redraw)
 queue_redraw()

func _draw() -> void:
 if not surface: return
 clip_material.set_shader_parameter("frame_size",size)
 clip_material.set_shader_parameter("material_kind",faction_index)
 clip_material.set_shader_parameter("corner_cut",10.0 if portrait else 12.0)
 draw_style_box(surface,Rect2(Vector2.ZERO,size))
