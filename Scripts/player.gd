extends CharacterBody2D
class_name Player

@export var move_speed := 100.0

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * move_speed * delta * 1000.0

	move_and_slide()
