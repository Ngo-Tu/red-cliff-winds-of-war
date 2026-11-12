shader_type canvas_item;
uniform vec4 edge_tint: source_color=vec4(0.66,0.68,0.69,1.0);
uniform vec4 face_tint: source_color=vec4(0.90,0.91,0.89,1.0);
void fragment(){
 float lightness=dot(COLOR.rgb,vec3(0.2126,0.7152,0.0722));
 COLOR.rgb=mix(edge_tint.rgb*0.42,face_tint.rgb,smoothstep(0.15,0.92,lightness));
}
