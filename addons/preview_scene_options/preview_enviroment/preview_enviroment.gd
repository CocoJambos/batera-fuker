extends Node3D;
class_name PreviewEnviroment;

@export var _preview_camera: Camera3D;

var _camera_to_restore: Camera3D;

func _ready() -> void:
	set_enabled(true);
	use_preview_camera();
			
func set_enabled(enabled: bool) -> void:
	visible = enabled;
	
func use_preview_camera(camera_to_restore: Camera3D = null) -> void:
		_camera_to_restore = camera_to_restore;
		
		_preview_camera.make_current();
		_preview_camera.set_process(true);
		
func restore_camera() -> void:
	if _camera_to_restore == null:
		_camera_to_restore.make_current();
	
	_preview_camera.set_process(false);
