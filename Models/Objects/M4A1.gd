extends Node3D

@onready var animation_player = $"../../../../AnimationPlayer"
@onready var weapon_placeholder = $"../.."

var current_ammo : int = 30
var ammo : int = 30
var object_name : String = "M4A4"
var range : float = 100
var can_shoot : bool = true
var is_reloading : bool = false
var rpm : int = 860
var spray_strength : float = 0.025

var shot_timer : Timer 


func _ready():
	shot_timer = Timer.new()
	shot_timer.wait_time = 1.0 / (rpm / 60)
	shot_timer.one_shot = true
	add_child(shot_timer)
	
	shot_timer.timeout.connect(_on_shot_Timer_timeout)
	
	
	animation_player.speed_scale = rpm / 60

func _process(delta):
	if Input.is_action_pressed("action") and can_shoot == true and current_ammo >= 0 and !is_reloading:
		animation_player.play("object_shoot")
		weapon_placeholder.shot_sway(spray_strength)
		current_ammo -= 1
		shot_timer.start()
		can_shoot = false
	

func reload():
	can_shoot = false
	is_reloading = true
	current_ammo = ammo
	animation_player.speed_scale = 1
	animation_player.play("object_reload")
	

func _on_shot_Timer_timeout():
	can_shoot = true


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "object_reload":
		can_shoot = true
		is_reloading = false
		animation_player.speed_scale = rpm / 60
