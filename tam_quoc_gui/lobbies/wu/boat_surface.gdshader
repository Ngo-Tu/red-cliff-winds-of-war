shader_type canvas_item;
uniform float clock=0.;
uniform float phase=0.;
void fragment(){
 vec2 p=UV*vec2(1536.,1024.);
 // Pin the mast and each bamboo batten. Only fabric inside each bay billows.
 float z=p.y+.29*(p.x-830.);
 float bay=fract((z-170.)/74.);
 float cloth=smoothstep(635.,685.,p.x)*(1.-smoothstep(1040.,1080.,p.x))*smoothstep(95.,170.,p.y)*(1.-smoothstep(665.,695.,p.y));
 cloth*=smoothstep(11.,24.,abs(p.x-830.));
 cloth*=pow(max(0.,sin(bay*3.141593)),2.);
 vec2 uv=UV;
 uv.x+=sin(clock*1.5+p.y*.018+phase)*3.5/1536.*cloth;
 vec4 color=texture(TEXTURE,uv);
 color.rgb*=1.+sin(clock*1.5+p.y*.018+phase)*.045*cloth;
 COLOR=color;
}
