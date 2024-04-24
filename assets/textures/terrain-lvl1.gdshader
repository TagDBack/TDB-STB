shader_type spatial;

uniform sampler2D _a;
uniform sampler2D heightmap;
uniform float heightmap_ratio = 1.0;

void vertex() {
	VERTEX.y += texture(heightmap, UV).r * heightmap_ratio;
}

void fragment() {
	ALBEDO = texture(_a, UV).rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
