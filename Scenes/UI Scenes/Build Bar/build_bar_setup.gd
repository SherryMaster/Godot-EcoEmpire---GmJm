extends Control
class_name BuildBar

@onready var renewables: ButtonControlledUI = $TextureRect/Panels/Renewables
@onready var fossil: ButtonControlledUI = $TextureRect/Panels/Fossil
@onready var houses: ButtonControlledUI = $TextureRect/Panels/Houses
@onready var batteries: ButtonControlledUI = $TextureRect/Panels/Batteries
@onready var trees: ButtonControlledUI = $TextureRect/Panels/Trees

const BUILD_BUTTON = preload("res://Scenes/UI Scenes/Build Bar/build_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var renew_button_index: int = 0
	var fossil_button_index: int = 0
	var house_button_index: int = 0
	var battery_button_index: int = 0
	var tree_button_index: int = 0
	
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
	
	for house in GameData.Buildings:
		var new_button = BUILD_BUTTON.instantiate()
		new_button.icon = house.texture
		new_button.price = house.price
		if house.type == GameData.BuildingTypes.House:
			new_button.button_index = house_button_index
			houses.add_child(new_button)
			house_button_index += 1
	
	for battery in GameData.Batteries:
		var new_button = BUILD_BUTTON.instantiate()
		new_button.icon = battery.texture
		new_button.price = battery.price
		new_button.button_index = battery_button_index
		batteries.add_child(new_button)
		battery_button_index += 1
	
	for tree in GameData.Trees:
		var new_button = BUILD_BUTTON.instantiate()
		new_button.icon = tree.texture
		new_button.price = tree.price
		new_button.button_index = tree_button_index
		trees.add_child(new_button)
		tree_button_index += 1
