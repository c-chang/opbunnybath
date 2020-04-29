#version 120

varying vec4 texcoord;
varying vec4 tintcolor;

// waves
uniform vec3 cameraPosition;
uniform float frameTimeCounter;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

varying vec3 worldpos;
varying vec3 viewVector;
varying vec4 ambientNdotL;
varying mat3 tbnMat;

attribute vec4 at_tangent;

const float PI = 3.1415927;
#define waves_amplitude 2

void main() {
  vec3 normal = normalize(gl_NormalMatrix * gl_Normal).xyz;
  texcoord = gl_MultiTexCoord0;
  tintcolor = gl_Color;
  // waves
  vec3 position = mat3(gbufferModelViewInverse) * (gl_ModelViewMatrix * gl_Vertex).xyz;
  worldpos = position.xyz + cameraPosition;
  ambientNdotL = vec4(0.2, 0.3, 0.6, 0.0);
  float fy = fract(worldpos.y + 0.001);
  float wave = 0.05 * sin(2 * PI * (frameTimeCounter*0.8 + worldpos.x /  2.5 + worldpos.z / 5.0))
         + 0.05 * sin(2 * PI * (frameTimeCounter*0.6 + worldpos.x / 6.0 + worldpos.z /  12.0));
  position.y += clamp(wave, -fy, 1.0-fy)*waves_amplitude;
  gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(position, 1.0);

  // calculate tangent bi-normal matrix (std construction)
  vec3 tangent = normalize(gl_NormalMatrix * at_tangent.xyz);
	vec3 binormal = normalize(gl_NormalMatrix * cross(at_tangent.xyz, gl_Normal.xyz) * at_tangent.w);
	tbnMat = mat3(tangent.x, binormal.x, normal.x,
					 tangent.y, binormal.y, normal.y,
					 tangent.z, binormal.z, normal.z);
  viewVector = tbnMat * (gl_ModelViewMatrix * gl_Vertex).xyz;
}
// ADJUST BELOW THIS LINE
// #version 120
//
// varying vec4 texcoord;
// varying vec4 tintcolor;
//
// // waves
// uniform vec3 cameraPosition;
// uniform float frameTimeCounter;
// uniform mat4 gbufferModelView;
// uniform mat4 gbufferModelViewInverse;
//
// varying vec4 ambientNdotL;
// varying vec3 worldpos;
// varying vec3 tbnMatrix;
// varying vec3 viewVector;
//
// attribute vec4 mc_Entity;
// attribute vec4 at_tangent;
//
// const float PI = 3.1415927;
// #define waves_amplitude 2;
//
// void main() {
//   gl_Position = ftransform();
//
//   texcoord = gl_MultiTexCoord0;
//   tintcolor = gl_Color;
//
//   // waves
//   vec3 position = mat3(gbufferModelViewInverse) * (gl_ModelViewMatrix * gl_Vertex).xyz + gbufferModelViewInverse[3].xyz;
//   worldpos = position.xyz + cameraPosition;
//   ambientNdotL.a = 0.0;
//   float iswater = 0.0;
//   if(mc_Entity.x != 10008.0) {
//     ambientNdotL.a = 1.0;
//     iswater = 1.0;
//     // #ifdef Waving_Water
//       float fy = fract(worldpos.y + 0.001);
//       float wave = 0.05 * sin(2 * PI * (frameTimeCounter*0.8 + worldpos.x /  2.5 + worldpos.z / 5.0))
//              + 0.05 * sin(2 * PI * (frameTimeCounter*0.6 + worldpos.x / 6.0 + worldpos.z /  12.0));
//       position.y += clamp(wave, -fy, 1.0-fy)*waves_amplitude;
//     // #endif
//     if(mc_Entity.x == 10079.0) ambientNdotL.a = 0.5;
//     gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(position, 1.0);
//
//     ambientNdotL.rgb = vec3(0, 1, 0);
//   }
//
//   // vec3 tangent = normalize(gl_NormalMatrix * at_tangent.xyz);
// 	// vec3 binormal = normalize(gl_NormalMatrix * cross(at_tangent.xyz, gl_Normal.xyz) * at_tangent.w);
// 	// tbnMatrix = mat3(tangent.x, binormal.x, normal.x,
// 	// 				 tangent.y, binormal.y, normal.y,
// 	// 				 tangent.z, binormal.z, normal.z);
//   //
// 	// float dist = length(gl_ModelViewMatrix * gl_Vertex);
// 	// viewVector = tbnMatrix * (gl_ModelViewMatrix * gl_Vertex).xyz;
// }
