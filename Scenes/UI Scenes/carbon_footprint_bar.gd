extends Control

@onready var progress: TextureProgressBar = $progress
@onready var carbon_label: Label = $Label_BG/VBoxContainer/CarbonLabel
@onready var carbon_max_label: Label = $Label_BG/VBoxContainer/CarbonMaxLabel

@onready var carbon: float = GameData.CarbonFootPrint:
	set(value):
		carbon = value
		progress.value = value
		carbon_label.text = str(value)

@onready var max_carbon: float = GameData.MaxCarbonFootPrint:
	set(value):
		max_carbon = value
		progress.max_value = value
		carbon_max_label.text = str(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.carbon_changed.connect(func(value): carbon = value)
	GameData.max_carbon_changed.connect(func(value): max_carbon = value)
