extends CharacterBody3D

@export var gravity_multiplier := 3.0
@export var walk_speed := 7.0
@export var crouch_walk_speed := 5
@export var sprint_speed := 12
@export var acceleration := 8
@export var deceleration := 10
@export_range(0.0, 1.0, 0.05) var air_control := 0.8
@export var jump_height := 10

@onready var player_manager = $PlayerManager
@onready var camera = player_manager.current_camera
@onready var crouch_animation_player = player_manager.crouch_animation_player

var direction := Vector3()
var last_direction := Vector3()
var input_axis := Vector2()
var current_speed := 5.0
var is_crouching : bool = false

@onready var gravity: float = (ProjectSettings.get_setting("physics/3d/default_gravity") * gravity_multiplier)

func _physics_process(delta: float) -> void:
	input_axis = Input.get_vector("down", "up", "left", "right")
	
	direction_input()
	
	if Input.is_action_just_pressed("crouch"):
		current_speed = crouch_walk_speed
		crouch()
		
	if Input.is_action_just_released("crouch"):
		current_speed = crouch_walk_speed
		un_crouch()
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_height
		
		if Input.is_action_pressed("sprint") and !is_crouching:
			current_speed = sprint_speed
		elif !is_crouching:
			current_speed = walk_speed
	else:
		velocity.y -= gravity * delta
		
	accelerate(delta)
	
	move_and_slide()

func direction_input() -> void:
	direction = Vector3()
	var aim: Basis = camera.global_transform.basis
	direction = aim.z * -input_axis.x + aim.x * input_axis.y
	if direction.length() > 0:
		last_direction = direction


func accelerate(delta: float) -> void:
	# Using only the horizontal velocity, interpolate towards the input.
	var temp_vel := velocity
	temp_vel.y = 0
	
	var target: Vector3
	
	var temp_accel: float
	if is_on_floor():
		target = direction * current_speed
	else:
		target = last_direction * current_speed
	
	if direction.dot(temp_vel) > 0:
		temp_accel = acceleration
	else:
		temp_accel = deceleration
	
	if not is_on_floor():
		temp_accel *= air_control
	
	temp_vel = temp_vel.lerp(target, temp_accel * delta)
	
	velocity.x = temp_vel.x
	velocity.z = temp_vel.z
	
func crouch():
	is_crouching = true
	crouch_animation_player.play("crouch")

func un_crouch():
	is_crouching = false
	crouch_animation_player.play("un_crouch")
