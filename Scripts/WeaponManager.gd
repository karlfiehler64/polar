extends Node3D


var current_weapon : Node3D 
var is_reloading : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	current_weapon = $M4A1
	is_reloading = current_weapon.is_reloading
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_reloading = current_weapon.is_reloading
