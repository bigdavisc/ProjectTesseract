extends Node2D

var player_name = ""

func _on_TextField_text_changed(new_text):
	player_name = $TextField.text

func _on_JoinButton_pressed():
	if player_name == "":
		return
	_load_game()

func _load_game():
	get_tree().change_scene('res://Lobby.tscn')
	
