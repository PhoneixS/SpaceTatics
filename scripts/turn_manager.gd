extends Node
class_name TurnManager

var players: Array[Player] = []
var current_player_idx = 0

func register_players(new_players: Array[Player]) -> void:
	self.players = new_players
	current_player_idx = 0
	_update_active_player()

func _update_active_player() -> void:
	for i in range(self.players.size()):
		self.players[i].active_turn = (i == current_player_idx)


func end_turn() -> void:
	current_player_idx = (current_player_idx + 1) % players.size()
	
