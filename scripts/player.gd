extends Node
class_name Player

var nick: String
var active_turn:= false

var ships: Array[Ship] = []
var current_index := 0

signal turn_ended

func register_ships(new_ships: Array[Ship]) -> void:
	ships = new_ships
	current_index = 0
	_update_active_ship()

func _update_active_ship() -> void:
	for i in range(ships.size()):
		ships[i].active_turn = (i == current_index)

func end_current_ship_turn() -> void:
	current_index += 1
	if (current_index >= ships.size()):
		current_index = -1
		_update_active_ship()
		self.turn_ended.emit()
	else:
		_update_active_ship()
