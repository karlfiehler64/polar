extends Weapon

func _init():
	var current_ammo : int = 30
	var ammo : int = 30
	var damage : float = 30
	var object_name : String = "AK47"
	var range : float = 47
	var can_shoot : bool = true
	var is_reloading : bool = false
	var rpm : int = 800
	var spray_strength : float = 2
	var equip_time : float = 1
	var is_equipped : bool = true
