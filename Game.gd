extends Spatial

func _ready():
	#Create outself first
	var thisPlayer = preload("res://Entities/Player/Player.tscn").instance()
	thisPlayer.set_name(str(get_tree().get_network_unique_id()))
	thisPlayer.set_network_master(get_tree().get_network_unique_id())
	add_child(thisPlayer)
	
	#Create other player
	var otherPlayer = preload("res://Entities/Player/Player.tscn").instance()
	otherPlayer.set_name(str(globals.otherPlayerId))
	otherPlayer.set_network_master(globals.otherPlayerId)
	add_child(otherPlayer)