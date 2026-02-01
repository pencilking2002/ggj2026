extends Node

var player : Player
@export var curr_level : int = 0
@export var levels : Levels

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func get_player() -> Player:
	if player == null:
		if get_tree().get_nodes_in_group("player").size() > 0:
			player = get_tree().get_nodes_in_group("player")[0] as Player
		else: 
			print ("Player not found in scene")
	
	return player
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
