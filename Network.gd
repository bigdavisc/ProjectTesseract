extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const DEFAULT_IP = "10.0.0.241" #IP
const DEFAULT_PORT = 25565
const MAX_PLAYERS = 20

var players = { }
var self_data = { name = '', position = Vector3(360, 180, 0)}
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect('network_peer_disconnected', self, '_player_disconnected')

func create_server(player_nickname):
	self_data.name = player_nickname
	players[1] = self_data
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEFAULT_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)

func connect_to_server(player_nickname):
	self_data.name = player_nickname
	get_tree().connect('connected_to_server', self, '_connected_to_server')
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(peer)

func _connected_to_server():
	players[get_tree().get_network_unique_id()] = self_data
	rpc('_send_player_info', get_tree().get_network_unique_id(), self_data)


func _player_connected(id):
	print('Player connected: ' + str(id))
	players.erase(id)

func _player_disconnected(id):
	#TODO: Remove player from game scene
	print('Player disconnected: ' + str(id))
	players.erase(id)


remote func _send_player_info(id, info):
	if get_tree().is_network_server():
		for peer_id in players:
			rpc_id(id, '_send_player_info', peer_id, players[peer_id])
	players[id] = info
	
	var new_player = load('res://Entities/Player/Player.tscn').instance() #Path to player object
	new_player.name = str(id)
	new_player.set_network_master(id)
	get_tree().get_root().add_child(new_player)
	new_player.init(info.name, info.position, true)

func update_position(id, position):
	pass
