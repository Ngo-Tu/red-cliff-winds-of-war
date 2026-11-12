@tool
extends SceneTree

func _init() -> void:
	print("--- INSPECTING FEMALE STRATEGIST IDLE FRAMES ---")
	var scene: PackedScene = load("res://assets/female_flow_idle/idle.tscn")
	if not scene:
		print("ERROR: Could not load female idle.tscn")
		quit(1)
		return

	var sprite: AnimatedSprite2D = scene.instantiate() as AnimatedSprite2D
	var frames: SpriteFrames = sprite.sprite_frames
	var count := frames.get_frame_count(&"idle")
	var fps := frames.get_animation_speed(&"idle")
	var is_loop := frames.get_animation_loop(&"idle")
	print("Frame count: ", count, ", FPS: ", fps, ", Loop: ", is_loop)

	# Load all frame images from atlas textures
	var images: Array[Image] = []
	for i in range(count):
		var tex := frames.get_frame_texture(&"idle", i) as AtlasTexture
		var full_img := tex.atlas.get_image()
		var cell_img := full_img.get_region(Rect2i(tex.region))
		images.append(cell_img)

	print("Loaded ", images.size(), " frame images (432x768).")

	# 1. Analyze frame differences
	print("\n--- FRAME DIFFERENCES (Motion Velocity) ---")
	var max_diff := 0.0
	var min_diff := 999999.0
	for i in range(count):
		var next_idx := (i + 1) % count
		var img1 := images[i]
		var img2 := images[next_idx]
		var diff_sum := 0.0
		var changed_pixels := 0
		for y in range(0, 768, 2):
			for x in range(0, 432, 2):
				var c1 := img1.get_pixel(x, y)
				var c2 := img2.get_pixel(x, y)
				var d: float = abs(c1.r - c2.r) + abs(c1.g - c2.g) + abs(c1.b - c2.b) + abs(c1.a - c2.a)
				if d > 0.02:
					diff_sum += d
					changed_pixels += 1
		if i >= 160 or i < 10:
			print("Frame %3d -> %3d: diff_sum = %8.1f, changed_px = %5d" % [i, next_idx, diff_sum, changed_pixels])

	# 2. Inspect hair area (x: 100..320, y: 50..260) for background color remnants
	print("\n--- HAIR PIXEL ANALYSIS ---")
	# Sample frame 0, 50, 100, 150, 180
	for f in [0, 50, 100, 150, 180]:
		var img := images[f]
		var green_spill_count := 0
		var magenta_spill_count := 0
		var white_spill_count := 0
		var semi_trans_count := 0
		for y in range(50, 260):
			for x in range(100, 320):
				var c := img.get_pixel(x, y)
				if c.a > 0.05 and c.a < 0.95:
					semi_trans_count += 1
					# Check green spill (G > R and G > B)
					if c.g > c.r + 0.1 and c.g > c.b + 0.1:
						green_spill_count += 1
					# Check magenta spill (R > G + 0.1 and B > G + 0.1)
					if c.r > c.g + 0.1 and c.b > c.g + 0.1:
						magenta_spill_count += 1
					# Check white / bright haze (R > 0.7, G > 0.7, B > 0.7 on dark hair)
					if c.r > 0.65 and c.g > 0.65 and c.b > 0.65:
						white_spill_count += 1
		print("Frame %3d Hair: semi_trans=%d, green_spill=%d, magenta_spill=%d, white_spill=%d" % [
			f, semi_trans_count, green_spill_count, magenta_spill_count, white_spill_count
		])

	# Also save crops of the hair for frame 0, 90, 180 to scratch
	var hair_rect := Rect2i(130, 60, 180, 200)
	images[0].get_region(hair_rect).save_png("C:/Users/tu.ngo/.gemini/antigravity/brain/a8c7f169-12e1-4f8a-a381-294003bec1df/scratch/female_hair_f000.png")
	images[90].get_region(hair_rect).save_png("C:/Users/tu.ngo/.gemini/antigravity/brain/a8c7f169-12e1-4f8a-a381-294003bec1df/scratch/female_hair_f090.png")
	images[180].get_region(hair_rect).save_png("C:/Users/tu.ngo/.gemini/antigravity/brain/a8c7f169-12e1-4f8a-a381-294003bec1df/scratch/female_hair_f180.png")
	images[count - 1].get_region(hair_rect).save_png("C:/Users/tu.ngo/.gemini/antigravity/brain/a8c7f169-12e1-4f8a-a381-294003bec1df/scratch/female_hair_last.png")

	print("\nSaved hair crops to scratch.")
	quit(0)
