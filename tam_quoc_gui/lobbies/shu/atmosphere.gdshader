shader_type canvas_item;
uniform float clock=0.;
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
float noise(vec2 p){vec2 i=floor(p),f=fract(p);f=f*f*(3.-2.*f);return mix(mix(hash(i),hash(i+vec2(1,0)),f.x),mix(hash(i+vec2(0,1)),hash(i+vec2(1,1)),f.x),f.y);}
float fbm(vec2 p){return noise(p)*.57+noise(p*2.03)*.28+noise(p*4.07)*.15;}
void fragment(){
 vec2 p=UV*vec2(1672.,941.);
 // Visible cloud banks travel across the open sky at 28 pixels per second.
 float sky=smoothstep(440.,560.,p.x)*(1.-smoothstep(1420.,1460.,p.x));
 sky*=smoothstep(58.,78.,p.y)*(1.-smoothstep(155.,205.,p.y));
 float cloud=fbm(vec2((p.x-clock*28.)*.005,p.y*.024+2.));
 cloud=smoothstep(.34,.67,cloud)*sky*.62;
 float age=100.;
 if(clock>=5.5)age=clock-5.5;
 if(clock>=11.8)age=clock-11.8;
 if(clock>=17.5)age=clock-17.5;
 if(clock>=23.7)age=clock-23.7;
 float env=smoothstep(0.,1.85,age)*(1.-smoothstep(1.85,3.8,age));
 // Screen-wide fog deliberately includes portrait, buttons and foreground.
 float mist=fbm(vec2((p.x-clock*120.)*.0024,p.y*.006+clock*.045));
 float wisps=fbm(vec2((p.x-clock*72.)*.005,p.y*.018-clock*.06));
 float front=smoothstep(-.25,.28,age/3.8-p.x/1672.*.22);
 float fog=front*env*(.13+smoothstep(.20,.79,mist)*.34+wisps*.09);
 COLOR=vec4(vec3(.85,.90,.89),clamp(cloud+fog,0.,.70));
}
