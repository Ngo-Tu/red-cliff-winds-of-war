shader_type canvas_item;
uniform vec4 canvas_rect=vec4(0.0,0.0,1.0,1.0);
void fragment(){
 vec2 p=(SCREEN_UV-canvas_rect.xy)/canvas_rect.zw;
 float open=smoothstep(0.145,0.205,p.x);
 float curtain=mix(0.80,0.978,smoothstep(0.0,0.36,p.y));
 open*=1.0-smoothstep(curtain-0.025,curtain-0.006,p.x);
 float sky=smoothstep(0.075,0.12,p.y)*(1.0-smoothstep(0.30,0.345,p.y));
 COLOR.a*=open*sky;
}
