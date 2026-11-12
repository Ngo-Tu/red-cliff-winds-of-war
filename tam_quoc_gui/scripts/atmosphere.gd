extends Node2D
var clock := 0.0
var amount := 1.0
func _process(delta: float) -> void:
 clock += delta * amount
 queue_redraw()
func _draw() -> void:
 for i in range(26):
  var seed_value := float(i)
  var x := fposmod(seed_value*137.31+clock*(5.0+fmod(seed_value,4.0)),1600.0)
  var y := 180.0+fmod(seed_value*73.1,650.0)+sin(clock*0.6+seed_value)*9.0
  draw_circle(Vector2(x,y),0.8+fmod(seed_value,3.0)*0.35,Color(0.92,0.81,0.56,0.12+0.08*sin(clock+seed_value)))
