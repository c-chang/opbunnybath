#version 120

varying vec4 texcoord;
varying vec3 tcolor;

void main() {
  gl_Position = ftransform();

  texcoord = gl_MultiTexCoord0;

}
