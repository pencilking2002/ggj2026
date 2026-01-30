class_name AidPickup extends SpottableItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()

func can_be_collected() -> bool:
	return true