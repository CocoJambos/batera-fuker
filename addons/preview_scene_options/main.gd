@tool
extends EditorPlugin

var ui_path = preload("res://addons/preview_scene_options/plugin_ui.tscn");
var debugger_path = preload("res://addons/preview_scene_options/preview_plugin_debugger.gd");

var ui: PreviewScenePluginUI;
var debugger: EditorDebuggerPlugin;

func _enter_tree() -> void:
	var editor_settings: EditorSettings = EditorInterface.get_editor_settings();
	
	if !editor_settings.has_setting("preview_scene/is_enabled"):
		editor_settings.set_setting("preview_scene/is_enabled", false);
	
	var preview_scene_enabled: bool = editor_settings.get_setting("preview_scene/is_enabled");
	
	ui = ui_path.instantiate() as PreviewScenePluginUI;
	add_control_to_container(CONTAINER_SPATIAL_EDITOR_MENU, ui);
	ui.override_toggle_value(preview_scene_enabled);
	
	add_autoload_singleton("preview_scene_bridge", "res://addons/preview_scene_options/preview_plugin_bridge.gd");
	debugger = debugger_path.new();
	add_debugger_plugin(debugger);
	
func _exit_tree() -> void:
	remove_autoload_singleton("preview_scene_bridge");
	remove_control_from_container(CONTAINER_SPATIAL_EDITOR_MENU, ui);
	remove_debugger_plugin(debugger);
	ui.queue_free();
	
		
