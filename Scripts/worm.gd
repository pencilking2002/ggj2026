extends Node2D
class_name Worm

@export var sprite: Sprite2D

enum WormStateEnum {
	GOING_IN,
	GOING_OUT,
	IN_GROUND,
	IDLE,
}

@export var worm_state: WormStateEnum = WormStateEnum.IDLE

func _ready():
	set_state(WormStateEnum.IDLE)
	go_into_ground()
	pass
	
func set_state(input_state: WormStateEnum):
	worm_state = input_state
	
	
func go_into_ground():
	set_state(WormStateEnum.IN_GROUND)
	pass



