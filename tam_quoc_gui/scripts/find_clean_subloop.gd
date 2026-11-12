extends SceneTree

func _init() -> void:
	var base_dir := ProjectSettings.globalize_path("res://assets/female_flow_idle")
	var atlases: Array[Image] = []
	for p in range(7):
		var img := Image.new()
		img.load(base_dir + "/idle_%d.webp" % p)
		atlases.append(img)

	var frames: Array[Image] = []
	for f in range(172): # only real un-morphed frames
		var p := f / 25
		var slot := f % 25
		var col := slot % 5
		var row := slot / 5
		frames.append(atlases[p].get_region(Rect2i(col * 432, row * 768, 432, 768)))

	print("Loaded 172 un-morphed frames. Searching for best natural loop (A, B)...")
	# Search all (A, B) where B - A >= 72 (>= 3.0s)
	var best_diff := 999999.0
	var best_a := -1
	var best_b := -1

	for span in range(72, 170):
		for a in range(0, 172 - span, 2):
			var b := a + span
			var diff := 0.0
			for y in range(50, 450, 4):
				for x in range(100, 350, 4):
					var c1 := frames[a].get_pixel(x, y)
					var c2 := frames[b].get_pixel(x, y)
					diff += abs(c1.r - c2.r) + abs(c1.g - c2.g) + abs(c1.b - c2.b)
			if diff < best_diff:
				best_diff = diff
				best_a = a
				best_b = b
				print("Better loop: A=%d, B=%d (span=%d, %.2fs), diff=%.1f" % [a, b, span, float(span)/24.0, diff])

	print("\nOVERALL BEST: A=%d, B=%d, span=%d frames (%.2f s)" % [best_a, best_b, best_b - best_a, float(best_b - best_a)/24.0])
	quit(0)
