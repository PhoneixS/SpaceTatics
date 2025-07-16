extends Camera2D

@export var speed = 10

func _input(event: InputEvent) -> void:
	var direction: Vector2 = Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down")
	self.position += direction * speed
