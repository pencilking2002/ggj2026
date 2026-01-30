extends CanvasLayer
class_name MaskCanvasLayer

@export var is_mask_enabled : bool = true
@export var color_rect: ColorRect
@export var timer: Timer
@export var eye_radius_reduce_rate := 8.0
@export var eye_falloff_reduce_rate := 2.0
@export var fade_in_eye_radius_duration := 1.0
@export var breath_audio_fade_in_duration := 10.0

static var eye_radius_str: String = "eye_radius"
static var eye_falloff_str: String = "eye_falloff"

var color_rect_mat: Material

func _ready() -> void:

	if not is_mask_enabled:
		visible = false
	else:
		# Cache the color rect's material
		color_rect_mat = color_rect.material
		
		# Animate the eye radius
		fade_in_eye_radius(fade_in_eye_radius_duration)
		
		# Animate the volume of the gas mask breathing
		SoundManager.play_sound_mask_with_ramp_up(breath_audio_fade_in_duration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# reduce_eye_radius(delta)
	pass

func fade_in_eye_radius(duration: float) -> void:
	var tween: Tween = create_tween()
	tween.tween_method(set_eye_radius, 0.0, 0.12, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func set_eye_radius(value: float) -> void:
	color_rect_mat.set_shader_parameter(eye_radius_str, value)
	
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
