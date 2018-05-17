extends Node

const playerUI = preload("res://ui_prefabs/lobby_player_row.tscn")

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	pass

var playerInfo = {}
var myInfo = {name = "Dappa", faction = "Evil God", color = Color(255,0,0)}

func _player_connected(id):
	pass #Will go unused, not useful here

func _player_disconnected(id):
	playerInfo.erase(id)
	pass # Erase player from info

func _connected_ok():
	rpc("register_player", get_tree().get_network_unique_id(), myInfo)
	pass # Only called on clients, not server. Send my ID and info to all other peers DappaNote: Clients should send to server, and server send to everyone else.

func _server_disconnected():
	pass # Server kicked us, show error and abort

func _connected_fail():
	pass # Could not even connect to server, abort

remote func register_player(id, info):
	playerInfo[id] = info
	# If I'm the server, let the new guy know about existing players
	if get_tree().is_network_server():
		# send my info to new player
		rpc_id(id, "register_player", 1, myInfo)
		# send the info of existing players
		for peer_id in playerInfo:
			rpc_id(id, "register_player", peer_id, playerInfo[peer_id])
	
	var name = playerInfo[id].name
	var faction = playerInfo[id].faction
	var color = playerInfo[id].color
	addPlayerUi(name,faction,color)
	pass

remote func pre_configure_game():
	var selfPeerId = get_tree().get_network_unique_id()
	
	#load world
	pass

func addPlayerUI(name, faction, color):
	var playerNode = playerUI.instance()
	playerNode.setName(name)
	playerNode.setFaction(faction)
	playerNode.setColor(color.r, color.g, color.b)
	$PlayerList.add_child(playerNode)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass