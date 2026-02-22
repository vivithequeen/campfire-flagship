shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float multipler = floor((UV.y  + sin(TIME / 2.f + UV.x * 1.f) / 4.f + 1.f)*2.f)/10.f+0.8f;
	COLOR = vec4(COLOR.r * multipler, COLOR.g * multipler, COLOR.b * multipler, COLOR.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
