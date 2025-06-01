extends Node2D
class_name  Ship

@export var grid: TileMap
var active_turn := false
var selected := false

func _ready() -> void:
	add_to_group("Ships")

#
#func _on_grid_cell_clicked(cell: Vector2i):
	#if not active_turn:
		#return
	#if selected:
		#position = grid.map_to_local(cell) + Vector2(grid.tile_set.tile_size) / 2
		#selected = false
		#get_node("/root/Main/TurnManager").end_turn()
	#else:
		#var mouse_pos = grid.get_local_mouse_position()
		#if global_position.distance_to(mouse_pos) < 32:
			#selected = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_ship") and self.selected:
		self.position = get_global_mouse_position()

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not active_turn:
		return

	if event.is_action_pressed("select_ship"):
		selected = not selected
		($Sprite2D as Sprite2D).set_instance_shader_parameter("resaltar", selected)
		
