extends Resource
class_name BuildingCost;

@export var cost_curve: Curve;

func get_cost(buildings_count: int) -> int:
	assert(cost_curve == null, "Cost Curve must be filled");
	var clamped_buildings_count: int = clamp(buildings_count, 0, NumbersGlobal.MAX_INT_VALUE);
	var curve_offset: float = float(clamped_buildings_count);
	var cost: int = cost_curve.sample(curve_offset);
	return cost;
