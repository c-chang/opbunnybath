varying vec4 texcoord;

void main() {
	vec3 color = getLitColor(texcoord.st);

	gl_fragColor = vec4(color, 1.0);
}