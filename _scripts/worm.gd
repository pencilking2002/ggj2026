class_name Worm extends SpottableItem

@export var worm_settings:WormSettings
@export var is_idle_state_only : bool
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
	CAUGHT
}

@export var worm_state: WormStateEnum = WormStateEnum.IDLE

func _ready():
	init()
	#animator.play("idle")
	anim_sprite.play("idle")
	idle_duration = worm_settings.idle_duration + randf_range(0, worm_settings.idle_duration_variance)
	
func set_state(input_state: WormStateEnum) -> void:
	worm_state = input_state

func get_state() -> WormStateEnum:
	return worm_state
	
func _process(delta: float):
	if is_idle_state_only:
		return
		
	time_elapsed += delta
	update_worm_state()
	
# Manage the worm's looping behavir of emerging and submerging
func update_worm_state() -> void:
	if worm_state == WormStateEnum.CAUGHT:
		return
	elif worm_state == WormStateEnum.SUBMERGED && time_elapsed > last_dive_time + worm_settings.submerged_duration:
		set_state(WormStateEnum.EMERGING)
		last_emerge_time = time_elapsed
		show_sprite()
		anim_sprite.play("emerge")
		position = get_random_point()
	elif worm_state == WormStateEnum.EMERGING && time_elapsed > last_emerge_time + worm_settings.emerge_duration:
		set_state(WormStateEnum.IDLE)
		last_emerge_time = time_elapsed
		show_sprite()
		anim_sprite.play("idle")
	elif worm_state == WormStateEnum.IDLE and time_elapsed > last_emerge_time + idle_duration:
		set_state(WormStateEnum.DIVING)
		last_dive_time = time_elapsed
		anim_sprite.play("dive")
	elif worm_state == WormStateEnum.DIVING && time_elapsed > last_dive_time + worm_settings.dive_duration:
		set_state(WormStateEnum.SUBMERGED)
		last_dive_time = time_elapsed
		hide_sprite()

func show_sprite() -> void:
	if sprite:
		sprite.show()
	elif anim_sprite:
		anim_sprite.show()

func hide_sprite() -> void:
	if sprite:
		sprite.hide()
	elif anim_sprite:
		anim_sprite.hide()
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

func collect():
	set_state(WormStateEnum.CAUGHT)
	SignalController.on_check_win_condition.emit()
	SoundManager.play_sound_worm_scream()
	anim_sprite.play("capture")
	await get_tree().create_timer(0.5).timeout
	super()
	
#func _draw():
#	var start_point : Vector2 = position
#	var end_point : Vector2 = GameManager.get_player().position
#	var line_color = Color.WHITE
#	var line_thickness = 3
#	
#	draw_line(start_point, end_point, line_color, line_thickness)
