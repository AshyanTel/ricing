#version 300 es
precision highp float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main(){
    vec4 c = texture(tex, v_texcoord);
    float m = max(c.r, max(c.g, c.b));
    float s = (m - min(c.r, min(c.g, c.b))) / max(m, 0.001);
    float boost = 1.0 + 0.3 * (1.0 - s);
    vec3 outc = m - (m - c.rgb) * boost;
    fragColor = vec4(clamp(outc, 0.0, 1.0), c.a);

}
