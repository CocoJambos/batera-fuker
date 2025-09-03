extends Resource
class_name CurrentInteraction

signal interaction_changed(interactable: Interactable)

var _current_interactable : Interactable = null
var current_interactable : Interactable: 
	get:
		return _current_interactable
	set(value):
		interaction_changed.emit(value)