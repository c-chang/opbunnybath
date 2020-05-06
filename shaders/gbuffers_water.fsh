#version 120

uniform sampler2D texture;

uniform float frameTimeCounter;

varying vec4 texcoord;
varying vec4 tintcolor;
varying vec4 ambientNdotL;
varying mat3 tbnMat;
varying vec3 worldpos;
varying vec3 sunPos;
varying vec3 camPos;
varying vec3 viewVector;

/*DRAWBUFFERS:012*/
//lagless shader's code
float waveHeight (vec3 position) {
	float wave = 0.0;
	float factor = 1.0;
	float amplitude = 0.2;
	float speed = 3.0;
	float size = 0.1;

	float px = position.x/50.0 + 250.0;
	float py = position.z/50.0  + 250.0;

	float fpx = abs(fract(px*20.0)-0.5)*2.0;
	float fpy = abs(fract(py*20.0)-0.5)*2.0;

	float d = length(vec2(fpx,fpy));

	for (int i = 0; i < 3; i++) {
		wave -= d*factor*cos( (1/factor)*px*py*size + 1.0*frameTimeCounter*speed);
		factor /= 2;
	}

	factor = 1.0;
	px = -position.x/25.0 + 150.0;
	py = -position.z/100.0 - 150.0;

	fpx = abs(fract(px*20.0)-0.5)*2.0;
	fpy = abs(fract(py*20.0)-0.5)*2.0;

	d = length(vec2(fpx,fpy));
	float wave2 = 0.0;
	for (int i = 0; i < 3; i++) {
		wave2 -= d*factor*cos( (1/factor)*px*py*size + 1.0*frameTimeCounter*speed);
		factor /= 2;
	}
	return amplitude*wave2 + amplitude*wave;
}

//lagless shader's code
vec3 waveNormal(vec3 position, float deltaPos) {
	float h0 = waveHeight(position);
	// change in x position
	float h1 = waveHeight(position - vec3(deltaPos, 0, 0));
	// change in z position
	float h2 = waveHeight(position - vec3(0, 0, deltaPos));

	float dX = (h0 - h1) / deltaPos;
	float dY = (h0 - h2) / deltaPos;

	float normX = sin(atan(dX));
	float normY = sin(atan(dY));

	return normalize(vec3(normX, normY, 1.0f));
}

vec3 BlinnPhong(vec3 position, vec4 newnorm, vec3 sun, vec3 cam) {
	vec3 lightcolor = vec3(.88, .8, .7);
	vec4 r = vec4(sun - position, 1.0f);
	vec4 Ir2 = vec4(lightcolor, 1.0f) / (pow(length(r), 2));
	vec4 l_a = normalize(0.5 * tintcolor);
  vec4 l_d = normalize(0.3 * Ir2 * dot(newnorm, normalize(r)));
  vec4 h = normalize(normalize(vec4(cam - position, 1.0f)) + normalize(r));
  vec4 l_s = normalize(0.8 * Ir2 * pow(dot(newnorm, h), 2));

	//following for debugging purposes
  // vec4 color = vec4(0.0f);
	// color += l_a;
	// color += l_d;
	// color += l_s;
	//complete Blinn-Phong:
	vec4 color = l_a + l_d + l_s;
  return color.rgb;
}

void main() {
	float deltaPos = 0.25;
	float iswater = clamp(ambientNdotL.a*2.0-1.0,0.0,1.0);
	vec4 albedo = tintcolor;
	vec4 tex = texture2D(texture, texcoord.st);

	vec3 position = worldpos;
	vec3 bumpNormal = waveNormal(position, deltaPos);
	// bumpNormal *= vec3(0.2);
	// bumpNormal += vec3(1, 1, 0.8);

	vec4 normalMap = vec4(normalize(bumpNormal * tbnMat)*0.5+0.5, 1.0f);
	vec3 newcolor = BlinnPhong(position, normalMap, sunPos, camPos);
	vec3 fcolor = mix(newcolor, normalMap.rgb, 0.11f).rgb;
	float alpha = 0.7f;
  gl_FragData[0] = vec4(fcolor, alpha);
	// gl_FragData[2] = tex * normalMap;
}
