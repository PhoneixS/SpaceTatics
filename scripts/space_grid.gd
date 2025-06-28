extends Area2D

class_name SpaceGrid

var grid: Array[Node2D] = []
var width: int = 0
var height: int = 0

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
	var size: Vector2 = ($CollisionShape2D.shape as RectangleShape2D).size
	var new_pos: Vector2 = Vector2(grid_pos)
	new_pos.x = new_pos.x * size[0] / self.width
	new_pos.y = new_pos.y * size[1] / self.height
	return new_pos

func global_to_grid(global_pos: Vector2) -> Vector2:
	var size: Vector2 = ($CollisionShape2D.shape as RectangleShape2D).size
	var local: Vector2 = self.to_local(global_pos)
	var grid_position: Vector2 = local/size
	grid_position.x = int(grid_position.x * self.width)
	grid_position.y = int(grid_position.y * self.height)
	return grid_position

func move_ship(ship: Ship, new_position: Vector2) -> Vector2:
	var grid_position: Vector2 = self.global_to_grid(new_position)
	ship.position = self.grid_to_global(grid_position)
	return ship.position
