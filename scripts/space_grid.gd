extends Area2D

class_name SpaceGrid

var grid: Array[Node2D] = []
var width: int = 0
var height: int = 0

@export var cell_size = Vector2(100, 100)

func initialize(new_width: int, new_height: int) -> void:
	self.width = new_width
	self.height = new_height
	self.grid.resize(self.width * self.height)
	
func coord_to_indx(x: int, y: int) -> int:
	return x + y * self.width

func indx_to_coord(indx: int) -> Array[int]:
	return [indx % self.width, int(indx / self.width)]

func get_value(x: int, y: int) -> Node2D:
	return self.grid[self.coord_to_indx(x, y)]

func set_value(x: int, y: int, value: Ship) -> void:
	self.grid[self.coord_to_indx(x, y)] = value
	if value:
		value.position = Vector2(x * 100, y*100)
		value.space_grid = self
		self.add_child(value)

func grid_to_global(grid_pos: Vector2) -> Vector2:
	return grid_pos * cell_size

func global_to_grid(global_pos: Vector2) -> Vector2:
	var local: Vector2 = self.to_local(global_pos)
	var grid_position: Vector2 = local/self.cell_size
	grid_position.x = int(grid_position.x)
	grid_position.y = int(grid_position.y)
	return grid_position

func move_ship(ship: Ship, new_position: Vector2, interpolate: bool = false) -> Vector2:
	var grid_position: Vector2 = self.global_to_grid(new_position)
	return self.move_ship_to_grid(ship, grid_position, interpolate)
	
func move_ship_to_grid(ship: Ship, grid_position: Vector2, interpolate: bool = false) -> Vector2:
	var value =  self.grid_to_global(grid_position) + (self.cell_size / 2)
	if interpolate:
		ship.destination = value
	else:
		ship.position = value
		ship.destination = value
	return value

func _draw() -> void:
	
	for x in self.width + 1:
		draw_line(self.to_global(Vector2(x *  self.cell_size.x,0)), self.to_global(Vector2(x * self.cell_size.x, self.cell_size.y * self.height)), Color.AQUA)
		
	for y in self.height + 1:
		draw_line(self.to_global(Vector2(0, y * self.cell_size.y)), self.to_global(Vector2(self.cell_size.x * self.width, y * self.cell_size.y)), Color.AQUA)
