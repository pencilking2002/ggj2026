extends CharacterBody2D
class_name Player

@export var move_speed := 100.0
@export var move_lerp_speed := 5.0
@export var left_eye : EyeCollisionReporter
@export var right_eye : EyeCollisionReporter
@export var health_controller : HealthController

var curr_items : Array[SpottableItem]

func _ready() -> void:
	# Connect to signals for spotting items
	SignalController.on_item_spotted.connect(item_spotted)
	SignalController.on_item_exited.connect(item_exited)
	
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
	
func _process(_delta: float):
	if is_looking_at_toxic_item():
		health_controller.decrement_health()
	else:
		health_controller.stop_health_change()
		
# Handle user input for collecting items 
func handle_confirm() -> void:
	if has_items():
		for n in curr_items:
			if n.can_be_collected():
				n.collect()

func is_looking_at_toxic_item() -> bool:
	for item in curr_items:
		if item.is_toxic:
			return true
	return false
	
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
