#version 320 es
precision highp float;
in vec2 v_texcoord;
uniform sampler2D tex;
uniform float vibrance;
layout(location = 0) out vec4 fragColor;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    float luma = dot(pixColor.rgb, vec3(0.299, 0.587, 0.114));
    vec3 vibrant = mix(vec3(luma), pixColor.rgb, 1.25);
    fragColor = vec4(clamp(vibrant, 0.0, 1.0), pixColor.a);
}
