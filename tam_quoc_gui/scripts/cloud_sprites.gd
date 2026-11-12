extends ColorRect
## Separate visible cloud sprites, not a haze or a warp of the whole background.
const CLOUD=preload("res://assets/cloud_bank.png")
var banks: Array[TextureRect]=[]
var cloud_material: ShaderMaterial
var clock:=0.0
var speeds: Array[float]=[26.0,18.0,32.0]
var starts: Array[float]=[130.0,850.0,-390.0]

func _ready() -> void:
 cloud_material=ShaderMaterial.new()
 cloud_material.shader=preload("res://scripts/cloud_sprite_clip.gdshader")
 var atlas:=AtlasTexture.new()
 atlas.atlas=CLOUD
 # Filled after inspecting the generated alpha bounds; keep the cloud separate.
 atlas.region=Rect2(21,155,2073,407)
 for i in range(3):
  var bank:=TextureRect.new()
  bank.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
  bank.texture=atlas
  bank.stretch_mode=TextureRect.STRETCH_SCALE
  bank.size=Vector2(920,205) if i==0 else Vector2(740,150)
  bank.position=Vector2(starts[i],105.0+float(i)*67.0)
  bank.modulate=Color(1.0,0.97,0.93,[0.72,0.48,0.56][i])
  bank.material=cloud_material
  bank.mouse_filter=Control.MOUSE_FILTER_IGNORE
  add_child(bank)
  banks.append(bank)

func advance(delta: float, running: bool) -> void:
 if running: clock+=delta
 var view_size:=get_viewport_rect().size
 var r:=get_global_rect()
 cloud_material.set_shader_parameter("canvas_rect",Vector4(r.position.x/view_size.x,r.position.y/view_size.y,r.size.x/view_size.x,r.size.y/view_size.y))
 for i in range(banks.size()):
  banks[i].position.x=fposmod(starts[i]+clock*speeds[i]+1100.0,3000.0)-1100.0
