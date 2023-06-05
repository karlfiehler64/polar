extends CharacterBody3D

@onready var navigation_agent = $NavigationAgent3D
@onready var player = get_tree().get_nodes_in_group("player")[0]

var speed : float = 2000
var hp : float = 100

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_target_location(player.global_transform.origin)
	var current_location = global_transform.origin
	var next_location = navigation_agent.get_next_path_position()
	var new_direction = (next_location - current_location).normalized() * speed * delta
	
	look_at(player.global_transform.origin)
	velocity = velocity.move_toward(new_direction, 1)
	move_and_slide()
	
	if hp <= 0:
		queue_free()
	
func _update_target_location(target):
	navigation_agent.target_position = target

func hit(damage):
	hp -= damage
