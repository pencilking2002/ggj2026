extends Node2D
class_name SpottableItem


@export var sprite : Sprite2D

var is_toxic : bool

var sprite_mat : ShaderMaterial
static var blink_strength_str : StringName = &"blink_strength"

# Called when the node enters the scene tree for the first time.
func init() -> void:
	if sprite:
		sprite_mat = sprite.material
		print ("Set sprite mat ", name)
	else:
		print("Pickup: Sprite is not defined")

func highlight(is_highlighted : bool):
	if sprite_mat:
		var value : float = 1.0 if is_highlighted else 0.0
		sprite_mat.set_shader_parameter(blink_strength_str, value)
	else:
		print(name, "'s sprite mat isn't set")
	
func can_be_collected() -> bool:
	return true
	
func collect():
	queue_free()
