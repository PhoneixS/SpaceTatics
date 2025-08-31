extends Node
class_name TurnManager

var players: Array[Player] = []
var current_player_idx = 0

signal player_changed(oldPlayer: Player, newPlayer: Player, newIdx: int)

func _initialize_players(new_players: Array[Player]) -> void:
	self.players = new_players
	current_player_idx = 0
	_update_active_player()

func _update_active_player() -> void:
	for i in range(self.players.size()):
		if i == current_player_idx:
			self.players[i].start_turn()
		else:
			self.players[i].end_turn()

func get_current_player() -> Player:
	return self.players[self.current_player_idx]

func end_turn() -> void:
	# Who was before
	var oldPlayer = self.players[current_player_idx]
	# Disable its ships
	oldPlayer.end_turn()
	# Who is the current player
	current_player_idx = (current_player_idx + 1) % players.size()
	var newPlayer = self.players[current_player_idx]
	# Enable its first ship.
	newPlayer.start_turn()
	self.player_changed.emit(oldPlayer, self.players[current_player_idx], current_player_idx)

func next_ship() -> void:
	self.players[self.current_player_idx].end_current_ship_turn()

func initialize_battle() -> void:
	self._initialize_players(SkirmisInfo.players_info)
	# Connect the turn ended event.
	for player in self.players:
		player.turn_ended.connect(self.end_turn)
