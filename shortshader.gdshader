shader_type canvas_item;

void fragment(){
	 vec2 distortedUV = UV;
	distortedUV.y += sin(distortedUV.x * 45.5 + TIME*35.0) * 0.0020;
	COLOR = texture(TEXTURE, distortedUV);
}