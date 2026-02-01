class_name RadiatedBarrel extends SpottableItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()
	is_toxic = true

func collect():
	print("Collect barrel")
