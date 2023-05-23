extends Node3D

@onready var current_object : Node3D = $PlayerRigPlaceholder/M4A1
@onready var camera = $".."
@export var default_position : Vector3 
@export var default_angle : Vector3
@onready var player_object = $PlayerRigPlaceholder/M4A1

var max_aim_sway : float = 40
var max_walk_sway : Vector2 = Vector2(200,200)

var input_dir : Vector2 = Vector2()

var random : RandomNumberGenerator

var is_reloading : bool = false

func _ready():
	random = RandomNumberGenerator.new()

func _process(delta):
	is_reloading = player_object.is_reloading
	
	position.x = lerp(position.x, default_position.x, delta * 5)
	position.z = lerp(position.z, default_position.z, delta * 5)
	position.y = lerp(position.y, default_position.y, delta * 5)
	input_dir = Input.get_vector("left", "right", "up", "down")
	walk_sway(Vector2(input_dir.x, -input_dir.y))
	
func walk_sway(sway_amount):
	#sway_amount = clamp(sway_amount, 0, max_walk_sway)
	position.x += sway_amount.x * 0.005
	position.z += sway_amount.y * 0.005
	
func jump_sway(sway_amount):
	position.y += sway_amount * 0.0005
	
func shot_sway(strength):
	position.x += random.randf_range(-strength, strength)
	position.y += random.randf_range(-strength / 2, strength / 2)
	
	
func aim_sway(sway_amount):
	sway_amount.x = clamp(sway_amount.x, -max_aim_sway, max_aim_sway)
	sway_amount.y = clamp(sway_amount.y, -max_aim_sway, max_aim_sway)
	position.x += sway_amount.x * 0.0005
	position.y += sway_amount.y * 0.0005
