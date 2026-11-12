shader_type canvas_item;
uniform float motion_time=0.0;
uniform bool login_scene=true;
void fragment(){
 vec2 p=UV;
 vec2 q=p;
 if(login_scene){
  // The curtain's actual left contour; ceiling and tie point stay anchored.
  float edge;
  if(p.y<0.36) edge=mix(0.80,0.978,smoothstep(0.0,0.36,p.y));
  else edge=mix(0.978,0.917,smoothstep(0.36,0.94,p.y));
  float cloth=smoothstep(edge-0.006,edge+0.009,p.x);
  float anchor=smoothstep(0.015,0.19,p.y)*(1.0-exp(-pow((p.y-0.36)/0.075,2.0)));
  q.x+=cloth*anchor*(sin(motion_time*1.05+p.y*8.0)*0.0038+sin(motion_time*1.8+p.y*18.0)*0.0010);
  q.y+=cloth*anchor*sin(motion_time*1.25+p.y*13.0)*0.0007;

 }
 vec4 base=texture(TEXTURE,clamp(q,vec2(0.001),vec2(0.999)));

 COLOR=base;
}
