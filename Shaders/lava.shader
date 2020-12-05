shader_type canvas_item;

uniform vec2 tiled_factor = vec2(5.0, 5.0);
uniform float aspect_ratio = 0.5;
uniform float timescale = 1;

void fragment() {
	vec2 tiled_uvs = UV * tiled_factor;
	tiled_uvs.y *= aspect_ratio;
	tiled_uvs.x *= aspect_ratio;
	
	vec2 waves_uv_offset;
	waves_uv_offset.x = cos(TIME * 3.0 + tiled_uvs.x + tiled_uvs.y) * 0.005;
	waves_uv_offset.y = sin(TIME * 3.0 + tiled_uvs.x + tiled_uvs.y) * 0.005;
	
	float near_top = UV.x / 0.04 + waves_uv_offset.y / (0.01 / aspect_ratio);
	near_top = clamp(near_top, 0.0, 1.0);
	near_top = 1.0 - near_top;
	
	float edge_lower = 0.6;
	float edge_upper = edge_lower + 0.1;
	
	vec4 color = texture(TEXTURE, tiled_uvs + waves_uv_offset, 0.0);
	color = mix(color, vec4(1.0, 0.0, 0.0, 1.0), near_top);
	color = mix(color, texture(SCREEN_TEXTURE, SCREEN_UV + waves_uv_offset, 0.0), 0.15);
	if(near_top > edge_lower) {
		color.a = 0.0;
		if(near_top < edge_upper){
			color.a = 1.0;
		}
	}
	
	COLOR = color;
}