shader_type canvas_item;

void fragment(){
	 vec2 distortedUV = UV;
	distortedUV.y += sin(distortedUV.x * 8.5 + TIME*40.0) * 0.0225;
	COLOR = texture(TEXTURE, distortedUV);
}