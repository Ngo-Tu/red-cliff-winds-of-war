shader_type canvas_item;
#include "res://scripts/surface_material.gdshaderinc"
uniform int material_kind=-1;
uniform vec2 frame_size = vec2(600.0,400.0);
uniform float corner_cut = 12.0;
varying vec2 point;
void vertex() { point=VERTEX; }
void fragment() {
 vec4 c=texture(TEXTURE,UV);
 vec2 p=min(point,frame_size-point);
 // Cut only the ivory paper outside the reference's bevelled silhouette.
 float edge=p.x+p.y-corner_cut;
 c.a*=smoothstep(-0.7,0.7,edge);
 // The reference is on ivory paper: only remove paper at the outer two pixels.
 float outer=min(p.x,p.y);
 float paper=smoothstep(0.70,0.88,min(c.r,min(c.g,c.b)));
 c.a*=1.0-paper*(1.0-smoothstep(1.0,3.0,outer));
 float warm_paper=step(0.035,c.r-c.b)*step(0.015,c.g-c.b)*smoothstep(0.70,0.86,min(c.r,min(c.g,c.b)));
 c.a*=1.0-warm_paper*(1.0-smoothstep(20.0,42.0,p.x+p.y));
 if(material_kind>=0){
  float inside=smoothstep(14.0,23.0,min(p.x,p.y))*smoothstep(48.0,68.0,p.x+p.y);
  c.rgb=mix(c.rgb,material_surface(point,material_kind),inside);
 }
 COLOR=c;
}
