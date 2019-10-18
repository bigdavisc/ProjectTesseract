extends Control

var player_name = ""

func _ready():
	loadUserData()
	
func _on_ConnectButton_pressed():
	player_name = $VerticalBoxes/Username/Field.text
	if player_name == "":
		return
	saveUserData()
	_load_game()


func _load_game():
	get_tree().change_scene('res://Menus/Lobby/Lobby.tscn')
	
func saveUserData():
	var save_data = {
		"username" : $VerticalBoxes/Username/Field.text,
		"password" : $VerticalBoxes/Password/Field.text
	}
	var save_file = File.new()
	save_file.open("user://savedata.save", File.WRITE)
	save_file.store_line(to_json(save_data))
	save_file.close()
	
func loadUserData():
	var save_file = File.new()
	if not save_file.file_exists("user://savedata.save"):
		return
		
	save_file.open("user://savedata.save", File.READ)
	var line = parse_json(save_file.get_line())
	$VerticalBoxes/Username/Field.text = line["username"]
	$VerticalBoxes/Password/Field.text = line["password"]
	save_file.close()