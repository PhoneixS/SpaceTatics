extends Control


func _on_start_skirmish_pressed() -> void:
	
	# "save" the information to the global
	SkirmisInfo.players_info = []
	var player1 = Player.new()
	player1.nick = $MarginContainer/VBoxContainer/GridContainer/TextEdit1.text
	SkirmisInfo.players_info.append(player1)
	
	var player2 = Player.new()
	player2.nick = $MarginContainer/VBoxContainer/GridContainer/TextEdit2.text
	SkirmisInfo.players_info.append(player2)
	
	get_tree().change_scene_to_file("res://screens/main_battle.tscn")
