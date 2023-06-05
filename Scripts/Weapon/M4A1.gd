extends Node3D

@onready var player_manager = $"../../../../PlayerManager"
@onready var animation_player = $AnimationPlayer_M4A1
@onready var audiostream_player = $test

@onready var weapon_animations = $"../.."
@onready var camera = player_manager.current_camera
@onready var crosshair = $crosshair
@onready var raycast = $"../../../RayCast3D"

@export var shoot_sound : AudioStream 
var shoot_audio_change : float = 0.05
@export var reload_sound : AudioStream 
var reload_volume_boost : float = 2.0

@export var out_of_ammo_sound : AudioStream 

var current_ammo : int = 30
var ammo : int = 30
var damage : float = 18
var object_name : String = "M4A1"
var range : float = 100
var can_shoot : bool = true
var is_reloading : bool = false
var rpm : int = 800
var spray_strength : float = 10
var equip_time : float = 1
var is_equipped : bool = true

var shot_timer : Timer 
var random : RandomNumberGenerator

#connect animation player timeout signal

func _ready():
	#raycast.target_position.z = -range
	process_mode = Node.PROCESS_MODE_INHERIT
	shot_timer = Timer.new()
	shot_timer.wait_time = 1.0 / (rpm / 60)
	shot_timer.one_shot = true
	add_child(shot_timer)
	
	shot_timer.timeout.connect(_on_shot_Timer_timeout)
	animation_player.connect("animation_finished", _on_animation_player_animation_finished)
	
	animation_player.speed_scale = rpm / 60
	
	random = RandomNumberGenerator.new()

func _process(delta):
	if Input.is_action_pressed("action") and can_shoot == true and current_ammo > 0 and !is_reloading:
		crosshair.crosshair_move(delta)
		audiostream_player.pitch_scale = random.randf_range(1 - shoot_audio_change, 1 + shoot_audio_change)
		audiostream_player.stream = shoot_sound
		audiostream_player.play()
		animation_player.play("object_shoot")
		camera.camera_shake(delta)
		current_ammo -= 1
		shot_timer.start()
		can_shoot = false
		
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider.is_in_group("enemy"):
				collider.hit(damage)
				print(collider.global_transform.origin)
				player_manager.enemy_hit(collider)
				

	if Input.is_action_pressed("action") and current_ammo <= 0:
		if !audiostream_player.is_playing():
			audiostream_player.stream = out_of_ammo_sound		
			audiostream_player.play()
		
	if Input.is_action_pressed("reload") and !is_reloading:
		reload()
		

func reload():
	#audiostream_player.volume_db = 0.0
	can_shoot = false
	is_reloading = true
	current_ammo = ammo
	animation_player.speed_scale = 1
	animation_player.play("object_reload")
	audiostream_player.stream = reload_sound
	audiostream_player.volume_db = 10
	audiostream_player.play()
	
	
func unequip():
	animation_player.speed_scale = 1
	is_equipped = false
	animation_player.play("object_unequip")
	
	
func equip():
	animation_player.speed_scale = 1
	is_equipped = false
	animation_player.play("object_equip")
	
	
func _on_shot_Timer_timeout():
	can_shoot = true
	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "object_reload":
		can_shoot = true
		is_reloading = false
		animation_player.speed_scale = rpm / 60
	
	
