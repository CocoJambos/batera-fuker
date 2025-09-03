@tool
extends EditorDebuggerPlugin;

const PREFIX: String = "preview_plugin_debugger";
const PREVIEW_SCENE_PATH: String = "res://addons/preview_scene_options/preview_enviroment/preview_enviroment.tscn";

func _has_capture(capture: String) -> bool:
	return capture == PREFIX;
	
func _capture(message: String, data: Array, session_id: int) -> bool:
	match message:
		"%s:ready" % PREFIX:
			if !EditorInterface.get_editor_settings().get_setting("preview_scene/is_enabled"):
				return true;
			
			get_session(session_id).send_message("%s:spawn_preview" % PREFIX, [PREVIEW_SCENE_PATH]);
			return true;
	return false;
