extends Node3D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary") and rules.peer_ok(2):
		rules.peers = 2
		var marker := rules.spawn_marker()
		var spot := Vector3(float(marker), 0.6, 0)
		rules.note_spot(marker, spot)
		rules.apply_hit(1)
		$PitPin.position = spot
