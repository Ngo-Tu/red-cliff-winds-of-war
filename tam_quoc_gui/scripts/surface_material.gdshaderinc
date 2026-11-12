// Sample square physical texture swatches with equal X/Y scale, never stretch grain.
uniform sampler2D physical_surfaces: source_color,filter_linear;
vec3 material_surface(vec2 p,int kind){
 vec2 local=fract(p/512.0);
 vec2 uv=vec2((float(kind)+local.x)/3.0,local.y);
 return texture(physical_surfaces,uv).rgb;
}
