shader_type canvas_item;
uniform float force = 0.0020;

void fragment(){
	 vec2 distortedUV = UV;
	distortedUV.y += sin(distortedUV.x * 45.5 + (TIME+1.0)*35.0) * force;
	COLOR = texture(TEXTURE, distortedUV);
}