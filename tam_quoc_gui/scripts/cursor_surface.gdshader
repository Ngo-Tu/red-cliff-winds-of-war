shader_type canvas_item;
uniform float hover_amount=0.0;
uniform float press_amount=0.0;
void fragment(){
 vec4 texel=texture(TEXTURE,UV);
 // One neutral 3D-painted sprite keeps silhouette and click point identical across states.
 float exposed=smoothstep(0.13,0.7,dot(texel.rgb,vec3(0.299,0.587,0.114)));
 vec3 face=texel.rgb*(1.0+hover_amount*0.12*exposed);
 face=mix(face,face*vec3(1.025,1.010,0.985),hover_amount*0.35);
 face*=1.0-press_amount*0.14;
 COLOR=vec4(clamp(face,vec3(0.0),vec3(1.0)),texel.a);
}
