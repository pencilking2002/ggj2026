extends CharacterBody2D
class_name Player

@export var move_speed := 100.0
@export var move_lerp_speed := 5.0

func _physics_process(delta: float) -> void:
	
	# Get movement direction from player input
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Get a target velicty based on direction and move_speed
	var target_velocity := direction * move_speed * delta * 1000.0
	
	# Lerp the velocity for a smooth movement acceleration and decceleration
	velocity = lerp(velocity, target_velocity, delta * move_lerp_speed)
	move_and_slide()
