extends Node3D
class_name InteractionAbility

@export var interaction_action_name: String = "interaction_main"
@export var label : Label3D = null
var current_interactions : Array[Interactable] = []
var can_interact : bool = true

signal interaction_found(interactable: Interactable)
signal interaction_lost(interactable: Interactable)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(interaction_action_name) and can_interact:
		can_interact = false
		label.hide()
		
		await current_interactions[0].interact.call()
		
		can_interact = true

func _process(delta: float) -> void:
	if current_interactions and can_interact:
		current_interactions.sort_custom(sort_by_nearest)
		if current_interactions[0].is_interactable.call(self):
			label.text = current_interactions[0].interaction_name
			label.show()
	else:
		label.hide()

func sort_by_nearest(a: Interactable, b: Interactable) -> bool:
	var aPos := global_position.distance_to(a.global_position)
	var bPos := global_position.distance_to(b.global_position)
	return aPos < bPos

func _on_interaction_range_area_entered(area: Area3D) -> void:
	current_interactions.push_back(area)
	emit_signal("interaction_found", area)

func _on_interaction_range_area_exited(area: Area3D) -> void:
	current_interactions.erase(area)
	emit_signal("interaction_lost", area)
	
