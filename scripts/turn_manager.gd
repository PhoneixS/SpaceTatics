extends Node
class_name TurnManager

var players: Array[Player] = []
var current_player_idx = 0

signal player_changed(oldPlayer: Player, newPlayer: Player, newIdx: int)

func register_players(new_players: Array[Player]) -> void:
	self.players = new_players
	current_player_idx = 0
	_update_active_player()

func _update_active_player() -> void:
	for i in range(self.players.size()):
		self.players[i].active_turn = (i == current_player_idx)

func get_current_player() -> Player:
	return self.players[self.current_player_idx]

func end_turn() -> void:
	var oldPlayer = self.players[current_player_idx]
	current_player_idx = (current_player_idx + 1) % players.size()
	self.player_changed.emit(oldPlayer, self.players[current_player_idx], current_player_idx)

func _on_ready() -> void:
	self.register_players(SkirmisInfo.players_info)
	for player in self.players:
		player.turn_ended.connect(end_turn)
