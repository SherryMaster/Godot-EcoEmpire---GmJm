extends Node

func ranged_lerp(a: float, b: float, x: float, y: float, value_in_xy: float) -> float:
	"""
	Interpolates a value within range [a, b] according to the range [x, y].

	Parameters:
	a (float): The start of the target range.
	b (float): The end of the target range.
	x (float): The start of the original range.
	y (float): The end of the original range.
	value_in_xy (float): The value within the original range [x, y].

	Returns:
	float: The interpolated value within the target range [a, b].
	"""
	# Calculate the proportion of the value within the original range
	
	#if value_in_xy < x:
		#value_in_xy = x
	#if value_in_xy > y:
		#value_in_xy = y
	
	var proportion: float = (value_in_xy - x) / (y - x)

	# Interpolate within the target range
	var interpolated_value: float = a + proportion * (b - a)

	return interpolated_value
