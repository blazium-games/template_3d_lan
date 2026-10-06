extends RefCounted

var next_marker := 1
var vitality := 10
var spots: Dictionary = {}

func spawn_marker() -> int:
	var marker := next_marker
	next_marker += 1
	spots[marker] = Vector3.ZERO
	return marker

func note_spot(marker: int, spot: Vector3) -> void:
	spots[marker] = spot

func apply_hit(amount: int) -> int:
	vitality = maxi(vitality - amount, 0)
	return vitality

var peers := 2

func peer_ok(count: int) -> bool:
	return count >= 1 and count <= 4

func port_accepted(port: int) -> bool:
	return port >= 1 and port <= 65535

func reset_link() -> void:
	next_marker = 1
	vitality = 10
	spots.clear()

func may_pit(port: int, address: String, hosting: bool) -> bool:
	if not peer_ok(peers):
		return false
	if not port_accepted(port):
		return false
	if not hosting and address.strip_edges() == "":
		return false
	return true
