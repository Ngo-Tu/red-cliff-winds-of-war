extends SceneTree

func _init() -> void:
	var base_dir := ProjectSettings.globalize_path("res://assets/female_flow_idle")
	var atlases: Array[Image] = []
	for p in range(7):
		var img := Image.new()
		img.load(base_dir + "/idle_%d.webp" % p)
		atlases.append(img)

	var f64 := atlases[64 / 25].get_region(Rect2i((64 % 25 % 5) * 432, (64 % 25 / 5) * 768, 432, 768))
	var f165 := atlases[165 / 25].get_region(Rect2i((165 % 25 % 5) * 432, (165 % 25 / 5) * 768, 432, 768))

	var head_rect := Rect2i(130, 60, 180, 200)
	f64.get_region(head_rect).save_png("C:/Users/tu.ngo/.gemini/antigravity/brain/a8c7f169-12e1-4f8a-a381-294003bec1df/scratch/compare_f64.png")
	f165.get_region(head_rect).save_png("C:/Users/tu.ngo/.gemini/antigravity/brain/a8c7f169-12e1-4f8a-a381-294003bec1df/scratch/compare_f165.png")
	print("Saved compare_f64.png and compare_f165.png")
	quit(0)
