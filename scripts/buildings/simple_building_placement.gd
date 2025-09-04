extends BuildingPlacement;
class_name SimpleBuildingPlacement;

@export var _pivot: Marker3D;
@export var _height_edge: Marker3D;
@export var _lerp_time: float;
@export var test: InputEvent;

var _target_position: Vector3;
var _last_target_position: Vector3;
var _current_timer: float = 0;

func _process(delta: float) -> void:
	if _target_position != _last_target_position:
		_current_timer = 0;
	
	_current_timer += delta;
	var normalized_timer = _current_timer / _lerp_time;
	#print(normalized_timer)
	normalized_timer = clamp(normalized_timer, 0, 1);
	var new_position = lerp(_building_root.global_position, _target_position, normalized_timer);
	_last_target_position = _target_position;
	_building_root.global_position = new_position;

func _process_contact_point(global_contact_point: Vector3) -> bool:
	#TODO surroudings sphere cast
	var offset: Vector3 = _height_edge.global_position - _pivot.global_position;
	if _target_position == Vector3.ZERO:
		_building_root.global_position = global_contact_point - offset;
		_target_position = global_contact_point - offset;
		return true;
	
	_target_position = global_contact_point - offset;
	return true;
