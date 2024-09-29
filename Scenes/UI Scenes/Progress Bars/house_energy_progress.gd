extends Control
class_name BuildingEnergyBar


var energy: float = 0:
	set(value):
		energy = value
		progress.value = value


@onready var progress: TextureProgressBar = $Progress


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
