extends Panel

@export var default_color : Color
@export var hurt_color : Color
@export var heal_color : Color

@export var health_label : Label
var is_health_being_updated : bool

func _ready():
	# Subscribe to the on_health_changed signal so that we can make the UI keep track of the player's health
	SignalController.on_health_changed.connect(on_health_changed)
	
	# Subscribe to the on_stop_health_change signal in order to turn the color of the health text back to normal 
	SignalController.on_stop_health_change.connect(on_stop_health_change)

func on_health_changed(prev_health : int, new_health : int) -> void:
	health_label.add_theme_font_size_override("font_size", 35)
	is_health_being_updated = true
	health_label.text = str(int(new_health))
	
	if prev_health > new_health:
		health_label.add_theme_color_override("font_color", hurt_color)
	elif prev_health < new_health:
		health_label.add_theme_color_override("font_color", heal_color)

func on_stop_health_change() -> void:
	if is_health_being_updated:
		health_label.add_theme_font_size_override("font_size", 30)
		health_label.add_theme_color_override("font_color", default_color)
		is_health_being_updated = false
