extends Node3D

@onready var current_object : Node3D = self.get_child(0)

@export var default_position : Vector3 

func _process(delta):
	position.x = lerp(position.x, default_position.x, delta * 5)
	position.z = lerp(position.z, default_position.z, delta * 5)
	position.y = lerp(position.y, default_position.y, delta * 5)
	var input_dir = Input.get_vector("left", "right", "up", "down")
	walk_sway(Vector2(input_dir.x, -input_dir.y))
	
func walk_sway(sway_amount):
	position.x += sway_amount.x * 0.005
	position.z += sway_amount.y * 0.005

func aim_sway(sway_amount):
	position.x += sway_amount.x * 0.0005
	position.y += sway_amount.y * 0.0005
