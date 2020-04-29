#version 120

uniform sampler2D gcolor;
uniform sampler2D gnormal;
uniform sampler2D gdepth;
uniform sampler2D texture;

uniform float sunAngle;

varying vec4 texcoord;
varying vec4 tintcolor;
varying vec4 ambientNdotL;
varying mat3 tbnMat;
varying vec3 viewVector;

vec3 Parallax (vec3 position, float iswater) {
	return vec3(0.0, 0.0, 0.0);
}


void main() {
	float iswater = clamp(ambientNdotL.a*2.0-1.0,0.0,1.0);
  vec4 albedo = texture2D(gcolor, texcoord.st);
	albedo.rgb = pow(albedo.rgb, vec3(2.2)) * tintcolor.rgb;
	vec3 fcolor = albedo.rgb * ambientNdotL.rgb;
	float alpha = mix(albedo.a,0.1,iswater);

	vec3 newnormal = normalize(vec3(0, 0, 0) * tbnMat);
  // albedo.rgb = tintcolor.rgb;
	/*DRAWBUFFERS:01*/
  gl_FragData[0] = vec4(fcolor, alpha);
	// gl_FragData[1] = texture2D(gnormal * 2, 0,0);
}
// ADJUST BELOW THIS LINE
// #version 120
//
// uniform sampler2D gcolor;
// uniform sampler2D gnormal;
// uniform sampler2D gdepth;
// uniform sampler2D texture;
// uniform sampler2D noisetex;
//
// uniform float sunAngle;
//
// varying vec4 texcoord;
// varying vec4 tintcolor;
// varying mat3 tbnMatrix;
// varying vec4 ambientNdotL;
// varying vec3 worldpos;
// varying vec3 viewVector;
//
// uniform vec3 cameraPosition;
// uniform float frameTimeCounter;
// uniform mat4 gbufferModelView;
// uniform mat4 gbufferModelViewInverse;
// const float PI = 3.1415927;
//
// attribute vec4 mc_Entity;
// attribute vec4 at_tangent;
//
// // mat2 rmatrix(float rad){
// // 	return mat2(vec2(cos(rad), -sin(rad)), vec2(sin(rad), cos(rad)));
// // }
// //
// // float calcWaves(vec2 coord, float iswater){
// // 	vec2 movement = abs(vec2(0.0, -frameTimeCounter * 0.31365*iswater));
// //
// // 	coord *= 0.262144;
// // 	vec2 coord0 = coord * rmatrix(1.0) - movement * 4.0;
// // 		 coord0.y *= 3.0;
// // 	vec2 coord1 = coord * rmatrix(0.5) - movement * 1.5;
// // 		 coord1.y *= 3.0;
// // 	vec2 coord2 = coord + movement * 0.5;
// // 		 coord2.y *= 3.0;
// //
// // 	float wave = 1.0 - texture2D(noisetex,coord0 * 0.005).x * 10.0;		//big waves
// // 		  wave += texture2D(noisetex,coord1 * 0.010416).x * 7.0;		//small waves
// // 		  wave += sqrt(texture2D(noisetex,coord2 * 0.045).x * 6.5) * 1.33;//noise texture
// // 		  wave *= 0.0157;
// //
// // 	return wave;
// // }
// //
// // vec3 calcBump(vec2 coord, float iswater){
// // 	const vec2 deltaPos = vec2(0.25, 0.0);
// //
// // 	float h0 = calcWaves(coord, iswater);
// // 	float h1 = calcWaves(coord + deltaPos.xy, iswater);
// // 	float h2 = calcWaves(coord - deltaPos.xy, iswater);
// // 	float h3 = calcWaves(coord + deltaPos.yx, iswater);
// // 	float h4 = calcWaves(coord - deltaPos.yx, iswater);
// //
// // 	float xDelta = ((h1-h0)+(h0-h2));
// // 	float yDelta = ((h3-h0)+(h0-h4));
// //
// // 	return vec3(vec2(xDelta,yDelta)*0.5, 0.5); //z = 1.0-0.5
// // }
// //
// // vec3 calcParallax(vec3 pos, float iswater){
// // 	float getwave = calcWaves(pos.xz - pos.y, iswater);
// //
// // 	pos.xz += (getwave * viewVector.xy);
// //
// // 	return pos;
// // }
//
// void main() {
//   // float iswater = clamp(ambientNdotL.a*2.0-1.0,0.0,1.0);
// 	vec4 albedo = texture2D(gcolor, texcoord.st);
//   // albedo.rgb = pow(albedo.rgb, vec3(2.2));
//
//   // vec3 waterpos = calcParallax(waterpos, iswater);
//   // vec3 bump = calcBump(waterpos.xz - waterpos.y, iswater);
// 	// vec3 newnormal = normalize(bump * tbnMatrix);
//
//   // vec3 fcolor = albedo.rgb * ambientNdotL.rgb;
//   // float alpha = mix(albedo.a,0.11,iswater);
// 	// float p = sqrt(newnormal.z*8+8);
// /* DRAWBUFFERS:01 */
// 	gl_FragData[0] = albedo;
//   // gl_FragData[0] = vec4(fColor,alpha);
//   // gl_FragData[1] = vec4(newnormal.xy/p + 0.5, 0.25, 1.0);
//   // gl_FragData[2] = vec4(normalize(albedo.rgb+0.00001),alpha);
//   // gl_FragData[1] = vec4(normal, 1.0f);
// }
