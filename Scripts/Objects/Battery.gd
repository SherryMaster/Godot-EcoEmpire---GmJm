extends Node2D
class_name Battery


@export var energy: float
var enabled: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if enabled:
		GameData.MaxEnergy += energy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
