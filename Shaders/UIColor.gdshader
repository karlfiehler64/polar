shader_type canvas_item;

uniform vec4 new_color : source_color;

void fragment() {
    COLOR = texture(TEXTURE, UV) * new_color;
}
