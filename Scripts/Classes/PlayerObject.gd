class_name PlayerObject

var object_name : String
var current_ammo: int
var ammo : int
var range : float

func _init(_object_name : String, _current_ammo : int, _ammo : int , _range : float):
	object_name = _object_name
	current_ammo = _current_ammo
	ammo = _ammo
	range = _range
	
