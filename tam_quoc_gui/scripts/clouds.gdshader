shader_type canvas_item;
uniform float motion_time=0.0;
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
float noise(vec2 p){vec2 i=floor(p);vec2 f=fract(p);f=f*f*(3.0-2.0*f);return mix(mix(hash(i),hash(i+vec2(1,0)),f.x),mix(hash(i+vec2(0,1)),hash(i+vec2(1,1)),f.x),f.y);}
float fbm(vec2 p){return noise(p)*0.57+noise(p*2.03)*0.28+noise(p*4.1)*0.15;}
void fragment(){
 vec2 p=UV;
 float open=smoothstep(0.145,0.205,p.x)*(1.0-smoothstep(0.80,0.91,p.x));
 float sky=smoothstep(0.04,0.14,p.y)*(1.0-smoothstep(0.30,0.39,p.y));
 vec2 cloud=p*vec2(6.,24.)-vec2(motion_time*0.060,0.0);
 float mass=smoothstep(0.32,0.68,fbm(cloud));
 float valley=smoothstep(0.42,0.50,p.y)*(1.0-smoothstep(0.67,0.74,p.y));
 float drift=smoothstep(0.39,0.76,fbm(p*vec2(5.,25.)-vec2(motion_time*0.045,0.0)));
 float a=open*(sky*mass*0.0+valley*drift*0.06);
 COLOR=vec4(vec3(0.94,0.90,0.85),a);
}
