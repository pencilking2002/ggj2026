extends Control
@export var audio_fade_in_duration := 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_menu_music(audio_fade_in_duration)
	


func _on_button_pressed() -> void:
	SoundManager.play_sound_geiger_single()
	SoundManager.stop_menu_music()
	get_tree().change_scene_to_file("res://_scenes/main.tscn")
