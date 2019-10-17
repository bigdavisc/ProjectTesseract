extends Control

var player_name = ""

func _on_TextField_text_changed(new_text):
	player_name = $TextField.text
	print(player_name)

func _on_CreateButton_pressed():
	if player_name == "":
		return
	print("It did da ting")
	Network.create_server(player_name)
	_load_game()

func _on_JoinButton_pressed():
	if player_name == "":
		return
	Network.connect_to_server(player_name)
	_load_game()

func _load_game():
	get_tree().change_scene('res://Game.tscn') 
