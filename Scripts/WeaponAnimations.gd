extends Node3D

@onready var current_object : Node3D = $PlayerRigPlaceholder/M4A1
@onready var camera = $".."
@onready var player = $"../.."

@export var default_position : Vector3 
@export var default_angle : Vector3
@onready var player_object = $PlayerRigPlaceholder/M4A1

var max_aim_sway : float = 40
var max_walk_sway : Vector2 = Vector2(200,200)

@export var aim_sway_strength : float = 0.001
@export var walk_sway_strength : float = 0.003
@export var jump_sway_strength : float = 0.0005




var input_dir : Vector2 = Vector2()

var random : RandomNumberGenerator

var is_reloading : bool = false

#CHECK IF ANY OF THIS IS AFFECTED BY FRAMERATE

func _ready():
	random = RandomNumberGenerator.new()
	

func _process(delta):
	is_reloading = player_object.is_reloading
	
	position.x = lerp(position.x, default_position.x, delta * 5)
	position.z = lerp(position.z, default_position.z, delta * 5)
	position.y = lerp(position.y, default_position.y, delta * 5)
	input_dir = Input.get_vector("left", "right", "up", "down")
	walk_sway(Vector2(input_dir.x, -input_dir.y), walk_sway_strength)
	
	jump_sway(player.velocity.y, jump_sway_strength)
	
func walk_sway(sway_amount, strength):
	#sway_amount = clamp(sway_amount, 0, max_walk_sway)
	position.x += sway_amount.x * strength
	position.z += sway_amount.y * strength
	
func jump_sway(sway_amount, strength):
	position.y += sway_amount * strength
	
func shot_sway(strength):
	position.x += random.randf_range(-strength, strength)
	position.y += random.randf_range(-strength / 2, strength / 2)
	
func aim_sway(sway_amount, strength):
	sway_amount.x = clamp(sway_amount.x, -max_aim_sway, max_aim_sway)
	sway_amount.y = clamp(sway_amount.y, -max_aim_sway, max_aim_sway)
	position.x += sway_amount.x * strength
	position.y += sway_amount.y * strength
	
func _input(event):
	if event is InputEventMouseMotion:
		aim_sway(Vector2(event.relative.x, event.relative.y), aim_sway_strength)
