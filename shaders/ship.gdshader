shader_type canvas_item;

const float EPSILON = 0.0001;

uniform float outline_size: hint_range(0, 10) = 2.0;

instance uniform vec4 outline_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); // Rojo
instance uniform bool resaltar = false;

void fragment() {

    vec4 tex_color = texture(TEXTURE, UV);

    if (resaltar && tex_color.a < 0.1) {
        float alpha = 0.0;
        for (float x = -outline_size; x <= outline_size; x++) {
            for (float y = -outline_size; y <= outline_size; y++) {
                vec2 offset = vec2(x, y) * TEXTURE_PIXEL_SIZE;
                alpha = max(alpha, texture(TEXTURE, UV + offset).a);
            }
        }
        if (alpha > 0.1) {
            COLOR = outline_color;
        } else {
            discard;
        }
    } else {
        COLOR = tex_color;
    }
}
