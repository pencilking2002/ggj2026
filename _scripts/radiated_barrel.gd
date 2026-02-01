class_name RadiatedBarrel extends SpottableItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()
	is_toxic = true

func collect():
	SoundManager.play_sound_radiation()
	SignalController.on_pickup_toxic_item.emit()
	print("Collect barrel")
