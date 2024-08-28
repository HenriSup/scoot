shader_type canvas_item;
uniform float force = 0.0225;

void fragment(){
	 vec2 distortedUV = UV;
	distortedUV.y += sin(distortedUV.x * 8.5 + TIME*40.0) * force;
	COLOR = texture(TEXTURE, distortedUV);
}