extends Node3D

@onready var world = get_tree().current_scene

@onready var current_camera : Camera3D = $"../Camera3D"
@onready var walk_animation_player : AnimationPlayer = $WalkAnimationPlayer
@onready var walk_animation_tree : AnimationTree = $AnimationTree
@onready var crouch_animation_player : AnimationPlayer = $CrouchAnimationPlayer
@onready var audio_stream_player : AudioStreamPlayer3D = $AudioStreamPlayer3D

@onready var blood_particles = preload("res://Shaders/Particles/EnemyBlood_Particles.tscn")

var fullscreen : bool = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("fullscreen"):
		if fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			fullscreen = false
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			fullscreen = true
			
			

func enemy_hit(collider):
	var blood_particle = blood_particles.instantiate()
	world.add_child(blood_particle)
	blood_particle.global_transform.origin = collider.global_transform.origin

		





