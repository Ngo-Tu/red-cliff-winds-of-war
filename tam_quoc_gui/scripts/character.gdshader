shader_type canvas_item;
uniform float motion_time = 0.0;
uniform float motion_amount = 1.0;
void vertex() {
    vec2 p = UV;
    float breath = sin(motion_time * 1.55);
    float chest = exp(-pow((p.y - 0.34) / 0.16, 2.0));
    float torso = 1.0 - smoothstep(0.25, 0.40, abs(p.x - 0.49));
    VERTEX.x += (p.x - 0.49) * 3.0 * chest * breath * motion_amount;
    VERTEX.y -= 1.5 * chest * torso * breath * motion_amount;
    // Localised robe sway; face, hands and feet remain almost still.
    float cloak = smoothstep(0.53, 0.77, p.x) * smoothstep(0.40, 0.62, p.y)
        * (1.0 - smoothstep(0.86, 0.97, p.y));
    VERTEX.x += cloak * (sin(motion_time * 1.1 + p.y * 6.0) * 3.6
        + sin(motion_time * 1.9 + p.y * 11.0) * 0.9) * motion_amount;
    VERTEX.y += cloak * sin(motion_time * 1.3 + p.y * 5.0) * 0.7 * motion_amount;
}
