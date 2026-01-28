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

	if worm_state == WormStateEnum.SUBMERGED && Time.get_ticks_msec() > last_dive_time + worm_settings.submerged_duration:
		set_state(WormStateEnum.EMERGING)
		last_emerge_time = Time.get_ticks_msec()
	elif worm_state == WormStateEnum.IDLE and Time.get_ticks_msec() > last_emerge_time + worm_settings.idle_duration:
		set_state(WormStateEnum.DIVING)
		last_dive_time = Time.get_ticks_msec()
	elif worm_state == WormStateEnum.DIVING && Time.get_ticks_msec() > last_dive_time + worm_settings.dive_duration:
		set_state(WormStateEnum.SUBMERGED)
		last_dive_time = Time.get_ticks_msec()
	elif worm_state == WormStateEnum.EMERGING && Time.get_ticks_msec() > last_emerge_time + worm_settings.emerge_duration:
		set_state(WormStateEnum.IDLE)
		last_emerge_time = Time.get_ticks_msec()
