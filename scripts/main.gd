extends Node2D

func _ready() -> void:
	var ships : Array[Ship] = []
	ships.append_array(get_tree().get_nodes_in_group("Ships"))
	
	var players : Array[Player] = SkirmisInfo.players_info
	players[0].register_ships(ships)
