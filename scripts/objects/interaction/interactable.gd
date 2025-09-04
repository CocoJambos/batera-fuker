extends Area3D
class_name Interactable

@export var interactions : Array[InteractionController] = []

signal on_select()
signal on_deselect()

var interact: Callable = func ():
	pass

var is_interactable: Callable = func(interaction_ability: InteractionAbility) -> bool:
	return false

func on_interaction_select() -> void:
	on_select.emit()
	
	
func on_interaction_deselect() -> void:
	on_deselect.emit()