extends Node
class_name DirectionProvider

func get_direction() -> Vector2:
	push_error("get_direction must be implemented by a subclass")
	return Vector2.ZERO