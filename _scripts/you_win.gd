extends CanvasLayer

func _ready():
	SoundManager.stop_level_music()
	SoundManager.play_win_music()
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			start_game()
	elif event is InputEventMouseButton:
		if event.pressed:
			start_game()
			
func start_game() -> void:
	SoundManager.play_sound_geiger_single()
	SoundManager.stop_win_music()
	SoundManager.play_level_music()
	GameManager.curr_level_index = 0
	var scene_path : String = GameManager.load_level(0)
	print ("Level to load: ", scene_path)
