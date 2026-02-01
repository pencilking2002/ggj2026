extends Node2D
class_name HealthController

@export var hurt_speed : float = 4.0
@export var reduce_health_speed : float = 4.0
@export var max_health : float = 500.0
var health : float
var delta_time : float

func _ready():
	# Set the player's health at the start of the game
	set_health(max_health)
	SignalController.on_pickup_toxic_item.connect(pickup_toxic_item)
	SignalController.on_pickup_health_item.connect(pickup_health_item)

func decrement_health():
	var prev_health : float = health
	health -= get_process_delta_time() * hurt_speed
	health = clamp(health,0, max_health)
	SignalController.on_health_changed.emit(prev_health, health)
	
	# Play gieger click every time 1.0 health is removed
	if fmod(health, 1.0) < 0.01:
		SoundManager.play_sound_geiger_single(0.2)	
	
	if health == 0.0:
		do_gameover()

func continously_reduce_health():
	var prev_health : float = health
	health -= get_process_delta_time() * reduce_health_speed
	health = clamp(health,0, max_health)
	SignalController.on_health_changed.emit(prev_health, health)
	
	if health == 0.0:
		do_gameover()
		
func do_gameover():
	SoundManager.stop_level_music()
	get_tree().change_scene_to_file("res://_scenes/lose_menu.tscn")

func pickup_toxic_item():
	set_health(health-20)

func pickup_health_item():
	set_health(health+20)
	
#func increment_health():
#	var prev_health : int = health
#	health += 1
#	health = clamp(health,0, max_health)
#	SignalController.on_health_changed.emit(prev_health, health)
#	
#func decrease_health(amount : int):
#	var prev_health : int = health
#	health -= amount
#	health = clamp(health,0, max_health)
#	SignalController.on_health_changed.emit(prev_health, health)
#	
#	if health == 0:
#		SignalController.on_game_over.emit()
#	
#func increase_health(amount : int):
#	var prev_health : int = health
#	health += amount
#	health = clamp(health,0, max_health)
#	SignalController.on_health_changed.emit(prev_health, health)

func set_health(amount: float):
	var prev_health : float = health
	health = amount
	health = clamp(health,0.0, max_health)
	SignalController.on_health_changed.emit(prev_health, health)
	
	if health == 0.0:
		SignalController.on_game_over.emit()

func stop_health_change():
	SignalController.on_stop_health_change.emit()