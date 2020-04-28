#version 120

uniform sampler2D gcolor;
uniform sampler2D gnormal;
uniform sampler2D gdepth;
uniform sampler2D texture;

uniform float sunAngle;

varying vec4 texcoord;
varying vec3 normal;
varying vec3 tintcolor;

varying vec4 ambientNdotL;

void main() {
  vec4 tex = texture2D(gcolor, texcoord.st);
/* DRAWBUFFERS:01 */
  tex.rgb = tintcolor;
  gl_FragData[0] = tex;
  // gl_FragData[1] = vec4(normal, 1.0f);
}