shader_type canvas_item;
uniform float force = 0.0125;

void fragment(){
	 vec2 distortedUV = UV;
	distortedUV.y += sin(distortedUV.x * 8.5 + TIME*30.0) * force;
	COLOR = texture(TEXTURE, distortedUV);
}