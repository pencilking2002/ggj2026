extends CharacterBody2D
class_name Player

@export var move_speed := 100.0
@export var move_lerp_speed := 5.0
@export var left_eye : EyeCollisionReporter
@export var right_eye : EyeCollisionReporter

var curr_items : Array[SpottableItem]

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
	
	if Input.is_action_just_pressed("confirm"):
		handle_confirm()

func handle_confirm() -> void:
	if has_items():
		for n in curr_items:
			if n.can_be_collected():
				n.collect()
	
func has_items() -> bool:
	return curr_items.size() > 0

func add_item(item: SpottableItem) -> void:
	if not curr_items.has(item):
		curr_items.append(item)
		
func remove_item(item: SpottableItem) -> void:
		if curr_items.has(item):
			curr_items.erase(item)
			
func item_spotted(item : SpottableItem) -> void:
	item.highlight(true)
	add_item(item)

func item_exited(item : SpottableItem) -> void:
	item.highlight(false)
	remove_item(item)
