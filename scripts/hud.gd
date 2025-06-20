extends CanvasLayer

# Notifies that the user wants to end the current turn.
signal end_turn

var turn_manager: TurnManager

func _on_ready() -> void:
	self.turn_manager = get_parent().get_node("TurnManager")
	($MarginContainer/HBTop/PlayerNick as Label).text = self.turn_manager.get_current_player().nick
