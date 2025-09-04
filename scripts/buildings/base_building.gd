extends Node3D;
class_name BaseBuilding;

@export var _placement: BuildingPlacement;

func _override_position(global_contact_point: Vector3) -> void:
	_placement._process_contact_point(global_contact_point);
