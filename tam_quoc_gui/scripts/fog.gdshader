shader_type canvas_item;
uniform float motion_time = 0.0;
uniform float motion_amount = 1.0;
float hash(vec2 p) { return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453); }
float noise(vec2 p) {
 vec2 i=floor(p); vec2 f=fract(p); f=f*f*(3.0-2.0*f);
 return mix(mix(hash(i),hash(i+vec2(1.,0.)),f.x),mix(hash(i+vec2(0.,1.)),hash(i+vec2(1.)),f.x),f.y);
}
void fragment() {
 vec2 p=UV*vec2(5.0,9.0)+vec2(-motion_time*0.026, motion_time*0.007);
 float n=noise(p)+0.5*noise(p*2.1);
 float low=smoothstep(0.38,0.9,UV.y)*(1.0-smoothstep(0.92,1.0,UV.y));
 COLOR=vec4(vec3(0.84,0.80,0.70),smoothstep(0.65,1.2,n)*0.10*low*motion_amount);
}
