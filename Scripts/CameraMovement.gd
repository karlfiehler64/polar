extends Camera3D

@onready var player : CharacterBody3D = self.get_parent()
@onready var raycast : RayCast3D = get_node("RayCast3D")
@onready var animation_player : AnimationPlayer = self.get_parent().get_node("AnimationPlayer")
@onready var player_object : Node3D = $WeaponPlaceholder.current_object
@onready var weapon_placeholder = $WeaponPlaceholder

var default_rotation : Vector3

var _delta : float 

var random : RandomNumberGenerator

var mouse_sensitivity : float = 47

func _ready():
	default_rotation = rotation
	random = RandomNumberGenerator.new()

func _input(event):
	if event is InputEventMouseMotion:
		player.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity * _delta))
		rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity * _delta))
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))
		weapon_placeholder.aim_sway(Vector2(event.relative.x, event.relative.y))

func _process(delta):
	_delta = delta
	#set range of raycast to range of object player is holding
	raycast.target_position.z = -player_object.range
		
	if Input.is_action_just_pressed("reload"):
		player_object.reload()
	
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		
#	rotation.x = lerp(rotation.x, default_rotation.x, delta * 5)
#	rotation.z = lerp(rotation.z, default_rotation.z, delta * 5)
#	rotation.y = lerp(rotation.y, default_rotation.y, delta * 5)
		
		
func camera_shake(strength_vertical, strength_horizontal):
	rotation.x += strength_vertical
	rotation.y += random.randf_range(-1, 1) * strength_horizontal
	
	
#TODO
#handle queing of shots for smoother shot feel
		
