extends Node2D
class_name Worm

@export var sprite: Sprite2D
@export var worm_settings:WormSettings

var last_dive_time: float
var last_emerge_time: float
var time_elapsed: float
var is_in_sight: bool

enum WormStateEnum {
	IDLE,
	DIVING,
	EMERGING,
	SUBMERGED,
}

@export var worm_state: WormStateEnum = WormStateEnum.IDLE

func _ready():
	get_random_point()
	
func set_state(input_state: WormStateEnum):
	worm_state = input_state
	
func _process(delta: float):
	time_elapsed += delta
	update_worm_state()
	
	if is_in_sight:
		var old_color = sprite.get_modulate()
		sprite.modulate()

# Manage the worm's looping behavir of emerging and submerging
func update_worm_state() -> void:
	if worm_state == WormStateEnum.SUBMERGED && time_elapsed > last_dive_time + worm_settings.submerged_duration:
		set_state(WormStateEnum.EMERGING)
		last_emerge_time = time_elapsed
		sprite.show()
		position = get_random_point()
	elif worm_state == WormStateEnum.EMERGING && time_elapsed > last_emerge_time + worm_settings.emerge_duration:
		set_state(WormStateEnum.IDLE)
		last_emerge_time = time_elapsed
		sprite.show()
	elif worm_state == WormStateEnum.IDLE and time_elapsed > last_emerge_time + worm_settings.idle_duration:
		set_state(WormStateEnum.DIVING)
		last_dive_time = time_elapsed
		sprite.hide()
	elif worm_state == WormStateEnum.DIVING && time_elapsed > last_dive_time + worm_settings.dive_duration:
		set_state(WormStateEnum.SUBMERGED)
		last_dive_time = time_elapsed
		sprite.hide()
	
# Requests a random position from SpwmPointController
func get_random_point() -> Vector2:
	var nodes: Array[Node] = get_tree().get_nodes_in_group("spawn_area")
	
	if nodes.size() != 0:
		var spawn_area := nodes[0]
		var new_spawm_point: Vector2 = spawn_area.get_random_point()
		return new_spawm_point
	else:
		print("Spawn area not found")
		return Vector2.ZERO
		