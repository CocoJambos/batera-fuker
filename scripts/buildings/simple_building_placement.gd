extends BuildingPlacement;
class_name SimpleBuildingPlacement;

@export var _pivot: Marker3D;
@export var _height_edge: Marker3D;
@export var _lerp_time: float;
@export var _cast_shape: Shape3D;
@export_flags_3d_physics var _collision_mask: int;

var _target_position: Vector3;
var _last_target_position: Vector3;
var _current_timer: float = 0;

func _process(delta: float) -> void:
	_current_timer += delta;
	var normalized_timer = _current_timer / _lerp_time;
	normalized_timer = clamp(normalized_timer, 0, 1);
	var new_position = lerp(_last_target_position, _target_position, normalized_timer);
	_building_root.global_position = new_position;
	
func _physics_process(delta: float) -> void:
	var physics_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state;
	var cast_query: PhysicsShapeQueryParameters3D = PhysicsShapeQueryParameters3D.new();
	cast_query.collide_with_areas = true;
	cast_query.collide_with_bodies = true;
	cast_query.shape = _cast_shape;
	cast_query.collision_mask = _collision_mask;
	var cast_transform: Transform3D = Transform3D(_building_root.transform);
	cast_transform.origin = _target_position;
	cast_query.transform = cast_transform;
	
	var results: Array[Dictionary] = physics_state.intersect_shape(cast_query);
	var is_valid_placement: bool = results.is_empty();
	
	_is_valid_placement = is_valid_placement;
	valid_placement.emit(_is_valid_placement);

func _process_contact_point(global_contact_point: Vector3) -> void:
	var offset: Vector3 = _height_edge.global_position - _pivot.global_position;
	_current_timer = 0.0;
	
	if _target_position == Vector3.ZERO:
		_building_root.global_position = global_contact_point - offset;
		_target_position = global_contact_point - offset;
		return;
	
	_target_position = global_contact_point - offset;
	_last_target_position = _building_root.global_position;
	return;
