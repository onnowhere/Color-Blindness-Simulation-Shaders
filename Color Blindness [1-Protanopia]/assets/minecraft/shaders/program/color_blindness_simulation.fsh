#version 120

uniform sampler2D DiffuseSampler;
uniform float Mode; //[0 1 2 3 4 5 6 7 8]
varying vec2 texCoord;

/*
	Matrices and logic behind them can be found on https://gist.github.com/Lokno/df7c3bfdc9ad32558bb7
	& on http://mkweb.bcgsc.ca/colorblind/math.mhtml#page-container

	-zenek1290
*/
mat3 protanopia = mat3(			0.170556992,0.170556991,-0.004517144,
														0.829443014,0.829443008,0.004517144,
														0.0,0.0,1.0);

mat3 deuteranopia = mat3(		0.33066007,0.33066007,-0.02785538,
														0.66933993,0.66933993,0.02785538,
														0.0,0.0,1.0);

mat3 tritanopia = mat3(			1.0,0.0,0.0,
														0.1273989,0.8739093,0.8739093,
														-0.1273989, 0.1260907, 0.1260907);

mat3 achromatopsia = mat3(	0.2126, 0.7152, 0.0722,
														0.2126, 0.7152, 0.0722,
														0.2126, 0.7152, 0.0722);

mat3 protanomaly = mat3(		0.817,0.183,0.000,
                 						0.333,0.667,0.000,
                 						0.000,0.125,0.875);

mat3 deuteranomaly = mat3(	0.800,0.200,0.000,
                 						0.258,0.742,0.000,
                 						0.000,0.142,0.858);

mat3 tritanomaly = mat3(		0.967,0.033,0.00,
                 						0.000,0.733,0.267,
                 						0.000,0.183,0.817);

mat3 achromatomaly = mat3(	0.618,0.320,0.062,
                 						0.163,0.775,0.062,
                 						0.163,0.320,0.516);


void main() {
	vec3 color = texture2D(DiffuseSampler, texCoord).rgb;
	vec3 new_color;

	if (Mode == 0.0) {
		new_color = color;
	} else if (Mode == 1.0) {
		new_color = protanopia * color;
	} else if (Mode == 2.0) {
		new_color = deuteranopia * color;
	} else if (Mode == 3.0) {
		new_color = tritanopia * color;
	} else if (Mode == 4.0) {
		new_color = color * achromatopsia;
	} else if (Mode == 5.0) {
	new_color = protanomaly * color;
	} else if (Mode == 6.0) {
		new_color = deuteranomaly * color;
	} else if (Mode == 7.0) {
		new_color = tritanomaly * color;
	} else if (Mode == 8.0) {
		new_color = color * achromatomaly;
	}

	gl_FragColor = vec4(new_color, 1.0);
}
