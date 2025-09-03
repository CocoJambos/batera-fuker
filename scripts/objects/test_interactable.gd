extends Node3D
class_name TestInteractable

@export var interactable : Interactable = null

func _ready() -> void:
	assert(interactable != null, "Interactable must be filled!")
	interactable.is_interactable = is_interactable
	interactable.interact = interact
	
func is_interactable(interaction_ability: InteractionAbility) -> bool:
	return true
	
func interact() -> void:
	print("Test interaction interacted")
