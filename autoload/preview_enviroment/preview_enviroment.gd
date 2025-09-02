extends Node3D

@export var _preview_camera: Camera3D;

var _camera_to_restore: Camera3D;

func _ready() -> void:
	_preview_camera.set_process(false);
	set_enabled(true);

func remove() -> void:
		get_tree().root.remove_child.call_deferred(PreviewEnviroment);
		PreviewEnviroment.queue_free();
		
func set_enabled(enabled: bool) -> void:
	visible = enabled;
	
func use_preview_camera(camera_to_restore: Camera3D) -> void:
		_camera_to_restore = camera_to_restore;
		
		_preview_camera.make_current();
		_preview_camera.set_process(true);
		
func restore_camera() -> void:
	if _camera_to_restore == null:
		_camera_to_restore.make_current();
	
	_preview_camera.set_process(false);
