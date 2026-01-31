extends Area2D
class_name SpawnArea

@export var circle: CollisionShape2D

func get_random_point() -> Vector2:
	# Use 'TAU' (2 * PI) for a full random angle in radians
	var angle: float = randf_range(0.0, TAU)
	# Get a random distance, weighted so points are uniformly distributed
	var dist: float = sqrt(randf_range(0.0, 1.0)) * circle.shape.radius
	
	var center := circle.position
	
	# Calculate the position using trigonometry (polar to cartesian)
	var point := Vector2(cos(angle), sin(angle)) * dist
	
	# Add the offset from the center
	return center + point
