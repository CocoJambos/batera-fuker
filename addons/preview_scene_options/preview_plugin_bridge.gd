extends Node

const PREFIX: String = "preview_plugin_debugger";

var scene_instance: Node;

func _ready() -> void:
	EngineDebugger.register_message_capture(PREFIX, _on_debugger_message);
	EngineDebugger.send_message.call_deferred("%s:ready" % PREFIX, []);
	
func _exit_tree() -> void:
	if scene_instance == null:
		return;
		
	remove_child(scene_instance);
	scene_instance.queue_free();
	
func _on_debugger_message(message: String, data: Array) -> bool:
	match message:
		"spawn_preview":
			var scene_path: String = data[0] as String;
			if scene_path.is_empty():
				return true;
				
			scene_instance = (load(scene_path) as PackedScene).instantiate();
			add_child(scene_instance);
			
	return false;
