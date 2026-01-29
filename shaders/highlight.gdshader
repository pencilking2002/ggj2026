shader_type canvas_item;

uniform vec4 additive_color = vec4(0.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 main_tex = texture(TEXTURE, UV);
	COLOR = main_tex + additive_color;
	COLOR.a = main_tex.a;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
