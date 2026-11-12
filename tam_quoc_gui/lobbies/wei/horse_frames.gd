extends Node2D
var clock:=0.0
var offset:=0.0
var frames:Array[Texture2D]=[]
var frame_index:=0
func _ready()->void:
 var sheet:Texture2D=load("res://lobbies/wei/horse_frames.png")
 var cell:=Vector2(sheet.get_width()/4.0,sheet.get_height()/2.0)
 for i in range(8):
  var tex:=AtlasTexture.new()
  tex.atlas=sheet
  tex.region=Rect2(Vector2(i%4,i/4)*cell,cell)
  frames.append(tex)
 var shader:=Shader.new()
 shader.code="shader_type canvas_item; void fragment(){vec4 c=texture(TEXTURE,UV);c.a*=smoothstep(.35,.72,c.a);COLOR=c;}"
 var mat:=ShaderMaterial.new()
 mat.shader=shader
 material=mat
func _process(delta:float)->void:
 clock+=delta
 var phase:=fposmod(clock+offset,7.6)
 frame_index=0
 if phase>=.6 and phase<1.44:
  var sequence:Array[int]=[0,1,2,1,3,0]
  frame_index=sequence[clampi(int((phase-.6)/.14),0,5)]
 elif phase>=4 and phase<4.75:
  var sequence:Array[int]=[4,5,6,7,0]
  frame_index=sequence[clampi(int((phase-4)/.15),0,4)]
 queue_redraw()
func _draw()->void:
 if not frames.is_empty():draw_texture_rect(frames[frame_index],Rect2(0,0,250,250),false)
