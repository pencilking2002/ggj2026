extends CanvasLayer
class_name MaskCanvasLayer

@export var color_rect: ColorRect
@export var timer: Timer
@export var eye_radius_reduce_rate := 8.0
@export var eye_falloff_reduce_rate := 2.0

static var eye_radius_str: String = "eye_radius"
static var eye_falloff_str: String = "eye_falloff"

var color_rect_mat: Material

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect_mat = color_rect.material
	SoundManager.play_sound_mask()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# reduce_eye_radius(delta)
	pass

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
