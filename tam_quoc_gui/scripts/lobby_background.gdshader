shader_type canvas_item;
uniform float motion_time=0.0;
float region(vec2 p,vec4 r){
 return smoothstep(r.x,r.x+0.003,p.x)*(1.0-smoothstep(r.z-0.003,r.z,p.x))*smoothstep(r.y,r.y+0.003,p.y)*(1.0-smoothstep(r.w-0.003,r.w,p.y));
}
vec2 hanging(vec2 p,vec4 r,float phase){
 float mask=region(p,r);
 float free_end=clamp((p.y-r.y)/(r.w-r.y),0.0,1.0);
 return vec2(sin(motion_time*2.4+p.y*48.0+phase)*0.0033,sin(motion_time*2.0+p.x*35.0+phase)*0.0016)*mask*free_end;
}
vec2 flying(vec2 p,vec4 r,float phase){
 float mask=region(p,r);
 float free_end=clamp((p.x-r.x)/(r.z-r.x),0.0,1.0);
 return vec2(sin(motion_time*2.9+p.x*90.0+phase)*0.0015,sin(motion_time*3.2+p.x*95.0+phase)*0.0045)*mask*free_end;
}
void fragment(){
 vec2 p=UV;
 vec2 shift=vec2(0.0);
 shift+=hanging(p,vec4(0.526,0.196,0.584,0.359),0.0);
 shift+=hanging(p,vec4(0.314,0.326,0.337,0.435),1.2);
 shift+=hanging(p,vec4(0.372,0.326,0.395,0.435),2.0);
 shift+=hanging(p,vec4(0.708,0.317,0.732,0.435),0.8);
 shift+=hanging(p,vec4(0.768,0.317,0.793,0.435),1.7);
 shift+=flying(p,vec4(0.246,0.140,0.277,0.184),0.0);
 shift+=flying(p,vec4(0.837,0.194,0.875,0.247),1.3);
 shift+=flying(p,vec4(0.154,0.289,0.183,0.331),2.0);
 // Canopy only: wind moves foliage, not the architecture or interface.
 float canopy=(1.0-smoothstep(0.08,0.17,p.y))*smoothstep(0.12,0.25,p.x)*(1.0-smoothstep(0.43,0.49,p.x));
 shift.x+=sin(motion_time*1.4+p.y*29.0)*0.0012*canopy;
 COLOR=texture(TEXTURE,p+shift);
}
