extends Node3D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()
var peer := ENetMultiplayerPeer.new()

@onready var spawn_pin: MeshInstance3D = $SpawnPin

func open_host(port: int) -> int:
	if not rules.port_accepted(port):
		return ERR_INVALID_PARAMETER
	return peer.create_server(port)

func open_join(address: String, port: int) -> int:
	if not rules.port_accepted(port) or address.strip_edges() == "":
		return ERR_INVALID_PARAMETER
	return peer.create_client(address, port)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary") and rules.may_pit(7777, "", true):
		open_host(7777)
		_go("res://scenes/pit.tscn")
	if event.is_action_pressed("leap"):
		open_join("", 7777)

func _go(next_path: String) -> void:
	get_tree().change_scene_to_file(next_path)
