extends BuildEffect;
class_name MaterialResetEffect;

@export var _target_mesh: GeometryInstance3D;

func _process_effect() -> void:
	_target_mesh.material_override = null;
