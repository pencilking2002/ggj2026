shader_type canvas_item;

uniform vec4 highlight_color : source_color = vec4(0.0);
uniform float blink_strength : hint_range(0,1) = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 main_tex = texture(TEXTURE, UV);
	float color_blink = sin(TIME * 10.0) * 0.5 + 0.5;
	COLOR.rgb = main_tex.rgb + highlight_color.rgb * color_blink * blink_strength;
	COLOR.a = main_tex.a;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
