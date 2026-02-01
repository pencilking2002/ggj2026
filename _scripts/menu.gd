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
	var scene_path : String = GameManager.load_level(0)
	print ("Level to load: ", scene_path)
