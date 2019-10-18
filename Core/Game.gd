extends Spatial

func _ready():
	#Create ourself first
	var thisPlayer = preload("res://Entities/Player/Player.tscn").instance()
	thisPlayer.set_name(str(get_tree().get_network_unique_id()))
	thisPlayer.set_network_master(get_tree().get_network_unique_id())
	add_child(thisPlayer)
	
	#Create other player
	if globals.current_player_count >= 1:
		var player_list = globals.players.keys()
		for key in player_list:
			var otherPlayer = preload("res://Entities/Player/Player.tscn").instance()
			otherPlayer.set_name(str(globals.players.get(key)))
			otherPlayer.set_network_master(globals.players.get(key))
			add_child(otherPlayer)