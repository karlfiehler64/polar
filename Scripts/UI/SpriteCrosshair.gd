extends Sprite2D

var default_scale : Vector2
var crosshair_speed : float = 10

var max_crosshair_scale : float = 0.4
var crosshair_scale_strength : float = 40


func _ready():
	var viewport_size = get_viewport_rect()
	position = viewport_size.size / 2
	
	default_scale = scale

	
func _process(delta):
	scale = lerp(scale, default_scale, crosshair_speed * delta)
	

func crosshair_move():
	scale.x += crosshair_scale_strength * get_process_delta_time()
	scale.y += crosshair_scale_strength * get_process_delta_time()
	scale.x = clamp(scale.x, 0, max_crosshair_scale)
	scale.y = clamp(scale.x, 0, max_crosshair_scale)

