extends Resource
class_name CurrentInteraction

signal interaction_changed(interactable: Interactable)

var _interactable : Interactable = null
var _previousInteractable : Interactable = null

var interactable : Interactable: 
	get:
		return _interactable
	set(value):
		if value != _previousInteractable:
			_previousInteractable = _interactable
			_interactable = value
			interaction_changed.emit(_interactable)