extends Camera3D

@onready var player : CharacterBody3D = self.get_parent()

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

func _process(delta):
	rotation.z = 0
	_delta = delta
	
		
#	rotation.x = lerp(rotation.x, default_rotation.x, delta * 5)
#	rotation.z = lerp(rotation.z, default_rotation.z, delta * 5)
#	rotation.y = lerp(rotation.y, default_rotation.y, delta * 5)
		
		
func camera_shake(strength_vertical, strength_horizontal):
	rotation.x += strength_vertical
	rotation.y += random.randf_range(-1, 1) * strength_horizontal
	
	
#TODO
#handle queing of shots for smoother shot feel
		
