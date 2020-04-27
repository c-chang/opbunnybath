#version 120

varying vec4 texcoord;

uniform sampler2D gcolor;
uniform sampler2D gnormal;
uniform sampler2D gdepth;

const int RGBA16 = 1;
<<<<<<< HEAD
const int gcolorFormat = RBGA16;
=======
const int gcolorFormat = RGBA16;
>>>>>>> 719abbc5627b1981dbbce9a9fe8e08740a321742

/* DRAWBUFFERS:012 */

void main() {
<<<<<<< HEAD
    vec3 finalComposite = texture2D(gcolor, texcoord.st).rgb;
    vec3 finalCompositeNorm = texture2D(gcolor, texcoord.st).rgb;
    vec3 finalCompositeDepth = texture2D(gcolor, texcoord.st).xyz;

    gl_FragData[0] =vec4(finalComposite, 1.0);
    gl_FragData[1] =vec4(finalCompositeNorm, 1.0);
    gl_FragData[2] =vec4(finalCompositeDepth, 1.0);
}
=======

  vec3 finalComposite = texture2D(gcolor, texcoord.st).rgb;
  vec3 finalCompositeNormal = texture2D(gnormal, texcoord.st).rgb;
  vec3 finalCompositeDepth = texture2D(gdepth, texcoord.st).rgb;


  gl_FragData[0] = vec4(finalComposite, 1.0);
  gl_FragData[1] = vec4(finalCompositeNormal, 1.0);
  gl_FragData[2] = vec4(finalCompositeDepth, 1.0);
}
>>>>>>> 719abbc5627b1981dbbce9a9fe8e08740a321742
