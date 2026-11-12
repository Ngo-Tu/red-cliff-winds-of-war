shader_type canvas_item;
uniform float clock=0.;
void fragment(){
 vec2 uv=UV;
 uv.x+=sin(UV.y*85.+clock*1.4)*.004;
 vec4 c=texture(TEXTURE,uv);
 c.rgb=mix(c.rgb,vec3(.21,.40,.47),.45);
 c.a*=.20*smoothstep(.05,.95,UV.y);
 COLOR=c;
}
