extends AnimationPlayer


func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		play("nuclear_bomb")
