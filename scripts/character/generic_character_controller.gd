extends CharacterBody3D
class_name GenericCharacterController

@export var SPEED: float = 5.0
@export var animation_controller: AnimationPlayer
@export var visuals: Node3D
@export var direction_provider: DirectionProvider

@export var walk_animation_name: String = "walk"
@export var idle_animation_name: String = "idle"

var walking: bool = false


func _ready() -> void:
	assert(animation_controller != null, "Character controller needs an animator!")
	assert(direction_provider != null, "Character controller needs a direction provider!")
	assert(visuals != null, "Character controller needs visuals!")
	
	animation_controller.set_blend_time(walk_animation_name, idle_animation_name, 0.2)
	animation_controller.set_blend_time(idle_animation_name, walk_animation_name, 0.2)
	animation_controller.play(idle_animation_name)

func _physics_process(delta: float) -> void:
	var input_dir := direction_provider.get_direction()
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		visuals.look_at(direction + position)

		if !walking:
			walking = true
			animation_controller.play(walk_animation_name)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

		if walking:
			walking = false
			animation_controller.play(idle_animation_name)

	move_and_slide()
