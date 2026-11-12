shader_type canvas_item;
void fragment(){
 vec2 uv=vec2(0.35+UV.x*0.30,0.015+UV.y*0.20);
 vec4 pixel=texture(TEXTURE,uv);
 float radius=length(UV-vec2(0.5));
 float inside=1.0-smoothstep(0.47,0.49,radius);
 vec3 color=mix(vec3(0.055,0.09,0.12),pixel.rgb,pixel.a);
 float border=smoothstep(0.445,0.455,radius);
 color=mix(color,vec3(0.66,0.69,0.70),border);
 COLOR=vec4(color,inside);
}
