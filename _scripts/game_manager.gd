extends Node

var player : Player
@export var curr_level_index : int = 0
@export var levels : Levels
@export var tutorial_data : Array[TutorialData]

const mission_complete_scene : PackedScene = preload("res://_scenes/mission_complete.tscn")
const win_scene : PackedScene = preload("res://_scenes/you_win.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalController.on_check_win_condition.connect(win)

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
	
func load_level_with_string(scene_path : String):
	get_tree().change_scene_to_file(scene_path)

func load_level(level_index : int) -> String:
	var scene_path := levels.scene_paths[level_index]
	get_tree().change_scene_to_file(scene_path)
	return scene_path

func load_next_level() -> void:
	curr_level_index += 1		
	load_level(curr_level_index)
	
func win() -> void:
	await get_tree().create_timer(1.0).timeout
	
	var num_worms : int = get_num_worms_in_level()
	print ("Check win. num worms: ", num_worms)
	
	if num_worms == 0:
		print ("curr level index: ", curr_level_index, ". total levels: ", levels.scene_paths.size())
		if curr_level_index + 1 == levels.scene_paths.size():
			show_win_scene()
		else:
			show_mission_complete()

func get_num_worms_in_level() -> int:
	var worms = get_tree().get_nodes_in_group("worms")
	var num_worms := worms.size()
	
	if num_worms == 0:
		return 0
	else:
		num_worms = 0
		for worm in worms:
			if worm.get_state() != Worm.WormStateEnum.CAUGHT:
				print ("worm state: ", worm.get_state())
				num_worms += 1
	
	return num_worms

func get_tutorial_data_for_level(level: int) -> TutorialData:
	return tutorial_data[level]
						
func get_tutorial_data_for_curr_level() -> TutorialData:
	if tutorial_data.size() - 1 > curr_level_index:
		return get_tutorial_data_for_level(curr_level_index)
	else:
		return null
	
func show_mission_complete() -> void:
	var mission_complete_instance := mission_complete_scene.instantiate()
	get_tree().current_scene.add_child(mission_complete_instance)

func show_win_scene() -> void:
	print ("show win scene")
	var win_scene_instance := win_scene.instantiate()
	get_tree().current_scene.add_child(win_scene_instance)
