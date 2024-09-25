extends Node

signal energy_changed(current_value: float)
signal max_energy_changed(current_value: float)

signal carbon_changed(current_value: float)
signal max_carbon_changed(current_value: float)
signal carbon_maxed_out

enum GeneratorTypes {Renew, Fossil}

var Generators = [
	{
		"name": "Solar Panel",
		"type": GeneratorTypes.Renew,
		"texture": preload("res://Assets/Items/Solar Panel Icon.svg"),
		"scene": preload("res://Scenes/Objects/solar_panel.tscn"),
		"price": 25,
		"energy": 1, # Vector2(1, 1),
	},
	{
		"name": "Wind Turbine",
		"type": GeneratorTypes.Renew,
		"texture": preload("res://Assets/Items/WindTurbine Icon.svg"),
		"scene": preload("res://Scenes/Objects/wind_turbine.tscn"),
		"price": 100,
		"energy": 5, # Vector2(0, 10),
	},
	{
		"name": "Generator",
		"type": GeneratorTypes.Fossil,
		"texture": preload("res://Assets/Items/GeneratorRed Icon.svg"),
		"scene": preload("res://Scenes/Objects/red_generator.tscn"),
		"price": 45,
		"energy": 15, # Vector2(0, 10),
		"carbon": 3,
	}
]


var Energy: float = 0:
	set(value):
		var prev_value = Energy
		Energy = min(MaxEnergy, snapped(value, 0.01))
		energy_changed.emit(Energy)

var MaxEnergy: float = 50:
	set(value):
		var prev_value = MaxEnergy
		MaxEnergy = max(1, snapped(value, 0.01))
		max_energy_changed.emit(MaxEnergy)

var CarbonFootPrint: float = 0:
	set(value):
		CarbonFootPrint = min(MaxCarbonFootPrint, value)
		carbon_changed.emit(CarbonFootPrint)
		if CarbonFootPrint == MaxCarbonFootPrint:
			carbon_maxed_out.emit()

var MaxCarbonFootPrint: float = 2500:
	set(value):
		MaxCarbonFootPrint = max(1, value)
		max_carbon_changed.emit(MaxCarbonFootPrint)


func _ready() -> void:
	await get_tree().physics_frame
	_initialize()


func _initialize() -> void:
	Energy = Energy
	MaxEnergy = MaxEnergy
	CarbonFootPrint = CarbonFootPrint
	MaxCarbonFootPrint = MaxCarbonFootPrint
