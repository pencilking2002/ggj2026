extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


func _on_button_pressed() -> void:
	SoundManager.play_sound_geiger_single()
	get_tree().change_scene_to_file("res://_scenes/main.tscn")
