extends GPUParticles3D


@onready var time_created = Time.get_ticks_msec()

func _process(delta):
	if Time.get_ticks_msec() - time_created > 400:
		queue_free()
