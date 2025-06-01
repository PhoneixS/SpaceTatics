extends Node
class_name TurnManager

var ships: Array[Ship] = []
var current_index := 0

func register_ships(new_ships: Array[Ship]) -> void:
	ships = new_ships
	current_index = 0
	_update_active_ship()

func end_turn() -> void:
	current_index = (current_index + 1) % ships.size()
	_update_active_ship()

func _update_active_ship() -> void:
	for i in range(ships.size()):
		ships[i].active_turn = (i == current_index)
