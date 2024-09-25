extends Control
class_name BuildBar

@onready var renewables: ButtonControlledUI = $TextureRect/Panels/Renewables
@onready var fossil: ButtonControlledUI = $TextureRect/Panels/Fossil

const BUILD_BUTTON = preload("res://Scenes/UI Scenes/Build Bar/build_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var renew_button_index: int = 0
	var fossil_button_index: int = 0
	
	for generator in GameData.Generators:
		var new_button = BUILD_BUTTON.instantiate()
		new_button.icon = generator.texture
		new_button.price = generator.price
		if generator.type == GameData.GeneratorTypes.Renew:
			new_button.button_index = renew_button_index
			renewables.add_child(new_button)
			renew_button_index += 1
		if generator.type == GameData.GeneratorTypes.Fossil:
			new_button.button_index = fossil_button_index
			fossil.add_child(new_button)
			fossil_button_index += 1
