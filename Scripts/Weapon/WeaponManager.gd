extends Node3D

@onready var current_weapon = $M4A1

var is_reloading : bool

@onready var M4A1 = $M4A1
@onready var AK47 = $AK47


var weapons : Array = []

var current_weapon_index : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	weapons.append(M4A1)
	weapons.append(AK47)
	
	is_reloading = current_weapon.is_reloading

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_reloading = current_weapon.is_reloading
	
	if Input.is_action_just_pressed("cycle_weapons"):
		change_weapon(AK47)
	
func change_weapon(to):
	current_weapon.animation_player.play("object_unequip")
	current_weapon = to
	
	


