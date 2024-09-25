extends Node2D
class_name WorldMap

@onready var grass: TileMapLayer = $Grass

var can_place_objects: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for tile in grass.get_used_cells():
		can_place_objects[tile] = grass.get_cell_tile_data(tile).get_custom_data("place_able")


func get_place_able(cords: Vector2i):
	if cords in can_place_objects:
		return can_place_objects[cords]

func set_place_able(cords: Vector2i, value: bool):
	can_place_objects[cords] = value
