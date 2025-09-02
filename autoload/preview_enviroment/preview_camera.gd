extends Camera3D
class_name PreviewCamera;

@export var translate_speed: float;
@export var rotate_speed: float;
@export_category("Input Mappings")
@export var forward_key: Key;
@export var backward_key: Key;
@export var left_key: Key;
@export var right_key: Key;
@export var lift_key: Key;
@export var fall_key: Key;

var translate_input: Vector2 = Vector2.ZERO;
var rotate_input: Vector2 = Vector2.ZERO;
var lift_input: float;

var _is_forward_pressed: bool;
var _is_backward_pressed: bool;
var _is_left_pressed: bool;
var _is_right_pressed: bool;
var _is_lift_pressed: bool;
var _is_fall_pressed: bool;

func _process(delta: float) -> void:
	var forward: int = -1 if _is_forward_pressed else 0;
	var backward: int = 1 if _is_backward_pressed else 0;
	var left: int = -1 if _is_left_pressed else 0;
	var right: int = 1 if _is_right_pressed else 0;
	var lift: int = 1 if _is_lift_pressed else 0;
	var fall: int = -1 if _is_fall_pressed else 0;
	
	translate_input = Vector2(float(left + right), float(forward + backward));
	lift_input = float(lift + fall);
	var translate_direction = global_basis * Vector3(translate_input.x, lift_input, translate_input.y);
	position += translate_direction * translate_speed * delta;
	rotate(Vector3.UP, rotate_input.x * rotate_speed * delta);
	rotate_object_local(Vector3.RIGHT, rotate_input.y * rotate_speed * delta);
	
	rotate_input = Vector2.ZERO;

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var mouse_motion = event as InputEventMouseMotion;
		rotate_input = mouse_motion.relative;
		
	if event is InputEventKey:
		match event.keycode:
			forward_key:
				_is_forward_pressed = event.is_pressed();
			backward_key:
				_is_backward_pressed = event.is_pressed();
			left_key:
				_is_left_pressed = event.is_pressed();
			right_key:
				_is_right_pressed = event.is_pressed();
			lift_key:
				_is_lift_pressed = event.is_pressed();
			fall_key:
				_is_fall_pressed = event.is_pressed();

func set_as_current_camera() -> void:
	make_current();
