shader_type canvas_item;
render_mode unshaded;

uniform vec2 canvas_size = vec2(420.0, 96.0);
uniform vec2 left_sole_center = vec2(84.3, 50.7);
uniform vec2 left_sole_radius = vec2(23.0, 5.5);
uniform vec2 right_sole_center = vec2(214.0, 48.8);
uniform vec2 right_sole_radius = vec2(41.0, 6.2);

float soft_ellipse(vec2 point, vec2 center, vec2 radius) {
	float d = length((point - center) / max(radius, vec2(0.001)));
	return 1.0 - smoothstep(0.0, 1.0, d);
}

float rotated_soft_ellipse(vec2 point, vec2 center, vec2 radius, float angle_rad, float inner_falloff) {
	vec2 rel = point - center;
	float c = cos(angle_rad);
	float s = sin(angle_rad);
	vec2 rot = vec2(rel.x * c + rel.y * s, -rel.x * s + rel.y * c);
	float d = length(rot / max(radius, vec2(0.001)));
	return 1.0 - smoothstep(inner_falloff, 1.0, d);
}

void fragment() {
	vec2 point = UV * canvas_size;

	// 1. Tight contact shadows anchored directly under the left and right boot soles
	float left_core = rotated_soft_ellipse(point, left_sole_center, left_sole_radius * vec2(0.96, 0.72), 0.04, 0.15) * 0.78;
	float left_rim = rotated_soft_ellipse(point, left_sole_center + vec2(2.0, 1.0), left_sole_radius * vec2(1.28, 1.22), 0.06, 0.0) * 0.46;

	float right_core = rotated_soft_ellipse(point, right_sole_center, right_sole_radius * vec2(0.96, 0.72), 0.08, 0.15) * 0.76;
	float right_rim = rotated_soft_ellipse(point, right_sole_center + vec2(3.0, 1.2), right_sole_radius * vec2(1.26, 1.22), 0.10, 0.0) * 0.45;

	// 2. Soft directional cast shadow pulled gently down-right (sunlight from top-left)
	float cast_angle = 0.25; // ~14.3 degrees down-right
	vec2 mid_sole = 0.5 * (left_sole_center + right_sole_center);
	float span_x = max(abs(right_sole_center.x - left_sole_center.x), 48.0);

	float cast_left = rotated_soft_ellipse(point, left_sole_center + vec2(38.0, 10.0), vec2(58.0, 13.5), cast_angle, 0.0) * 0.36;
	float cast_right = rotated_soft_ellipse(point, right_sole_center + vec2(48.0, 12.0), vec2(72.0, 15.0), cast_angle, 0.0) * 0.36;
	float cast_robe = rotated_soft_ellipse(point, mid_sole + vec2(44.0, 9.5), vec2(span_x * 0.72 + 52.0, 21.0), 0.20, 0.0) * 0.33;

	float contact_a = 1.0 - (1.0 - left_core) * (1.0 - left_rim) * (1.0 - right_core) * (1.0 - right_rim);
	float cast_a = 1.0 - (1.0 - cast_left) * (1.0 - cast_right) * (1.0 - cast_robe);
	float opacity = 1.0 - (1.0 - contact_a) * (1.0 - cast_a);

	COLOR = vec4(0.09, 0.075, 0.065, opacity);
}
