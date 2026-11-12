extends SceneTree

func _init() -> void:
	print("--- STARTING FEMALE STRATEGIST REFINEMENT ---")
	var base_dir := ProjectSettings.globalize_path("res://assets/female_flow_idle")

	# 1. Load all 8 atlas images
	var atlases: Array[Image] = []
	for p in range(8):
		var img_path := base_dir + "/idle_%d.webp" % p
		var img := Image.new()
		var err := img.load(img_path)
		assert(err == OK, "Failed to load " + img_path)
		atlases.append(img)
	print("Loaded 8 existing atlas pages (2160x3840).")

	# Extract all 192 individual 432x768 frames
	var frames: Array[Image] = []
	for f in range(192):
		var p := f / 25
		var slot := f % 25
		var col := slot % 5
		var row := slot / 5
		var cell := atlases[p].get_region(Rect2i(col * 432, row * 768, 432, 768))
		frames.append(cell)
	print("Extracted 192 frame cells.")

	# 2. FIX PROBLEM 2: Smooth Constant-Velocity Loop across transition (Frames 172..191)
	# The original easing slowed down to near-zero velocity at frames 188..191, causing a freeze.
	# We linearly interpolate between frame 171 and frame 0 over 20 frames so velocity stays constant!
	var f171 := frames[171]
	var f0 := frames[0]
	var transition_len := 20 # frames 172 to 191

	for k in range(1, transition_len + 1):
		var f_idx := 171 + k
		var w: float = float(k) / float(transition_len + 1) # strictly inside (0, 1)
		var blended := Image.create(432, 768, false, Image.FORMAT_RGBA8)
		for y in range(768):
			for x in range(432):
				var c1 := f171.get_pixel(x, y)
				var c2 := f0.get_pixel(x, y)
				var a1 := c1.a
				var a2 := c2.a
				var out_a: float = a1 * (1.0 - w) + a2 * w
				if out_a <= 0.005:
					blended.set_pixel(x, y, Color(0, 0, 0, 0))
					continue
				# Premultiplied blend to avoid dark seams
				var out_r: float = (c1.r * a1 * (1.0 - w) + c2.r * a2 * w) / out_a
				var out_g: float = (c1.g * a1 * (1.0 - w) + c2.g * a2 * w) / out_a
				var out_b: float = (c1.b * a1 * (1.0 - w) + c2.b * a2 * w) / out_a
				blended.set_pixel(x, y, Color(out_r, out_g, out_b, out_a))
		frames[f_idx] = blended
	print("Re-interpolated frames 172..191 with constant linear velocity.")

	# 3. FIX PROBLEM 1: Hair Defringe across ALL 192 frames
	# Remove whitish/light grayish fringe from semi-transparent hair wisps.
	var defringed_count := 0
	for f in range(192):
		var img := frames[f]
		for y in range(30, 310):
			for x in range(80, 350):
				var c := img.get_pixel(x, y)
				# Only touch semi-transparent edge pixels
				if c.a > 0.02 and c.a < 0.96:
					# Check if this pixel is in the face/skin region
					# Face skin is centrally located at x: 195..255, y: 110..220 and has warm tone (r > b + 0.1)
					var is_face_skin := (x >= 195 and x <= 255 and y >= 110 and y <= 220 and c.r > c.b + 0.08)
					# Fan is at y >= 250
					var is_fan := (y >= 250)
					# Hair flower ornament on top: x: 200..245, y: 35..65
					var is_ornament := (x >= 200 and x <= 245 and y >= 35 and y <= 65 and (c.r > 0.6 or c.g > 0.6))
					# Jade earrings: x: 195..215, y: 175..215 or x: 245..265, y: 175..215 with high G
					var is_earring := (y >= 175 and y <= 215 and ((x >= 195 and x <= 215) or (x >= 245 and x <= 265)) and c.g > c.r + 0.05 and c.g > c.b + 0.05)

					if not is_face_skin and not is_fan and not is_ornament and not is_earring:
						# Hair wisp pixel!
						var lum: float = 0.299 * c.r + 0.587 * c.g + 0.114 * c.b
						if lum > 0.18:
							# Defringe to deep natural ebony hair tone while preserving exact alpha coverage!
							# Target hair color: (0.09, 0.09, 0.11)
							var target_r := 0.09
							var target_g := 0.09
							var target_b := 0.11
							var factor: float = clamp((lum - 0.15) / 0.35, 0.0, 1.0)
							c.r = lerp(c.r, target_r, factor)
							c.g = lerp(c.g, target_g, factor)
							c.b = lerp(c.b, target_b, factor)
							img.set_pixel(x, y, c)
							defringed_count += 1
	print("Defringed %d hair edge pixels across 192 frames." % defringed_count)

	# 4. Re-pack all 192 frames into 8 atlas pages and save as WebP
	print("Re-packing into 8 atlas WebP files...")
	for p in range(8):
		var atlas_img := Image.create(5 * 432, 5 * 768, false, Image.FORMAT_RGBA8)
		var start_f := p * 25
		var end_f := mini(192, (p + 1) * 25)
		for f in range(start_f, end_f):
			var slot := f - start_f
			var col := slot % 5
			var row := slot / 5
			atlas_img.blit_rect(frames[f], Rect2i(0, 0, 432, 768), Vector2i(col * 432, row * 768))

		var dst_path := base_dir + "/idle_%d.webp" % p
		var err := atlas_img.save_webp(dst_path, false, 0.88)
		assert(err == OK, "Failed to save " + dst_path)
		print("Saved %s" % dst_path)

	# 5. Measure new motion velocity near loop point to verify fix
	print("\n--- NEW MOTION VELOCITY NEAR LOOP POINT ---")
	for i in range(165, 192):
		var next_idx := (i + 1) % 192
		var img1 := frames[i]
		var img2 := frames[next_idx]
		var diff_sum := 0.0
		var changed_px := 0
		for y in range(0, 768, 2):
			for x in range(0, 432, 2):
				var c1 := img1.get_pixel(x, y)
				var c2 := img2.get_pixel(x, y)
				var d: float = abs(c1.r - c2.r) + abs(c1.g - c2.g) + abs(c1.b - c2.b) + abs(c1.a - c2.a)
				if d > 0.02:
					diff_sum += d
					changed_px += 1
		print("New Frame %3d -> %3d: diff = %7.1f, changed_px = %5d" % [i, next_idx, diff_sum, changed_px])

	# Save diagnostic hair crop of frame 0 and 180 to scratch for visual inspection
	var hair_rect := Rect2i(130, 60, 180, 200)
	frames[0].get_region(hair_rect).save_png("C:/Users/tu.ngo/.gemini/antigravity/brain/a8c7f169-12e1-4f8a-a381-294003bec1df/scratch/female_hair_fixed_f000.png")
	frames[180].get_region(hair_rect).save_png("C:/Users/tu.ngo/.gemini/antigravity/brain/a8c7f169-12e1-4f8a-a381-294003bec1df/scratch/female_hair_fixed_f180.png")
	print("\nSUCCESS: Female strategist hair defringed and loop smoothed.")
	quit(0)
