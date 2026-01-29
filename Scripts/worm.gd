extends Node2D
class_name Worm

@export var sprite: Sprite2D
@export var worm_settings:WormSettings

var last_dive_time: float
var last_emerge_time: float
var time_elapsed: float

enum WormStateEnum {
	IDLE,
	DIVING,
	EMERGING,
	SUBMERGED,
}

@export var worm_state: WormStateEnum = WormStateEnum.IDLE

func _ready():
	pass
	
func set_state(input_state: WormStateEnum):
	worm_state = input_state
	
func _process(delta: float):
	time_elapsed += delta
	update_worm_state()

# Manage the worm's looping behavir of emerging and submerging
func update_worm_state() -> void:
	if worm_state == WormStateEnum.SUBMERGED && time_elapsed > last_dive_time + worm_settings.submerged_duration:
		set_state(WormStateEnum.EMERGING)
		last_emerge_time = time_elapsed
	elif worm_state == WormStateEnum.EMERGING && time_elapsed > last_emerge_time + worm_settings.emerge_duration:
		set_state(WormStateEnum.IDLE)
		last_emerge_time = time_elapsed
	elif worm_state == WormStateEnum.IDLE and time_elapsed > last_emerge_time + worm_settings.idle_duration:
		set_state(WormStateEnum.DIVING)
		last_dive_time = time_elapsed
	elif worm_state == WormStateEnum.DIVING && time_elapsed > last_dive_time + worm_settings.dive_duration:
		set_state(WormStateEnum.SUBMERGED)
		last_dive_time = time_elapsed
	
