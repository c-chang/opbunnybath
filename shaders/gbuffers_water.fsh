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
  vec4 tex2 = texture2D(texture, texcoord.st + vec2(0,0.5));
  vec4 tex3 = texture2D(texture, texcoord.st + vec2(0,-0.5));
  vec4 tex4 = texture2D(texture, texcoord.st + vec2(-0.5,0));
  vec4 tex5 = texture2D(texture, texcoord.st + vec2(0.5,0));
  // tex.rgba = vec4(0.0, 0.0, 1.0, 0.33);
  // vec4 albedo = texture2D()
  tex2 = mix(tex2, tex3, 0.5);
  tex4 = mix(tex4, tex5, 0.5);
  tex2 = mix(tex2, tex4, 0.5);
  tex.rgb = tex.rgb * vec3(0.1, 0.1, 1.0);
  tex2.rgb = tex2.rgb * vec3(0.1, 0.1, 1.0);

  // Ocean boat blue
  tex.rgba = vec4(0, 0.467, 0.745, 0.5);
/* DRAWBUFFERS:01 */
  gl_FragData[0] = mix(tex, vec4(tintcolor, 0.6), 0.5);
  // tex.rgb *= tintcolor;
  // gl_FragData[0] = tex;
  // gl_FragData[1] = vec4(normal, 1.0f);
}
