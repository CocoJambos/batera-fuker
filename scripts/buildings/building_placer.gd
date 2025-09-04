extends Node3D;
class_name BuildingPlacer;

@export var _buildings_parent_node: Node3D = null;
@export var _buildings_id_to_scene_map: Dictionary[int, PackedScene];
@export var _buildings_cost: BuildingCost;
@export var _coins_stat: ResourceCoinsStat;
@export var _test_id: int = 0;
@export var _game_state: GameState;
@export_flags_3d_physics var _ray

var _building_instances: Dictionary[int, BaseBuilding];
var _current_selected_building: BaseBuilding = null;
var _spawned_buildings: Array[BaseBuilding] = [];
var _mouse_position: Vector2;
var _draw_3d: Draw3D;
var _draw_tick: int = 0;
var _last_hit_position: Vector3;

func _ready() -> void:
	assert(_coins_stat != null, "Coins stat resource must be provided");
	_draw_3d = Draw3D.new();
	add_child(_draw_3d);
	
	set_physics_process(false);
	_coins_stat._initialize(); # TODO: initialize coins stat in game manager/world
	__preload_buildings();
	_coins_stat.coins_mutated.connect(func(coins: int): print("Coins Ammount: " + str(coins)));
	await _game_state.initialize;
	set_physics_process(true);
	
func _physics_process(delta: float) -> void:
	if _current_selected_building == null:
		return;
	
	var camera: Camera3D  = _game_state.current_camera;
	var ray_beginning: Vector3 = camera.project_ray_origin(_mouse_position);
	var ray_ending: Vector3 = camera.project_ray_normal(_mouse_position) * 1000.0;
	
	_draw_3d.draw_line([_draw_3d.basis.inverse() * ray_beginning, _draw_3d.basis.inverse() * ray_ending], Color.GREEN);
	
	var physics_space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state;
	var raycast_query = PhysicsRayQueryParameters3D.create(ray_beginning, ray_ending);
	var raycast_result = physics_space_state.intersect_ray(raycast_query);
	
	if raycast_result.has("position"):
		var hit_position: Vector3 = raycast_result.get("position") as Vector3;
		_draw_3d.draw_points([hit_position], Color.BLUE);
		
		if _last_hit_position != hit_position:
			_current_selected_building._override_position(hit_position);
			_last_hit_position = hit_position;
	
	_draw_tick += 1;
	
	if _draw_tick % 2:
		_draw_3d.clear();

# TODO: remove _unhandled... selecting should be preformed via UI
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key_event: InputEventKey = event as InputEventKey;
		match key_event.keycode:
			KEY_SPACE:
				select_building(_test_id);
			KEY_F3:
				unselect_building();
			KEY_F4:
				place_selected_building();
				
	if event is InputEventMouse:
		var mouse_event: InputEventMouse = event as InputEventMouse;
		_mouse_position = mouse_event.position;

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
	
func unselect_building() -> void:
	if _current_selected_building == null:
		return;
		
	remove_child(_current_selected_building);
	_current_selected_building.queue_free();
	_current_selected_building = null;
	
func place_selected_building() -> void:
	if _current_selected_building == null || await _current_selected_building._build() == false:
		return;
	
	_coins_stat.current_resource_coins_property -= _buildings_cost.get_cost(_spawned_buildings.size() + 1);
	remove_child(_current_selected_building);
	_buildings_parent_node.add_child(_current_selected_building);
	_spawned_buildings.append(_current_selected_building);
	_current_selected_building = null;

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
