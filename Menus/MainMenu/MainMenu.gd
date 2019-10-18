extends Control

var player_name = ""

func _on_ConnectButton_pressed():
	player_name = $VerticalBoxes/Username/Field.text
	if player_name == "":
		return
	_load_game()


func _load_game():
	get_tree().change_scene('res://Menus/Lobby/Lobby.tscn')
	