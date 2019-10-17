extends Control

var player_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_TextField_text_changed(new_text):
	player_name = new_text

func _on_CreateButton_pressed():
	if player_name == "":
		return
	Network.create_server(player_name)
	_load_game()

func _on_JoinButton_pressed():
	if player_name == "":
		return
	Network.connect_to_server(player_name)
	_load_game()

func _load_game():
	get_tree().change_scene('res://World.tscn') #Path to world


