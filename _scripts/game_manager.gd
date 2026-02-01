extends Node

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func get_player() -> Player:
	if player == null:
		player = get_tree().get_nodes_in_group("player")[0] as Player
	
	return player
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
