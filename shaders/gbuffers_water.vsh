#version 120

varying vec4 texcoord;
varying vec3 tintcolor;

void main() {
  gl_Position = ftransform();

  texcoord = gl_MultiTexCoord0;
  tintcolor = gl_Color.rgb;
}
