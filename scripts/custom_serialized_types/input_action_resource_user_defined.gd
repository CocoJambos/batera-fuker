@tool
extends AbstractActionResource;
class_name InputActionResourceUserDefined;

func _get_property_list() -> Array[Dictionary]:
	var actions: Array[String] = []
	
	var property_list: Array[Dictionary] = ProjectSettings.get_property_list();
	var input_property_list: Array = property_list.filter(
		func(dict: Dictionary): 
		var test_name: String = dict.get("name", "");
		return test_name.begins_with("input/"));
	
	for property: Dictionary in input_property_list:
		var property_name: String = property.get("name", "");
		property_name = property_name.replace("input/", '');
		
		if property_name.contains("ui"):
			continue;
		
		actions.append(property_name);
	
	var actions_as_string: String = ','.join(actions);
	
	return [{
		"name": "action_reference",
		"type": TYPE_STRING_NAME,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": actions_as_string,
	}]
