extends Node2D
class_name  Ship

signal ship_selected()
signal ship_deselected()

var active_turn := false
var _selected := false
var space_grid: SpaceGrid
var destination: Vector2
var max_distance := 3.0
var consumed_distance := 0.0
var original_position: Vector2
var move_animation_speed := 1.0
var move_animation_progress := 0.0

var selected: bool:
	get():
		return self._selected
	set(value):
		if value:
			ship_selected.emit()
		elif _selected:
			ship_deselected.emit()
		_selected = value
		var spriteResaltado := ($Sprite2D as Sprite2D)
		spriteResaltado.set_instance_shader_parameter("resaltar", _selected)
		spriteResaltado.set_instance_shader_parameter("outline_color", ship_color)

@export var ship_color : Color:
	set(value):
		($ColorTag as Sprite2D).modulate = value
	
	get():
		return ($ColorTag as Sprite2D).modulate

func is_valid_move(grid_destination: Vector2) -> bool:
	return (grid_destination - self.space_grid.global_to_grid(self.destination)).length() <= (self.max_distance - self.consumed_distance)

func _ready() -> void:
	self.original_position = self.position
	add_to_group("Ships")

func _physics_process(delta: float) -> void:
	if !self.position.is_equal_approx(self.destination):
		self.move_animation_progress += delta * self.move_animation_speed
		self.position = lerp(self.original_position, self.destination, self.move_animation_progress)
		if self.position.is_equal_approx(self.destination):
			self.position = self.destination
			self.original_position = self.position
			self.move_animation_progress = 0
			self.space_grid.queue_redraw()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_ship") and self.selected:
		var grid_destination := self.space_grid.global_to_grid(get_global_mouse_position())
		if self.is_valid_move(grid_destination):
			self.consumed_distance += (grid_destination - self.space_grid.global_to_grid(self.destination)).length()
			self.space_grid.move_ship(self, get_global_mouse_position(), true)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not active_turn:
		return

	if event.is_action_pressed("select_ship"):
		self.selected = not self.selected

func _on_ship_selected() -> void:
	self.space_grid.selected_ship = self

func _on_ship_deselected() -> void:
	if self.space_grid.selected_ship == self:
		self.space_grid.selected_ship = null
