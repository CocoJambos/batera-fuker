extends Node3D;
class_name PreviewEnviroment;

@export var _preview_camera: Camera3D;
@export var _game_state: GameState;

var _camera_to_restore: Camera3D;

func _ready() -> void:
	set_enabled(true);
	use_preview_camera();
	_game_state.with_current_camera(_preview_camera);
	await get_tree().create_timer(0.1).timeout;
	_game_state.build();
			
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
