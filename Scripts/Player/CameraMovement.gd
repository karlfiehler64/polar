extends Camera3D

@onready var player : CharacterBody3D = self.get_parent()

@onready var weapon_manager = $WeaponAnimations/WeaponManager

var camera_shake_amount_vertical : float = 0.0
var camera_shake_amount_horizontal : float = 0.0

var default_rotation : Vector3

var random : RandomNumberGenerator

var mouse_sensitivity : float = 40

func _ready():
	default_rotation = rotation
	random = RandomNumberGenerator.new()
	
	camera_shake_amount_vertical = weapon_manager.current_weapon.spray_strength
	camera_shake_amount_horizontal = weapon_manager.current_weapon.spray_strength

func _process(delta):
	rotation.z = 0
	
	camera_shake_amount_vertical = weapon_manager.current_weapon.spray_strength
	camera_shake_amount_horizontal = weapon_manager.current_weapon.spray_strength

func _input(event):
	if event is InputEventMouseMotion:
		player.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity * get_process_delta_time()))
		rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity * get_process_delta_time()))
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))

func camera_shake(delta):
	rotation.x += camera_shake_amount_vertical * get_process_delta_time()
	rotation.y += random.randf_range(-1, 1) * camera_shake_amount_horizontal * get_process_delta_time()
	
	
		
