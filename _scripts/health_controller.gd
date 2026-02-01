extends Node2D
class_name HealthController

@export var hurt_speed : float = 4.0
@export var max_health : float = 500.0
var health : float

func _ready():
	set_health(max_health)

func decrement_health(delta : float):
	var prev_health : float = health
	health -= delta * hurt_speed
	health = clamp(health,0, max_health)
	SignalController.on_health_changed.emit(prev_health, health)
	print("prev health : ", prev_health)
	print("new health : ", health)
	
	if health == 0.0:
		SignalController.on_game_over.emit()

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