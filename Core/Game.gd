extends Spatial

func _ready():
	print("Create self: " + UserSettings.user_name)
	#Create ourself first
	var thisPlayer = preload("res://Entities/Player/Player.tscn").instance()
	thisPlayer.set_name(str(get_tree().get_network_unique_id()))
	thisPlayer.set_network_master(get_tree().get_network_unique_id())
	add_child(thisPlayer)
	
	#Create other players
	var connectedPlayers = get_parent().get_node("Lobby").connectedPlayers
	for key in connectedPlayers.keys():
		print("Create player: " + connectedPlayers[key])
		var otherPlayer = preload("res://Entities/Player/Player.tscn").instance()
		otherPlayer.set_name(str(connectedPlayers.get(key)))
		otherPlayer.set_network_master(key)
		add_child(otherPlayer)