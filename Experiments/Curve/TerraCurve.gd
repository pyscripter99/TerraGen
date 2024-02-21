@tool
class_name TerraCurve
extends Line2D

@export var point_1: Vector2
@export var object_1: Control ## Use Control for position instead of Vector2 above
@export var point_2: Vector2
@export var object_2: Control ## Use Control for position instead of Vector2 above
@export_range(0.0, 0.5) var curve_strength: float = 0.5 ## The smoothness of the curve, 0.0 for straight line and 0.5 for max curve
@export var _redraw: bool = false: ## Is a bool, but behaves like a button for editor use only. Use redraw method when calling from scripts
	set(val):
		redraw()
	get:
		return false

func redraw():
	if object_1:
		point_1 = object_1.position
	if object_2:
		point_2 = object_2.position
	var distance = point_2.x - point_1.x
	var in_out_distance = distance * curve_strength
	
	var curve = Curve2D.new() # Don't want to make a new curve on every redraw, but editor was complaining before

	# Add points and weights
	curve.add_point(point_1, Vector2.ZERO, Vector2(in_out_distance, 0))
	curve.add_point(point_2, Vector2(-in_out_distance, 0), Vector2.ZERO)
	# Set this (Line2D) points to besier curve
	points = curve.get_baked_points()
	
	queue_redraw() # Redraw element, otherwise it won't change
