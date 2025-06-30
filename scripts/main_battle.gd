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
			x += 1
			y += 1
	
	self.add_child(grid)

func _on_turn_ended() -> void:
	$TurnManager.end_turn()
