extends InteractionController
class_name TestInteractable

func on_interaction_start() -> void:
	print("Test interaction interacted")
	
	
func on_interaction_end() -> void:
	pass
	
	
func on_interaction_process() -> void:
	pass
	
	
func is_interactable() -> bool:
	return true
