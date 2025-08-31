extends Node2D

var grid: SpaceGrid

func _ready() -> void:
	var players: Array[Player] = SkirmisInfo.players_info
	
	var grid: SpaceGrid = preload("res://elements/space_grid.tscn").instantiate()
	grid.initialize(10, 10)
	
	var x: int = 0
	var y: int = 0
	for player in players:
		for ship in player.ships:
			grid.set_value(x, y, ship)
			grid.move_ship_to_grid(ship, Vector2(x, y))
			x += 1
		y = grid.height - 1
		x = 0
	
	self.add_child(grid)
	
	$TurnManager.initialize_battle()
	$Hud.initialize_battle()

func _on_turn_ended() -> void:
	$TurnManager.end_turn()


func _on_next_ship() -> void:
	$TurnManager.next_ship()
