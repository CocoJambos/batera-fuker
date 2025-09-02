extends DirectionProvider
class_name PlayerDirectionProvider

@export var movement_left_action_name: String = "movement_left"
@export var movement_right_action_name: String = "movement_right"
@export var movement_forward_action_name: String = "movement_forward"
@export var movement_backward_action_name: String = "movement_backward"

var direction := Vector2.ZERO

func _physics_process(delta: float) -> void:
	direction = Input.get_vector(movement_left_action_name, movement_right_action_name, movement_forward_action_name, movement_backward_action_name)

func get_direction() -> Vector2:
	return direction