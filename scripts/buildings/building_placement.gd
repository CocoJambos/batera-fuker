extends Node3D;
class_name BuildingPlacement;

@export var _building_root: Node3D;

func _process_contact_point(global_contact_point: Vector3) -> bool:
	return false;
