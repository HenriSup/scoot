shader_type canvas_item;

void fragment(){
	 vec2 distortedUV = UV;
	distortedUV.y += sin(distortedUV.x * 20.5 + TIME*20.0) * 0.0205;
	COLOR = texture(TEXTURE, distortedUV);
}