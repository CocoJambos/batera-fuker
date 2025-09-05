extends Node
class_name BuildEffect;

signal done;

func _process_effect() -> void:
	pass;

func _is_async() -> bool:
	return false;

func _process_effect_async() -> BuildEffect:
	return self;
