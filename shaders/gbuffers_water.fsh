#version 120

uniform sampler2D gcolor;
uniform sampler2D gnormal;
uniform sampler2D gdepth;
uniform sampler2D texture;

uniform float sunAngle;

varying vec4 texcoord;
varying vec3 normal;
varying vec3 tintcolor;

void main() {
  // float indexOfRefraction = 1.3333f;
  // float angle5 = dot(, normal);
  vec4 tex = texture2D(texture, texcoord.st);
  tex.rgba = vec4(0.0, 0.0, 1.0, 0.33);
  // vec4 albedo = texture2D()

/* DRAWBUFFERS:01 */
  gl_FragData[0] = tex;
  // gl_FragData[1] = vec4(normal, 1.0f);
}
