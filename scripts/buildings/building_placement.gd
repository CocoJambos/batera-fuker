extends Node3D;
class_name BuildingPlacement;

signal valid_placement(is_valid: bool)

@export var _building_root: Node3D;

var _is_valid_placement: bool = false;

var valid_placement_value: bool:
	get:
		return _is_valid_placement;
	set(value):
		return;

func _process_contact_point(global_contact_point: Vector3) -> void:
	return;
