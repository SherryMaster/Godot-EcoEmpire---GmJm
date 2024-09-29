extends Control

var energy: float = 0:
	set(value):
		energy = value
		label.text = str(snapped(value, 0.01)) + " / " + str(max_energy)
		progress.value = value


var max_energy: float = 0:
	set(value):
		max_energy = value
		label.text = str(snapped(energy, 0.01)) + " / " + str(value)
		progress.max_value = value

@onready var progress: TextureProgressBar = $Progress
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.energy_changed.connect(func(value): energy = value)
	GameData.max_energy_changed.connect(func(value): max_energy = value)
