extends Node2D
## Twenty slow leaves, staggered emissions alternating every 2.2 and 2.8 seconds.
const LEAF_COUNT:=20
const FALL_HEIGHT:=880.0
const ANGLE_RADIANS:=PI/6.0
const CYCLE_SECONDS:=50.0
var clock:=0.0
static func emission_time(index:int)->float:
 return float(index/2)*5.0+(2.2 if index%2==1 else 0.0)
static func leaf_position(index:int,time:float)->Vector2:
 var age:=fposmod(time-emission_time(index),CYCLE_SECONDS)
 var travel:=age*FALL_HEIGHT/CYCLE_SECONDS
 var start_x:=-180.0+fposmod(float(index)*397.0,1390.0)
 var flutter:=sin(time*0.55+float(index)*1.6)*4.0
 return Vector2(start_x+travel*tan(ANGLE_RADIANS)+flutter,-38.0+travel)
func _draw()->void:
 for i in range(LEAF_COUNT):
  var pos:=leaf_position(i,clock)
  var t:=(pos.y+38.0)/FALL_HEIGHT
  var alpha:=smoothstep(0.0,0.07,t)*(1.0-smoothstep(0.87,1.0,t))*0.82
  var width:=4.3+float(i%3)*0.8
  var flip:=0.45+absf(sin(clock*0.7+i))*0.55
  draw_set_transform(pos,clock*(0.22+(i%3)*0.06)+i,Vector2(1,flip))
  var leaf:=PackedVector2Array([Vector2(-width,0),Vector2(-width*0.35,-width*0.45),Vector2(width,0),Vector2(width*0.2,width*0.4)])
  draw_colored_polygon(leaf,Color(0.68+(i%3)*0.04,0.55+(i%4)*0.025,0.20,alpha))
  draw_line(Vector2(-width,0),Vector2(width*0.8,0),Color(0.3,0.28,0.1,alpha*0.65),0.7,true)
 draw_set_transform(Vector2.ZERO)
 # A single very faint gust complements cloth/canopy motion without busy streaks.
 var gust:=fmod(clock*0.025,1.0)
 var points:=PackedVector2Array()
 for j in range(24):
  var u:=j/23.0
  points.append(Vector2(340+gust*730-u*90,410+sin(u*PI*1.3+gust*4)*12))
 draw_polyline(points,Color(0.8,0.87,0.83,sin(gust*PI)*0.035),0.8,true)
