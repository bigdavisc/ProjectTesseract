extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 32200
const MIN_PORT_RANGE = 32200
const MAX_PORT_RANGE = 32300
const MAX_PLAYERS = 20

var self_data = { name = ''}
var connectedPlayers = { }
var goalIP = "127.0.0.1"

var username_label = preload("res://Menus/Lobby/UsernameLabel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	loadIP()
	var name_label = username_label.instance()
	name_label.text = UserSettings.user_name
	$Panel/Container/VContainer/Panel/Usernames.add_child(name_label)

func _player_connected(id):
	print("Player connected to the server!")
	
	rpc_id(id, "register_user", UserSettings.user_name)
	print("Current player count: " + str(connectedPlayers.size() + 1))
	#var game = preload("res://Core/Game.tscn").instance()
	#get_tree().get_root().add_child(game)
	#hide()

func _player_disconnected(id):
	print("Player disconnected from the server :(")
	connectedPlayers.erase(id)

func _on_buttonHost_pressed():
	print("Hosting network with IP: " + str(goalIP))
	print("Server is on port: " + str(DEFAULT_PORT))
	
	var upnp = UPNP.new()
	upnp.discover(2000, 2, "InternetGatewayDevice")
	upnp.add_port_mapping(DEFAULT_PORT)
	print("Server (should) also be open on " + str(upnp.query_external_address()) + ":" + str(DEFAULT_PORT))
	
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(DEFAULT_PORT, MAX_PLAYERS)
	if res != OK:
		print("Error creating server")
		return

	var bar = $Panel/Container/VContainer/HContainer
	var joinContainer = bar.get_node("Container/HContainer")
	joinContainer.get_node("buttonJoin").disabled = true
	joinContainer.get_node("IPValue").editable = false
	bar.get_node("LaunchMatch").disabled = false
	bar.get_node("buttonHost").disabled = true
	get_tree().set_network_peer(host)

func _on_buttonJoin_pressed():
	print("Joining network")
	var host = NetworkedMultiplayerENet.new()
	var goalIP = $Panel/Container/VContainer/HContainer/Container/HContainer/IPValue.text
	var res = host.create_client(goalIP,DEFAULT_PORT)
	if res != OK:
		print("Error joining server")
		return
	saveIP()
	get_tree().set_network_peer(host)

func saveIP():
	var save_data = {
		"ip" : $Panel/Container/VContainer/HContainer/Container/HContainer/IPValue.text
	}
	var save_file = File.new()
	save_file.open("user://lastIP.save", File.WRITE)
	save_file.store_line(to_json(save_data))
	save_file.close()

func loadIP():
	var save_file = File.new()
	if not save_file.file_exists("user://lastIP.save"):
		return
		
	save_file.open("user://lastIP.save", File.READ)
	var line = parse_json(save_file.get_line())
	var edit = $Panel/Container/VContainer/HContainer/Container/HContainer/IPValue
	edit.text = line["ip"]
	save_file.close()
		
remote func register_user(name):
	var id = get_tree().get_rpc_sender_id()
	connectedPlayers[id] = name
	var name_label = username_label.instance()
	name_label.text = name
	$Panel/Container/VContainer/Panel/Usernames.add_child(name_label)
	
master func _on_LaunchMatch_pressed():
	game_begin()
	for key in connectedPlayers.keys():
		rpc_id(key, "game_begin")

puppet func game_begin():
	var game = preload("res://Core/Game.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()