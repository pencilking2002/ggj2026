extends Control

var can_click : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_gameover_music()
	await get_tree().create_timer(1.0).timeout
	can_click = true
	
func _input(event):
	if not can_click:
		return
		
	if event is InputEventKey:
		if event.pressed:
			start_game()
	elif event is InputEventMouseButton:
		if event.pressed:
			start_game()

func start_game() -> void:
	SoundManager.play_sound_geiger_single()
	SoundManager.stop_gameover_music()
	GameManager.load_last_level()
