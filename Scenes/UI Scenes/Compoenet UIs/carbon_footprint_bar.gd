extends Control

@onready var progress: TextureProgressBar = $progress
@onready var carbon_label: Label = $Label_BG/VBoxContainer/CarbonLabel
@onready var carbon_max_label: Label = $Label_BG/VBoxContainer/CarbonMaxLabel

@onready var carbon: float = GameData.CarbonFootPrint:
	set(value):
		carbon = value
		progress.value = value
		carbon_label.text = str(snapped(value, 0.01))
		
		var percentage = (carbon / max_carbon) * 100
		
		var r: float
		var g: float
		var b: float
		
		if percentage > 50:
			r = Utils.ranged_lerp(0.835, 0.941, 50, 100, percentage)
			g = Utils.ranged_lerp(0.941, 0, 50, 100, percentage)
			b = Utils.ranged_lerp(0, 0, 50, 100, percentage)
		else:
			r = Utils.ranged_lerp(0.443, 0.835, 0, 50, percentage)
			g = Utils.ranged_lerp(0.922, 0.941, 0, 50, percentage)
			b = Utils.ranged_lerp(0, 0, 0, 50, percentage)
		
		
		progress.tint_progress = Color(r, g, b)

@onready var max_carbon: float = GameData.MaxCarbonFootPrint:
	set(value):
		max_carbon = value
		progress.max_value = value
		carbon_max_label.text = str(snapped(value, 0.01))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.carbon_changed.connect(func(value): carbon = value)
	GameData.max_carbon_changed.connect(func(value): max_carbon = value)
