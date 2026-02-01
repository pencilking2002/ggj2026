extends CanvasLayer

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
	var scene_path : String = GameManager.load_level(0)
	print ("Level to load: ", scene_path)
