extends Node2D
class_name TreeObject

@export var carbon: float = 2

var enabled: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if enabled:
		GameData.CarbonReductionPower += carbon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
