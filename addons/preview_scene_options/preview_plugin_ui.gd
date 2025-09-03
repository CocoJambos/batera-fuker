@tool
extends Control
class_name PreviewScenePluginUI;

@export var _check_button: CheckButton;

var _ignore_toggle_event: bool = true;

var spawn_preview_scene: bool:
	get:
		return _check_button.toggle_mode;

func _ready() -> void:
	theme = EditorInterface.get_editor_theme();
	_check_button.toggled.connect(__on_toggled);
	
func override_toggle_value(new_value: bool) -> void:
	_check_button.set_pressed_no_signal(new_value);
	
func __on_toggled(is_toogled: bool) -> void:
	EditorInterface.get_editor_settings().set_setting("preview_scene/is_enabled", is_toogled)
