shader_type canvas_item;
uniform float motion_time=0.0;
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
float noise(vec2 p){vec2 i=floor(p),f=fract(p);f=f*f*(3.0-2.0*f);return mix(mix(hash(i),hash(i+vec2(1,0)),f.x),mix(hash(i+vec2(0,1)),hash(i+vec2(1,1)),f.x),f.y);}
float fbm(vec2 p){return noise(p)*0.55+noise(p*2.04)*0.28+noise(p*4.12)*0.12+noise(p*8.21)*0.05;}
void fragment(){
 float h=1.0-UV.y;
 float center=0.46+h*0.10+sin(h*7.0-motion_time*0.46)*h*0.10;
 float width=0.055+pow(h,0.82)*0.40;
 float dist=(UV.x-center)/width;
 float plume=exp(-dist*dist*2.6);
 vec2 flow=vec2((UV.x-center)*7.0,h*7.0-motion_time*0.26);
 vec2 warp=vec2(fbm(flow+vec2(3.2,0.0)),fbm(flow+vec2(0.0,8.4)));
 float density=fbm(flow+warp*2.9);
 float thin=pow(max(0.0,1.0-abs(density*2.0-1.0)),3.8);
 float folds=0.30+0.70*smoothstep(0.29,0.66,fbm(flow*2.2+warp*3.0));
 float fade=smoothstep(0.0,0.045,h)*(1.0-smoothstep(0.42,1.0,h));
 float alpha=plume*thin*folds*fade*0.43;
 COLOR=vec4(vec3(0.84,0.85,0.83),alpha);
}
