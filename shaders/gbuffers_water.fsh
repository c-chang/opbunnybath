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
  vec4 tex = texture2D(gcolor, texcoord.st) / vec4(tintcolor, 1.0);
  // vec4 tex2 = texture2D(gnormal, texcoord.st + vec2(1.0,0.5));
  // vec4 tex3 = texture2D(gdepth, texcoord.st + vec2(-0.1,-0.5));
  // vec4 tex4 = texture2D(texture, texcoord.st + vec2(-0.5,1));
  // vec4 tex5 = texture2D(texture, texcoord.st + vec2(0.1,0.5));
  // tex.rgba = vec4(0.0, 0.0, 1.0, 0.33);
  // vec4 albedo = texture2D()
  // tex2 = mix(tex2, tex3, 0.2) * sunAngle;
  // tex4 = mix(tex4, tex5, 0.2);
  // tex2 = tex2 + tex4;
  // tex.rgb = tex.rgb * vec3(1.0, 0.1, 1.0);
  // tex2.rgb = tex2.rgb * vec3(0.1, 0.1, 1.0);
  // tex4 = vec4(0.5*sin(tex.r)+0.5, 0.5*sin(tex.g)_0.5, 0.5*cos(tex.r + tex.g), 1);

/* DRAWBUFFERS:012 */
  // gl_FragData[0] = tex4 + vec4(tintcolor, 1.0);
  gl_FragData[0] = tex;
  gl_FragData[1] = texture2d(gnormal) * 0.1;
  // gl_FragData[2] = mix(tex, tex2, 0.3);
  // gl_FragData[1] = mix(tex3, tex5, 0.5) + tex4;
  // gl_FragData[1] = (tex - tex2) + sunAngle + normal;
  // gl_FragData[1] = vec4(normal, 1.0f);
}
