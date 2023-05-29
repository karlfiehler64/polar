shader_type spatial;

uniform sampler2D textureSampler;
uniform float speed = 1.0;
uniform vec2 scale = vec2(1.0,1.0);
uniform float blue_intensity = 2.0;

void fragment() {
    // Current time in seconds
    float time = TIME;
    
    // Calculate the new UV coordinates
    vec2 new_uv = (UV * scale) + vec2(time * speed, 0);
    
    // Sample the texture at the new UV coordinates
    ALBEDO = texture(textureSampler, new_uv).rgb;
    ALPHA = texture(textureSampler, new_uv).a;
}
