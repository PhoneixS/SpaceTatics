extends CanvasLayer

# Notifies that the user wants to end the current turn.
signal turn_ended

var turn_manager: TurnManager

func _on_ready() -> void:
	self.turn_manager = get_parent().get_node("TurnManager")
	self._set_player_properties(self.turn_manager.get_current_player())
	self.turn_manager.player_changed.connect(_on_turn_manager_player_changed)

func _on_end_turn_pressed() -> void:
	self.turn_ended.emit()

func _on_turn_manager_player_changed(_oldPlayer: Player, newPlayer: Player, _idx: int) -> void:
	self._set_player_properties(newPlayer)
	

func _generate_player_label_text(player: Player) ->  String:
	return player.nick + " - " + str(SkirmisInfo.Species.find_key(player.species))

func _set_player_properties(player: Player) -> void:
	($MarginContainer/HBTop/PlayerNick as Label).text = _generate_player_label_text(player)
	($MarginContainer/HBTop/PlayerColor as ColorRect).color = player.color
