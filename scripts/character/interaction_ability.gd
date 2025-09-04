extends Node3D
class_name InteractionAbility

@export var interaction_action_name: String = "interaction_main"
@export var current_interaction : CurrentInteraction = null
@export var detectionArea : Area3D = null

var _available_interactions : Array[Interactable] = []
var can_interact : bool                           = true
var _selected_interactable : Interactable         = null

signal interaction_found(interactable: Interactable)
signal interaction_lost(interactable: Interactable)

func _ready() -> void:
	assert(current_interaction != null, "Missing current interaction resource!")
	assert(detectionArea != null, "Missing detection area!")
	
	detectionArea.area_entered.connect(_on_interaction_range_area_entered)
	detectionArea.area_exited.connect(_on_interaction_range_area_exited)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(interaction_action_name) and can_interact:
		can_interact = false
		await _available_interactions[0].interact.call()
		can_interact = true

func _process(delta: float) -> void:
	if _available_interactions and can_interact:
		_available_interactions.sort_custom(sort_by_nearest)
		_set_selected_interactable(_available_interactions[0])
		
	else:
		current_interaction.interactable = null

func sort_by_nearest(a: Interactable, b: Interactable) -> bool:
	var aPos : float = global_position.distance_to(a.global_position)
	var bPos : float = global_position.distance_to(b.global_position)
	return aPos < bPos

func _on_interaction_range_area_entered(area: Area3D) -> void:
	if area is not Interactable:
		pass

	_available_interactions.push_back(area)
	interaction_found.emit(area)

func _on_interaction_range_area_exited(area: Area3D) -> void:
	if area is not Interactable:
		pass
	
	_available_interactions.erase(area)
	interaction_lost.emit(area)
	
func _set_selected_interactable(interactable: Interactable) -> void:
	if _selected_interactable == null:
		_selected_interactable = interactable
		current_interaction.interactable = interactable
		
		if _selected_interactable != null:
			_selected_interactable.on_interaction_select()	
			
	elif _selected_interactable != interactable: 
		_selected_interactable.on_interaction_deselect()
		_selected_interactable = interactable
		current_interaction.interactable = interactable

		if _selected_interactable != null:
			_selected_interactable.on_interaction_select()	
			
			
