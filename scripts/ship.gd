extends Node2D
class_name  Ship

var active_turn := false
var _selected := false
var space_grid: SpaceGrid
var destination: Vector2

var selected: bool:
	get():
		return self._selected
	set(value):
		_selected = value
		var spriteResaltado := ($Sprite2D as Sprite2D)
		spriteResaltado.set_instance_shader_parameter("resaltar", _selected)
		spriteResaltado.set_instance_shader_parameter("outline_color", ship_color)

@export var ship_color : Color:
	set(value):
		($ColorTag as Sprite2D).modulate = value
	
	get():
		return ($ColorTag as Sprite2D).modulate

func _ready() -> void:
	add_to_group("Ships")

func _physics_process(delta: float) -> void:
	if !self.position.is_equal_approx(self.destination):
		self.position = lerp(self.position, self.destination, delta)
		if self.position.is_equal_approx(self.destination):
			self.position = self.destination

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_ship") and self.selected:
		self.space_grid.move_ship(self, get_global_mouse_position(), true)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not active_turn:
		return

	if event.is_action_pressed("select_ship"):
		self.selected = not self.selected
