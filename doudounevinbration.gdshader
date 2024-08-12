shader_type canvas_item;

void fragment(){
	 vec2 distortedUV = UV;
	distortedUV.y += sin(distortedUV.x * 38.5 + TIME*40.0) * 0.0017;
	COLOR = texture(TEXTURE, distortedUV);
}