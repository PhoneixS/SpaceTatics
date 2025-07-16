extends Camera2D

@export var speed = 10
@export var zoom_speed = 1.1

func _input(event: InputEvent) -> void:
	var direction: Vector2 = Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down")
	self.position += direction * self.speed
	
	if event.is_action("zoom_in"):
		print("zooming in!!")
		self.zoom = self.zoom * self.zoom_speed
	elif  event.is_action("zoom_out"):
		self.zoom = self.zoom / self.zoom_speed
