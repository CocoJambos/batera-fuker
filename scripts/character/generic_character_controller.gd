extends CharacterBody3D

@export var SPEED: float = 5.0

@export var animation_controller: AnimationPlayer
@export var visuals: Node3D

var walking : bool = false

func _ready() -> void:
	animation_controller.set_blend_time("walk", "idle", 0.2)
	animation_controller.set_blend_time("idle", "walk", 0.2)

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("movement_left", "movement_right", "movement_forward", "movement_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		visuals.look_at(direction + position)	
	
		if !walking:
			walking = true
			animation_controller.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
		if walking:
			walking = false
			animation_controller.play("idle")
	
	move_and_slide()
