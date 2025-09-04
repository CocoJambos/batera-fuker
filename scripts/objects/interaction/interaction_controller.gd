extends Node
class_name InteractionController

@export var interaction_name: String = ""


func on_interaction_start() -> void:
	pass
	
	
func on_interaction_end() -> void:
	pass
	
	
func on_interaction_process() -> void:
	pass
	
	
func is_interactable() -> bool:
	push_error("Should be implemented by child class")
	return false