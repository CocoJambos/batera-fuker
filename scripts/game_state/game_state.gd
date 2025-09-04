extends Resource;
class_name GameState;

signal initialize;

var current_camera: Camera3D;

func with_current_camera(new_current_camera: Camera3D) -> GameState:
	assert(new_current_camera != null);
	current_camera = new_current_camera;
	return self; 
	
func build() -> GameState:
	initialize.emit();
	return self;
