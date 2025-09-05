@tool
extends Resource
class_name AbstractActionResource;

var action_reference: StringName;

func _get_property_list() -> Array[Dictionary]:
	return [];

func _get(property: StringName) -> Variant:
	match property:
		"action_reference":
			return action_reference;
			
	return null;
	
func _set(property: StringName, value: Variant) -> bool:
	match property:
		"action_reference":
			action_reference = value;
			return true;
			
	return false;
