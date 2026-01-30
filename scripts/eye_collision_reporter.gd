extends Area2D
class_name EyeCollisionReporter

signal on_item_spotted
signal on_item_exited

func _ready() -> void:
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)
	
func on_area_entered(other: Area2D) -> void:
	if other.get_parent() is not SpottableItem:
		print(other.get_parent().name, " is not a SpottableItem")
		return
		
	var item := other.get_parent() as SpottableItem
	on_item_spotted.emit(item)

func on_area_exited(other: Area2D) -> void:
	if other.get_parent() is not SpottableItem:
		print(other.get_parent().name, " is not a SpottableItem")
		return
		
	var item := other.get_parent() as SpottableItem
	on_item_exited.emit(item)
