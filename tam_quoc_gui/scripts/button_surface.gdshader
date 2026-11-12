shader_type canvas_item;
#include "res://scripts/surface_material.gdshaderinc"
uniform int material_kind=-1;
uniform vec2 frame_size=vec2(350.0,67.0);
varying vec2 point;
void vertex(){point=VERTEX;}
void fragment(){
 if(material_kind>=0){
  vec2 edge=min(point,frame_size-point);
  float interior=smoothstep(12.0,20.0,min(edge.x,edge.y));
  COLOR.rgb=mix(COLOR.rgb,material_surface(point,material_kind),interior);
 }
}
