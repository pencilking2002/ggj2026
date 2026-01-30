extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(on_area_entered)
	# body_entered.connect(on_body_entered)


func on_area_entered(other: Area2D):
	print("area entered: ", other.name)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
