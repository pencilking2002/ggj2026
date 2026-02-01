extends Node2D
class_name HealthController

@export var max_health : int = 500
var health : int

func _ready():
	set_health(max_health)

func decrement_health():
	health -= 1
	SignalController.on_health_decreased.emit(health)
	SignalController.on_health_changed.emit(health)

func increment_health():
	health += 1
	SignalController.on_health_increased.emit(health)
	SignalController.on_health_changed.emit(health)

func decrease_health(amount : int):
	health -= amount
	SignalController.on_health_decreased.emit(health)
	SignalController.on_health_changed.emit(health)
	
func increase_health(amount : int):
	health += amount
	SignalController.on_health_increased.emit(health)
	SignalController.on_health_changed.emit(health)

func set_health(amount: int):
	health = amount
	SignalController.on_health_changed.emit(health)

func stop_health_change():
	SignalController.on_stop_health_change.emit()