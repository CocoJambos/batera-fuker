extends PlacementCheckConsumer;
class_name MaterialBasedCheck;

@export var _target_mesh: GeometryInstance3D;
@export var _good_material: Material;
@export var _bad_material: Material;

func _good_placement() -> void:
	_target_mesh.material_override = _good_material;

func _bad_placement() -> void:
	_target_mesh.material_override = _bad_material;
