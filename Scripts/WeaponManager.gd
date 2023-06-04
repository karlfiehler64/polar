extends Node3D


var current_weapon : Node3D 
var is_reloading : bool

@onready var M4A1 = $M4A1
@onready var M4A2 = $M4A2


var weapons : Array = []

var current_weapon_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	weapons.append(M4A1)
	weapons.append(M4A2)
	
	current_weapon = weapons[current_weapon_index]
	is_reloading = current_weapon.is_reloading

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_reloading = current_weapon.is_reloading
	


