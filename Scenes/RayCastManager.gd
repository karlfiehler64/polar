extends RayCast3D

@onready var weapon_manager = $"../WeaponAnimations/WeaponManager"

var range : float = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	target_position.z = -range

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	range = weapon_manager.current_weapon.range
	target_position.z = -range
