extends Node3D



@onready var weapon_manager = $"../Camera3D/WeaponAnimations/WeaponManager"

@onready var hp_label = $HPLabel
@onready var ammo_label = $AmmoLabel

func _ready():
	pass # Replace with function body.


func _process(delta):
	ammo_label.text = str(weapon_manager.current_weapon.current_ammo)
