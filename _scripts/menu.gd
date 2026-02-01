extends Control
@export var audio_fade_in_duration := 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_menu_music(audio_fade_in_duration)
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			start_game()
	elif event is InputEventMouseButton:
		if event.pressed:
			start_game()

func start_game() -> void:
	SoundManager.play_sound_geiger_single()
	SoundManager.stop_menu_music()
	var curr_level := GameManager.curr_level
	var level_to_load : String = GameManager.levels.scene_paths[curr_level]
	print ("Level to load: ", level_to_load)
	get_tree().change_scene_to_file(level_to_load)
