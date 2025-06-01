extends Node2D

func _ready() -> void:
	var ships : Array[Ship] = []
	ships.append_array(get_tree().get_nodes_in_group("Ships"))
	($TurnManager as TurnManager).register_ships(ships)
