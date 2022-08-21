shader_type canvas_item;

uniform bool whiten = false; // bandera

// detectamos todos los pixeles y los cambiamos a blanco
void fragment() {
	vec4 texture_color = texture(TEXTURE, UV); 
	if (whiten) {
		vec3 white = vec3(1,1,1);
		vec3 whitened_texture_rgb = mix(texture_color.rgb, white, 0.8); // interpolacion
		COLOR = vec4(whitened_texture_rgb, texture_color.a);			// pintamos los pixeles de blanco
	} else {
		COLOR = texture_color
	}
}