extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_spawn_and_hit() -> void:
	var rules = Rules.new()
	var marker := rules.spawn_marker()
	assert_eq(marker, 1, "first id")
	rules.note_spot(marker, Vector3(2, 0, 0))
	assert_eq(rules.spots[marker], Vector3(2, 0, 0), "spot stored")
	assert_eq(rules.apply_hit(3), 7, "vitality drops")

func test_bad_port() -> void:
	var rules = Rules.new()
	assert_false(rules.port_accepted(0), "zero")
	assert_false(rules.port_accepted(70000), "too high")
	assert_true(rules.port_accepted(24567), "in range")

func test_pit_gate() -> void:
	var rules = Rules.new()
	assert_false(rules.may_pit(0, "127.0.0.1", true), "bad port")
	assert_false(rules.may_pit(7777, "", false), "empty address")
	assert_true(rules.may_pit(7777, "", true), "host")
	assert_true(rules.may_pit(7777, "127.0.0.1", false), "join")
	assert_true(load("res://scenes/pit.tscn") != null, "pit loads")

func test_peer_ok() -> void:
	var rules = Rules.new()
	assert_true(rules.peer_ok(2), "pit count")
	assert_false(rules.peer_ok(5), "fifth peer")
	rules.peers = 5
	assert_false(rules.may_pit(7777, "", true), "too many peers")
	rules.peers = 2
	assert_true(rules.may_pit(7777, "", true), "two peers")
