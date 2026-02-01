extends CanvasLayer
class_name MaskCanvasLayer

@export var color_rect: ColorRect
@export var tutorial_text : Label
@export var level_text : Label
@export var num_worms_text : Label 
@export var is_mask_enabled : bool = true
@export var eye_radius_reduce_rate := 8.0
@export var eye_falloff_reduce_rate := 2.0
@export var fade_in_eye_radius_duration := 1.0
@export var breath_audio_fade_in_duration := 10.0

static var eye_radius_str: String = "eye_radius"
static var eye_falloff_str: String = "eye_falloff"

var color_rect_mat: Material
var total_worms : int
var worms_collected : int

func _ready() -> void:
	worms_collected = 0
	var worms := get_tree().get_nodes_in_group("worms")
	total_worms = worms.size()
	update_num_worms_text(0, total_worms)
	level_text.text = str("LEVEL 0", GameManager.curr_level_index+1)
	SignalController.on_player_first_move.connect(player_first_move)
	SignalController.on_pickup_worm.connect(pickup_worm)
	SignalController.on_pickup_health_item.connect(pickup_health_item)
	
	if GameManager.curr_level_index == 3:
		num_worms_text.text = "0 OF 1 HEALING KITS FOUND"
		
	#SoundManager.play_level_music()
	if not is_mask_enabled:
		visible = false
	else:
		# Cache the color rect's material
		color_rect_mat = color_rect.material
		
		# Animate the eye radius
		fade_in_eye_radius(fade_in_eye_radius_duration)
		
		# Animate the volume of the gas mask breathing
		SoundManager.play_sound_mask_with_ramp_up(breath_audio_fade_in_duration)
		
		# Start tutorial text
		var data : TutorialData = GameManager.get_tutorial_data_for_curr_level()
		if data:
			tutorial_text.text = data.data[0]

func pickup_health_item() -> void:
	if GameManager.curr_level_index == 3:
		num_worms_text.text = "1 OF 1 HEALING KITS FOUND"
		
func pickup_worm() -> void:
	worms_collected += 1
	update_num_worms_text(worms_collected, total_worms)
	
func player_first_move() -> void:
#	await get_tree().create_timer(5.0).timeout
#	var tween : Tween = create_tween()
#	tween.tween_property(tutorial_text, "modulate:a", 0.0, 2.0)
#	await get_tree().create_timer(2.0).timeout
#	tutorial_text.text = ""
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# reduce_eye_radius(delta)
	pass

func fade_in_eye_radius(duration: float) -> void:
	var tween: Tween = create_tween()
	tween.tween_method(set_eye_radius, 0.0, 0.12, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func set_eye_radius(value: float) -> void:
	color_rect_mat.set_shader_parameter(eye_radius_str, value)

func update_num_worms_text(num_left : int, total_worms : int) -> void:
	num_worms_text.text = str(num_left) + " OF " + str(total_worms) + " WORMS FOUND"
		
# Continually reduces the eye radius
#func reduce_eye_radius(delta: float) -> void:
#	var curr_radius: float = color_rect_mat.get_shader_parameter(eye_radius_str)
#	var curr_falloff: float = color_rect_mat.get_shader_parameter(eye_falloff_str)
#	
#	var new_radius := curr_radius - eye_radius_reduce_rate * delta / 100
#	color_rect_mat.set_shader_parameter(eye_radius_str, new_radius)
#	
#	var new_falloff := curr_falloff + eye_falloff_reduce_rate * delta / 100
#	color_rect_mat.set_shader_parameter(eye_falloff_str, new_falloff)
