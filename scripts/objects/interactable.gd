extends Area3D
class_name Interactable

@export var interaction_name: String = "[E]"

var interact: Callable = func ():
	pass

var is_interactable: Callable = func(interaction_ability: InteractionAbility) -> bool:
	return false
