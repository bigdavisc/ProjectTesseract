extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 25565
const MAX_PLAYERS = 20

var players = { }
var self_data = { name = '', position = Vector3(360, 180, 0)}
var goalIP = "10.0.0.231"
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")

func _player_connected(id):
	print("Player connected to the server!")
	
	globals.otherPlayerId = id
	var game = preload("res://Game.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()

func _on_buttonHost_pressed():
	print("Hosting network")
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(DEFAULT_PORT, MAX_PLAYERS)
	if res != OK:
		print("Error creating server")
		return
		
	$buttonJoin.hide()
	$buttonHost.disabled = true
	get_tree().set_network_peer(host)

func _on_buttonJoin_pressed():
	print("Joining network")
	var host = NetworkedMultiplayerENet.new()
	host.create_client(goalIP,DEFAULT_PORT)
	get_tree().set_network_peer(host)
	$buttonHost.hide()
	$buttonJoin.disabled = true