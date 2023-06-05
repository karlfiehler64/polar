extends Label

var frame_count : int = 0
var frame_time : float = 0

func _process(delta):
	frame_count += 1
	frame_time += delta

	if frame_time >= 1.0: 
		var fps = frame_count / frame_time
		self.text = "FPS: " + str(fps)

		frame_count = 0
		frame_time = 0
