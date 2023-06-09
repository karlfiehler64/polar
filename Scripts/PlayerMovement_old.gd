extends CharacterBody3D

@onready var game_manager = $GameManager
@onready var walk_animation_player = game_manager.walk_animation_player
@onready var walk_animation_tree = game_manager.walk_animation_tree
@onready var walk_state_machine = walk_animation_tree["parameters/playback"]
@onready var audiostream_player = game_manager.audio_stream_player
@onready var weapon_manager = $Camera3D/WeaponAnimations/WeaponManager

const walk_speed : float  = 5
const sprint_speed : float = 10
const acceleration : float = 0.1
const decceleration : float = 0.
const JUMP_VELOCITY = 5
const air_influence : float = 0.2
const max_air_speed : float = 8


var minimum_animation_speed_threshold : float = 0.4

var current_direction : Vector3 

var random : RandomNumberGenerator

var audio_pitch_range : float = 0.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	random = RandomNumberGenerator.new()
	

func _physics_process(delta):
	var smoothed_input = Vector2()
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "up", "down")
	if input_dir == null:
		input_dir = Vector2(0,0)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if Input.is_action_pressed("sprint"):
		walk_state_machine.travel("sprint")
	else:
		walk_state_machine.travel("walk")
	
	if is_on_floor():
		if direction:
			velocity.x = direction.x * 20
			velocity.z = direction.z * 20
		else:
			velocity.x = move_toward(velocity.x, 0, decceleration)
			velocity.z = move_toward(velocity.z, 0, decceleration)
#
		
	if velocity.length() > minimum_animation_speed_threshold and !weapon_manager.is_reloading:
		audiostream_player.pitch_scale = random.randf_range(1 - audio_pitch_range, audio_pitch_range)
	else:
		walk_state_machine.travel("idle")

	move_and_slide()
	#divide velocity magnitude by max speed so the value is between 0 and 1 for blendtree
	
	walk_animation_player.speed_scale = 10000
	
func _process(delta):
	if Input.is_action_pressed("exit"):
			get_tree().quit()

