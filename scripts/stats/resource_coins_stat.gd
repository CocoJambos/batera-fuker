extends InitializableStat;
class_name ResourceCoinsStat;

signal coins_mutated(new_value: int);

@export var _default_resource_coins: int;

var _current_resource_coins: int = 0;
var current_resource_coins_property: int:
	get:
		return _current_resource_coins;
	set(value):
		_current_resource_coins = clamp(value, 1, NumbersGlobal.MAX_INT_VALUE);
		coins_mutated.emit(_current_resource_coins);

func _initialize() -> void:
	current_resource_coins_property = _default_resource_coins;
