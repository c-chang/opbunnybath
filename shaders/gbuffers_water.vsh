#version 120

varying vec4 texcoord;
varying vec3 tintcolor;

// waves
uniform vec3 cameraPosition;
uniform float frameTimeCounter;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
const float PI = 3.1415927;
varying vec4 ambientNdotL;
varying vec3 worldpos;
attribute vec4 mc_Entity;
#define waves_amplitude 2.00

void main() {
  gl_Position = ftransform();

  texcoord = gl_MultiTexCoord0;
  tintcolor = gl_Color.rgb;

  // waves
  vec3 position = mat3(gbufferModelViewInverse) * (gl_ModelViewMatrix * gl_Vertex).xyz;
  worldpos = position.xyz + cameraPosition;
  ambientNdotL.a = 0.0;
  float iswater = 1.0;
  // if(mc_Entity.x == 10008.0) {
    ambientNdotL.a = 1.0;
    iswater = 0.0;
    // #ifdef Waving_Water
      float fy = fract(worldpos.y + 0.001);
      float wave = 0.05 * sin(2 * PI * (frameTimeCounter*0.8 + worldpos.x /  2.5 + worldpos.z / 5.0))
             + 0.05 * sin(2 * PI * (frameTimeCounter*0.6 + worldpos.x / 6.0 + worldpos.z /  12.0));
      position.y += clamp(wave, -fy, 1.0-fy)*waves_amplitude;
    // #endif
    if(mc_Entity.x == 10079.0) ambientNdotL.a = 0.5;
    gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(position, 1.0);
  // }
}
