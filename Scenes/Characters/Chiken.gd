extends CharacterBody3D

@onready var navigation_agent = $NavigationAgent3D
@onready var player = get_tree().get_nodes_in_group("player")[0]

var speed : float = 100
var hp : float = 100
var wait_time : float = 2

@export var x_size_max : float
@export var x_size_min : float
@export var y_size_max : float
@export var y_size_min : float

var random : RandomNumberGenerator
var timer : Timer

var target_pos : Vector3 = global_transform.origin

func _ready():
	random = RandomNumberGenerator.new()
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", _update_target_location)
	
	target_pos = global_transform.origin
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_location = global_transform.origin
	
	var next_location = NavigationServer3D.map_get_closest_point(get_world_3d().get_navigation_map(), target_pos)
	print(next_location)
	print(current_location)
	var new_direction = (current_location - next_location) * speed * delta
	
	if global_transform.origin.distance_to(next_location) < 0.01:
		_update_target_location()
	
	look_at(target_pos)
	
	velocity = velocity.move_toward(new_direction, 1)
	move_and_slide()
	
	if hp <= 0:
		queue_free()
	
func _update_target_location():
	var x = random.randf_range(x_size_min, x_size_max)
	var y = random.randf_range(y_size_min, y_size_max)
	
	target_pos = Vector3(x, -13.0, y) 
	
func _get_location_from_player(location):
	target_pos = location

func hit(damage):
	hp -= damage
