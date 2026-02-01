extends Panel

@export var health_label : Label
var is_health_being_updated : bool

func _ready():
	# Subscribe to the on_health_changed signal so that we can make the UI keep track of the player's health
	SignalController.on_health_changed.connect(on_health_changed)
	
	# Subscribe to the on_stop_health_change signal in order to turn the color of the health text back to normal 
	SignalController.on_stop_health_change.connect(on_stop_health_change)

func on_health_changed(amount : int):
	is_health_being_updated = true
	var prev_health : int = int(health_label.text)
	health_label.text = str(amount)
	
	if amount < prev_health:
		health_label.add_theme_color_override("font_color", Color.RED)
	elif amount > prev_health:
		health_label.add_theme_color_override("font_color", Color.GREEN)

func on_stop_health_change():
	if is_health_being_updated:
		health_label.add_theme_color_override("font_color", Color.GRAY)
		is_health_being_updated = false