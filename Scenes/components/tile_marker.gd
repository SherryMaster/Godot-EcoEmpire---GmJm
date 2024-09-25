extends Node2D
class_name TileMarker

const TILE_VALID = preload("res://Assets/TileValid.svg")
const TILE_INVALID = preload("res://Assets/TileInvalid.svg")

var tile_valid: bool = true:
	set(value):
		tile_valid = value
		if value:
			sprite_2d.texture = TILE_VALID
		else:
			sprite_2d.texture = TILE_INVALID

var activated: bool = false:
	set(value):
		activated = value
		if value:
			sprite_2d.visible = true
		else:
			sprite_2d.visible = false

@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
