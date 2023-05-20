extends Node3D

@onready var current_object : Node3D = self.get_child(0)

@export var default_position : Vector3 

var max_aim_sway : float = 40
var max_walk_sway : Vector2 = Vector2(200,200)

func _process(delta):
	position.x = lerp(position.x, default_position.x, delta * 5)
	position.z = lerp(position.z, default_position.z, delta * 5)
	position.y = lerp(position.y, default_position.y, delta * 5)
	var input_dir = Input.get_vector("left", "right", "up", "down")
	walk_sway(Vector2(input_dir.x, -input_dir.y))
	
func walk_sway(sway_amount):
	#sway_amount = clamp(sway_amount, 0, max_walk_sway)
	position.x += sway_amount.x * 0.005
	position.z += sway_amount.y * 0.005
	

func aim_sway(sway_amount):
	sway_amount.x = clamp(sway_amount.x, -max_aim_sway, max_aim_sway)
	sway_amount.y = clamp(sway_amount.y, -max_aim_sway, max_aim_sway)
	position.x += sway_amount.x * 0.0005
	position.y += sway_amount.y * 0.0005
	print(clamp(sway_amount.x, -max_aim_sway, max_aim_sway))
