extends SceneTree

func _init() -> void:
	var src_dir := "C:/Users/tu.ngo/.gemini/antigravity/brain/a8c7f169-12e1-4f8a-a381-294003bec1df/scratch/merchant_bg_atlases"
	var dst_dir := ProjectSettings.globalize_path("res://assets/merchant_bg_video")
	DirAccess.make_dir_recursive_absolute(dst_dir)

	# Save static fallback texture (frame 0)
	var f0 := Image.new()
	if f0.load(src_dir + "/bg_static.png") == OK:
		f0.save_webp(dst_dir + "/bg_static.webp", false, 0.90)
		print("Saved merchant bg_static.webp")

	# Convert 9 atlas pages
	for i in range(9):
		var png_path := src_dir + "/bg_%d.png" % i
		var webp_path := dst_dir + "/bg_%d.webp" % i
		var img := Image.new()
		var err := img.load(png_path)
		assert(err == OK, "Failed to load " + png_path)
		assert(img.get_width() == 3840 and img.get_height() == 2160)
		err = img.save_webp(webp_path, false, 0.85)
		assert(err == OK, "Failed to save " + webp_path)
		print("Converted merchant bg_%d.webp" % i)

	# Generate res://assets/merchant_bg_video/bg_video.tscn (144 frames, 24 fps, 4x4 grid of 960x540 per page)
	var tscn := "[gd_scene load_steps=156 format=3]\n\n"
	for i in range(9):
		tscn += '[ext_resource type="Texture2D" path="res://assets/merchant_bg_video/bg_%d.webp" id="%d"]\n' % [i, i + 1]
	tscn += "\n"
	for f in range(144):
		var page := (f / 16) + 1
		var slot := f % 16
		var col := slot % 4
		var row := slot / 4
		tscn += '[sub_resource type="AtlasTexture" id="BgFrame_%03d"]\n' % f
		tscn += 'atlas = ExtResource("%d")\n' % page
		tscn += 'region = Rect2(%d, %d, 960, 540)\n' % [col * 960, row * 540]
		tscn += 'filter_clip = true\n\n'
	tscn += '[sub_resource type="SpriteFrames" id="BgFrames"]\n'
	tscn += 'animations = [{\n"frames": [\n'
	for f in range(144):
		var comma := "," if f < 143 else ""
		tscn += '{"duration": 1.0, "texture": SubResource("BgFrame_%03d")}%s\n' % [f, comma]
	tscn += '],\n"loop": true,\n"name": &"default",\n"speed": 24.0\n}]\n\n'
	tscn += '[node name="MerchantBgVideo" type="AnimatedSprite2D"]\n'
	tscn += 'centered = false\n'
	tscn += 'scale = Vector2(1.6666667, 1.6666667)\n'
	tscn += 'sprite_frames = SubResource("BgFrames")\n'
	tscn += 'animation = &"default"\n'
	var file := FileAccess.open("res://assets/merchant_bg_video/bg_video.tscn", FileAccess.WRITE)
	file.store_string(tscn)
	file.close()
	print("Generated res://assets/merchant_bg_video/bg_video.tscn (144 frames)")
	quit(0)
