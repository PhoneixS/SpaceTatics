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
	self.current_index += 1
	if (self.current_index >= self.ships.size()):
		self.current_index = -1
		self._update_active_ship()
		self.turn_ended.emit()
	else:
		self._update_active_ship()

func end_turn() -> void:
	self.active_turn = false
	for ship in self.ships:
		ship.active_turn = false

func start_turn() -> void:
	self.active_turn = true
	self.current_index = 0
	self._update_active_ship()
