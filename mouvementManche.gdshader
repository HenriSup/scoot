shader_type canvas_item;
uniform float force = 0.0047;

void fragment(){
	 vec2 distortedUV = UV;
	distortedUV.y += sin(distortedUV.x * 28.5 + TIME*40.0) * force;
	//distortedUV.y += sin(distortedUV.x * 38.5 + TIME*40.0) * 0.0017;
	COLOR = texture(TEXTURE, distortedUV);
}
