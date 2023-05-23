extends CharacterBody3D

@onready var animation_player = $WalkAnimationPlayer
@onready var weapon_placeholder = $Camera3D/WeaponPlaceholder

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const air_density : float = 1

var minimum_animation_speed_threshold : float = 0.4

var current_direction : Vector3 

var animation_weight : float = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	var smoothed_input = Vector2()
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if is_on_floor():
		var input_dir = Input.get_vector("left", "right", "up", "down")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		current_direction = direction
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
		if velocity.length() > minimum_animation_speed_threshold and !weapon_placeholder.is_reloading:
			animation_player.speed_scale = 1.0 / (velocity.length() / SPEED)
			animation_player.play("walk")
		else:
			animation_player.stop()
			
		
		
	elif current_direction:
		velocity.x = current_direction.x * SPEED
		velocity.z = current_direction.z * SPEED

	move_and_slide()
	weapon_placeholder.jump_sway(velocity.y)
	
	#divide velocity magnitude by max speed so the value is between 0 and 1 for blendtree
	var walk_vector = velocity.length() / SPEED
	
		
func _process(delta):
	if Input.is_action_pressed("exit"):
			get_tree().quit()

