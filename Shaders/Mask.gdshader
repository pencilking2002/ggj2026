shader_type canvas_item;

uniform vec4 mask_color = vec4(0,0,0,1);
uniform vec2 offset = vec2(0,0);
uniform float eye_radius = 0.1;
uniform float eye_falloff = 0.1;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

float circle(vec2 position, float radius, float feather)
{
	return smoothstep(radius, radius + feather, length(position - vec2(0.5)));
}

void fragment() {
    vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	vec2 left_uv = vec2(UV.x+offset.x, UV.y+offset.y);
	vec2 right_uv = vec2(UV.x-offset.x, UV.y+offset.y);

	float left_eye = circle(left_uv, eye_radius, eye_falloff);
	float right_eye = circle(right_uv, eye_radius, eye_falloff);
    vec4 left_eye_color = mix(col, mask_color, left_eye);
	vec4 right_eye_color = mix(col, mask_color, right_eye);
	COLOR = left_eye_color + right_eye_color;
}


