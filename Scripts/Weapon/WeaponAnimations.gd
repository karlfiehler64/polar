extends Node3D

@onready var player = $"../.."
@onready var player_manager = $"../../PlayerManager"

@onready var player_object = $WeaponManager.current_weapon

@onready var default_position : Vector3 = position
@onready var default_angle : Vector3 = rotation

var max_aim_sway : float = 8
var max_walk_sway : Vector2 = Vector2(200,200)
var max_jump_sway : float = 8
var min_sway_threshold : float = 0

@export var aim_sway_strength : float = 0.05
@export var walk_sway_strength : float = 0.1
@export var jump_sway_strength : float = 0.01

var _delta : float 

var input_dir : Vector2 = Vector2()

var random : RandomNumberGenerator

var is_reloading : bool = false

#CHECK IF ANY OF THIS IS AFFECTED BY FRAMERATE

func _ready():
	random = RandomNumberGenerator.new()
	

func _process(delta):
	_delta = delta
	is_reloading = player_object.is_reloading
	
	position.x = lerp(position.x, default_position.x, delta * 5)
	position.z = lerp(position.z, default_position.z, delta * 5)
	position.y = lerp(position.y, default_position.y, delta * 5)
	input_dir = Input.get_vector("left", "right", "up", "down")
	walk_sway(Vector2(input_dir.x, -input_dir.y), walk_sway_strength, delta)
	
	jump_sway(player.velocity.y, jump_sway_strength, delta)
	
func walk_sway(sway_amount, strength, delta):
	#sway_amount = clamp(sway_amount, 0, max_walk_sway)
	position.x += sway_amount.x * strength * delta
	position.z += sway_amount.y * strength * delta
	
func jump_sway(sway_amount, strength, delta):
	sway_amount = clamp(sway_amount, -max_jump_sway, max_jump_sway)
	position.y += sway_amount * strength * delta
	
func aim_sway(sway_amount, strength, delta):
	sway_amount.x = clamp(sway_amount.x, -max_aim_sway, max_aim_sway) 
	sway_amount.y = clamp(sway_amount.y, -max_aim_sway, max_aim_sway)
	position.x += sway_amount.x * strength * delta
	position.y += sway_amount.y * strength * delta
	
func _input(event):
	if event is InputEventMouseMotion:
		if event.relative.length() > min_sway_threshold:
			aim_sway(Vector2(event.relative.x, event.relative.y), aim_sway_strength, _delta)
