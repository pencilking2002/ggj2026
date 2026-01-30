extends Area2D
class_name EyeCollisionReporter

signal on_item_spotted
signal on_item_exited

func _ready() -> void:
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)
	
func on_area_entered(other: Area2D) -> void:
	# print("area entered: ", other.get_parent().name)
	var item : Node2D = other.get_parent()
	on_item_spotted.emit(item)

func on_area_exited(other: Area2D) -> void:
	var item : Node2D = other.get_parent()
	on_item_exited.emit(item)
