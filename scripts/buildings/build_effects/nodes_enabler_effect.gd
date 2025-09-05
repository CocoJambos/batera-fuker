extends BuildEffect;
class_name NodesEnablerrEffect;

@export var _nodes_to_disable: Array[Node];
@export var _enable: bool;

func _process_effect() -> void:
	for node in _nodes_to_disable:
		node.set_process(_enable);
		node.set_physics_process(_enable);
		node.set_process_input(_enable);
		node.set_process_shortcut_input(_enable);
		node.set_process_unhandled_input(_enable);
		node.set_process_unhandled_key_input(_enable);
	
		if node is Node3D:
			(node as Node3D).visible = _enable;
		
		# wiem, ze gownianie to wyglada ale cusz zrobisz
		if node is CollisionShape3D:
			(node as CollisionShape3D).disabled = !_enable;
