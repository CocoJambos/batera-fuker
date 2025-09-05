extends Node3D;
class_name BaseBuilding;

@export var _placement: BuildingPlacement;
@export var _placement_check_consumer: PlacementCheckConsumer;		
@export var _build_effects: Array[BuildEffect];

func _ready() -> void:
	_placement.valid_placement.connect(_process_placement);

func _build() -> bool:
	if !_placement.valid_placement_value:
		return false;
	
	for effect: BuildEffect in _build_effects:
		if effect._is_async():
			await effect._process_effect_async().done;
			continue;
		
		effect._process_effect();
	return true;

func _process_placement(valid_placement: bool) -> void:
	if valid_placement:
		_placement_check_consumer._good_placement();
	else:
		_placement_check_consumer._bad_placement();
	
func _override_position(global_contact_point: Vector3) -> void:
	_placement._process_contact_point(global_contact_point);
