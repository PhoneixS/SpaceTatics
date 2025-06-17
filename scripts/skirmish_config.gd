extends Control


func _on_start_skirmish_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/main_battle.tscn")
