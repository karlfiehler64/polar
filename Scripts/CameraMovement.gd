extends Camera3D

@onready var player : CharacterBody3D = self.get_parent()
@onready var raycast : RayCast3D = get_node("RayCast3D")
@onready var animation_player : AnimationPlayer = self.get_parent().get_node("AnimationPlayer")
@onready var player_object : Node3D = $WeaponPlaceholder.current_object
@onready var weapon_placeholder = $WeaponPlaceholder


var mouse_sensitivity : float = 0.1

func _input(event):
	if event is InputEventMouseMotion:
		player.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))
		weapon_placeholder.aim_sway(Vector2(event.relative.x, event.relative.y))

func _process(delta):
	#set range of raycast to range of object player is holding
	raycast.target_position.z = -player_object.range
	
	if Input.is_action_just_pressed("action") and player_object.current_ammo > 0:
		animation_player.play("object_shoot")
		player_object.current_ammo -= 1
	
	elif player_object.current_ammo <= 0:
		print("no more ammo on " + player_object.name)
		

	
	
		
	if Input.is_action_just_pressed("reload"):
		player_object.reload()
	
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		
		
	
	
#TODO
#handle queing of shots for smoother shot feel
		
