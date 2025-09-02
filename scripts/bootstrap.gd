extends Node

@export var _disable_preview_enviroment: bool = false;

func _enter_tree() -> void:
	if _disable_preview_enviroment:
		PreviewEnviroment.remove();
