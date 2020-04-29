#version 120

varying vec4 texcoord;

uniform sampler2D gcolor;

void Vignette(inout vec3 color) {
	float d = distance(texcoord.st, vec2(0.5)) * 2.0 / 1.5142f;
	d = pow(d, 1.1f);
	color.rgb *= 1.0f - d;
}

void convertHRD(inout vec3 color) {
	vec3 overexpose = color * 1.2f;
	vec3 underexpose = color / 2.0f;
	color = mix(underexpose, overexpose, color);
}

void main() {
	vec3 color = texture2D(gcolor, texcoord.st).rgb;
	// color.g = color.g * 2.0;
	// convertHRD(color);
	// Vignette(color);

	gl_FragColor = vec4(color, 1.0f);
}
