extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_size = get_viewport_rect()
	position = viewport_size.size / 2


