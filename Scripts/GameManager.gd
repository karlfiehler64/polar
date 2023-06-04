extends Node3D

@onready var current_camera : Camera3D = $"../Camera3D"
@onready var walk_animation_player : AnimationPlayer = $WalkAnimationPlayer
@onready var walk_animation_tree : AnimationTree = $AnimationTree
@onready var crouch_animation_player : AnimationPlayer = $CrouchAnimationPlayer
@onready var audio_stream_player : AudioStreamPlayer3D = $AudioStreamPlayer3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()





