extends CanvasLayer

# Notifies that the user wants to end the current turn.
signal turn_ended
signal next_ship

var turn_manager: TurnManager

func initialize_battle() -> void:
	self.turn_manager = get_parent().get_node("TurnManager")
	self._set_player_properties(self.turn_manager.get_current_player())
	self.turn_manager.player_changed.connect(_on_turn_manager_player_changed)
	self.turn_manager.ship_selected.connect(_on_turn_manager_ship_selected)
	self.turn_manager.next_ship()

func _on_end_turn_pressed() -> void:
	self.turn_ended.emit()

func _on_next_ship_pressed() -> void:
	self.next_ship.emit()

func _on_turn_manager_player_changed(_oldPlayer: Player, newPlayer: Player, _idx: int) -> void:
	self._set_player_properties(newPlayer)



func _generate_player_label_text(player: Player) ->  String:
	return player.nick + " - " + str(SkirmisInfo.Species.find_key(player.species))

func _set_player_properties(player: Player) -> void:
	($MarginContainer/HBTop/PlayerNick as Label).text = _generate_player_label_text(player)
	($MarginContainer/HBTop/PlayerColor as ColorRect).color = player.color

func _on_turn_manager_ship_selected(ship: Ship) ->  void:
	var weapon_list := $MarginContainer/HBBotton/NextShip/ShipHud/HBoxContainer/PanelContainer2/WeaponsList as ItemList
	weapon_list.clear()
	for weapon in ship.get_weapons():
		weapon_list.add_item(weapon.name)
