extends Node3D

var current_ammo : int = 30
var ammo : int = 30
var object_name : String = "M4A4"
var range : float = 100

func reload():
	print("reloading")
	current_ammo = ammo
	


