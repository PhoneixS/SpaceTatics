extends Control

func _on_start_skirmish_pressed() -> void:
	
	# "save" the information to the global
	SkirmisInfo.players_info = []
	var player1: Player = Player.new()
	player1.nick = ($MarginContainer/VBoxContainer/GridContainer/TextEdit1 as TextEdit).text
	var species: int = ($MarginContainer/VBoxContainer/GridContainer/MenuButton1 as OptionButton).selected - 1
	if species < 0:
		species = randi() % SkirmisInfo.Species.size()
	player1.species = species
	self.generate_player_ships(player1)
	
	SkirmisInfo.players_info.append(player1)
	
	var player2: Player = Player.new()
	player2.nick = ($MarginContainer/VBoxContainer/GridContainer/TextEdit2 as TextEdit).text
	species = ($MarginContainer/VBoxContainer/GridContainer/MenuButton2 as OptionButton).selected - 1
	if species < 0:
		species = randi() % SkirmisInfo.Species.size()
	player2.species = species
	self.generate_player_ships(player2)
	SkirmisInfo.players_info.append(player2)
	
	get_tree().change_scene_to_file("res://screens/main_battle.tscn")

func generate_player_ships(player: Player) -> void:
	var ships: Array[Ship] = []
	for i in 2:
		var ship = preload("res://elements/ship.tscn").instantiate()
		ship.position = Vector2(i * 100, i * 200)
		ships.append(ship)
	
	player.register_ships(ships)
