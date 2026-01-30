extends CharacterBody2D
class_name Player

@export var move_speed := 100.0
@export var move_lerp_speed := 5.0
@export var left_eye : EyeCollisionReporter
@export var right_eye : EyeCollisionReporter

var curr_pickup : Node2D

func _ready() -> void:
	left_eye.on_item_spotted.connect(item_spotted)
	right_eye.on_item_spotted.connect(item_spotted)
	left_eye.on_item_exited.connect(item_exited)
	right_eye.on_item_exited.connect(item_exited)
	
func _physics_process(delta: float) -> void:
	# Get movement direction from player input
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Get a target velicty based on direction and move_speed
	var target_velocity := direction * move_speed * delta * 1000.0
	
	# Lerp the velocity for a smooth movement acceleration and decceleration
	velocity = lerp(velocity, target_velocity, delta * move_lerp_speed)
	move_and_slide()

func item_spotted(item : SpottableItem) -> void:
	item.highlight(true)

func item_exited(item : SpottableItem) -> void:
	item.highlight(false)