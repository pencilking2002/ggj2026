extends CanvasLayer

@export var level : int
@export var fade_in_duration := 1.0
@export var target_alpha := 0.33

func _ready() -> void:
	fade_in()

func fade_in():
	var tween = create_tween()
	tween.tween_property($ColorRect, 'modulate', Color(0,0,0,target_alpha), fade_in_duration).set_trans(Tween.TRANS_SINE)

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			start_level()
	elif event is InputEventMouseButton:
		if event.pressed:
			start_level()



func start_level() -> void:
	SoundManager.play_sound_geiger_single()
	if level == 1 : 
		get_tree().change_scene_to_file("res://_scenes/main.tscn")
	if level == 2 : 
		get_tree().change_scene_to_file("res://_scenes/main.tscn")
	if level == 3 : 
		get_tree().change_scene_to_file("res://_scenes/main.tscn")
	if level == 4 : 
		get_tree().change_scene_to_file("res://_scenes/main.tscn")
	if level == 5 : 
		get_tree().change_scene_to_file("res://_scenes/main.tscn")
