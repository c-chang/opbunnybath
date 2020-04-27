#version 120

varying vec4 texcoord;

uniform sampler2D gcolor;

void main() {
<<<<<<< HEAD
    vec3 color = texture2D(gcolor, texcoord.st).rgb;
    // color.g = color.g * 2.0;

    gl_FragColor = vec4(color.rgb, 1.0);
}
=======
	vec3 color = texture2D(gcolor, texcoord.st).rgb;

	// color.g = color.g * 2.0;

	gl_FragColor = vec4(color.rgb, 1.0f);
}
>>>>>>> 719abbc5627b1981dbbce9a9fe8e08740a321742
