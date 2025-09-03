extends Node3D;
class_name BuildingPlacer;

@export var _buildings_parent_node: Node3D = null;
@export var _buildings_id_to_scene_map: Dictionary[int, PackedScene];
@export var _buildings_cost: BuildingCost;
@export var _coins_stat: ResourceCoinsStat;
@export var _test_id: int = 0;

var _building_instances: Dictionary[int, BaseBuilding];
var _current_selected_building: BaseBuilding = null;
var _spawned_buildings: Array[BaseBuilding] = [];

func _ready() -> void:
	assert(_coins_stat != null, "Coins stat resource must be provided");
	
	_coins_stat._initialize(); # TODO: initialize coins stat in game manager/world
	__preload_buildings();

# TODO: remove _unhandled... selecting should be preformed via UI
func _unhandled_key_input(event: InputEvent) -> void:
	var key_event: InputEventKey = event as InputEventKey;
	
	if key_event.keycode == KEY_SPACE && key_event.is_pressed():
		select_building(_test_id);

func select_building(building_id: int) -> void:
	assert(_buildings_cost != null, "Building costs resource must be provided");
	assert(_building_instances.has(building_id), "Wrong building ID is provided");
	
	if _current_selected_building != null:
		return;
		
	var coins: int = _coins_stat.current_resource_coins_property;
	var building_cost: int = _buildings_cost.get_cost(_spawned_buildings.size());
	
	if coins < building_cost:
		return;
	
	_current_selected_building = _building_instances[building_id].duplicate();
	
	# TODO center building to mouse pos;
	add_child(_current_selected_building);
	pass;
	
func unselect_building() -> void:
	pass;
	
func place_selected_building() -> void:
	pass;

func __preload_buildings() -> void:
	assert(!_buildings_id_to_scene_map.is_empty(), "Buildings ID map to scenes is empty, should be preset at least one building");
	
	for key: int in _buildings_id_to_scene_map:
		var scene: PackedScene = _buildings_id_to_scene_map[key];
		var building_node: BaseBuilding = __load_scene_building(scene);
		
		assert(building_node != null, "Packed scene to load as building has wrong base type");
		assert(!_building_instances.has(key), "Duplicated buildings");
		
		_building_instances.set(key, building_node);

func __load_scene_building(scene_to_load: PackedScene) -> BaseBuilding:
	assert(scene_to_load != null, "Building scene to load is null");
	var loaded_scene: Node = scene_to_load.instantiate();
	var building_node: BaseBuilding = loaded_scene as BaseBuilding;
	
	if building_node == null:
		loaded_scene.queue_free();
		return null;
	
	return building_node;
	
func __clear_memory() -> void:
	for building: BaseBuilding in _building_instances.values():
		building.queue_free();
