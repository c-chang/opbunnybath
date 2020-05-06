#version 120

varying vec4 texcoord;

uniform sampler2D gcolor;
uniform sampler2D gnormal;
uniform sampler2D depthtex0;

uniform mat4 gbufferModelViewInverse;

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
	vec3 normal = texture2D(gnormal, texcoord.st).rgb*2.0-1.0;
	vec3 fragPos = vec3(texcoord.st, texture2D(depthtex0, texcoord.st).r);

	vec4 worldpos = gbufferModelViewInverse * vec4(fragPos, 1.0f);
	
	// color.g = color.g * 2.0;
	// convertHRD(color);
	// Vignette(color);

	gl_FragColor = vec4(color, 1.0f);
}
