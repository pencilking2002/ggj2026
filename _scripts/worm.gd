class_name Worm extends SpottableItem

@export var animator: AnimationPlayer
@export var worm_settings:WormSettings
var idle_duration : float
var last_dive_time: float
var last_emerge_time: float
var time_elapsed: float
var is_spotted: bool
var player : Player

enum WormStateEnum {
	IDLE,
	DIVING,
	EMERGING,
	SUBMERGED,
}

@export var worm_state: WormStateEnum = WormStateEnum.IDLE

func _ready():
	init()
	animator.play("idle")
	cache_player()
	idle_duration = worm_settings.idle_duration + randf_range(0, worm_settings.idle_duration_variance)
	
func cache_player():
	var nodes : Array[Node] = get_tree().get_nodes_in_group("player")
	if nodes.size() > 0:
		player = nodes[0]
	else:
		print("unable to located player")
	
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
		sprite.show()
		animator.play("idle")
		position = get_random_point()
	elif worm_state == WormStateEnum.EMERGING && time_elapsed > last_emerge_time + worm_settings.emerge_duration:
		set_state(WormStateEnum.IDLE)
		last_emerge_time = time_elapsed
		sprite.show()
		animator.play("idle")
	elif worm_state == WormStateEnum.IDLE and time_elapsed > last_emerge_time + idle_duration:
		set_state(WormStateEnum.DIVING)
		last_dive_time = time_elapsed
		animator.play("dive")
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
		
func can_be_collected() -> bool:
	return worm_state == WormStateEnum.IDLE
	
#func _draw():
#	var start_point : Vector2 = position
#	var end_point : Vector2 = player.position
#	var line_color = Color.WHITE
#	var line_thickness = 3
#	
#	draw_line(start_point, end_point, line_color, line_thickness)
