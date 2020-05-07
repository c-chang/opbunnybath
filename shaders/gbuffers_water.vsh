#version 120

varying vec4 texcoord;
varying vec4 tintcolor;

// waves
uniform vec3 cameraPosition;
uniform vec3 sunPosition;
uniform float frameTimeCounter;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

varying vec3 worldpos;
varying vec3 viewVector;
varying vec4 ambientNdotL;
varying mat3 tbnMat;
varying vec3 sunPos;
varying vec3 camPos;

attribute vec4 at_tangent;

const float PI = 3.1415927;
#define waves_amplitude 1.0

void main() {
  vec3 normal = normalize(gl_NormalMatrix * normalize(gl_Normal));
  texcoord = gl_MultiTexCoord0;
  tintcolor = gl_Color;
  //chris' waves
  vec3 position = mat3(gbufferModelViewInverse) * (gl_ModelViewMatrix * gl_Vertex).xyz;
  worldpos = position.xyz + cameraPosition;
  float fy = fract(worldpos.y + 0.001);
  float wave = 0.05 * sin(2 * PI * (frameTimeCounter/1.25 + worldpos.x/2.5 + worldpos.z/5.0))
           + 0.05 * sin(2 * PI * (frameTimeCounter/3.67 + worldpos.x/6.0 + worldpos.z/12.0));
  position.y += clamp(wave, -fy, 1.0-fy)*waves_amplitude;
  gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(position, 1.0);

  // calculate tangent bi-normal matrix (std construction)
  vec3 tangent = normalize(gl_NormalMatrix * at_tangent.xyz);
	vec3 binormal = normalize(gl_NormalMatrix * cross(at_tangent.xyz, gl_Normal.xyz) * at_tangent.w);
	tbnMat = mat3(tangent.x, binormal.x, normal.x,
					 tangent.y, binormal.y, normal.y,
					 tangent.z, binormal.z, normal.z);
  viewVector = tbnMat * (gl_ModelViewMatrix * gl_Vertex).xyz;
  sunPos = sunPosition.xyz;
  camPos = cameraPosition.xyz;
}
