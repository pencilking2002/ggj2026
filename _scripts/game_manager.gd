extends Node

var player : Player
@export var curr_level_index : int = 0
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
	
func get_curr_level_path() -> String:
	return levels.scene_paths[curr_level_index]

func load_last_level() -> void:
	get_tree().change_scene_to_file(GameManager.get_curr_level_path())
	
func load_level(level_index : int) -> String:
	var scene_path = levels.scene_paths[level_index]
	get_tree().change_scene_to_file(scene_path)
	return scene_path

func check_win_condition() -> bool:
	return get_num_worms_in_level() == 0

func get_num_worms_in_level() -> int:
	return get_tree().get_nodes_in_group("worms").size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
