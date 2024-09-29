extends Node

signal energy_changed(current_value: float)
signal max_energy_changed(current_value: float)
signal money_changed(current_value: float)

signal carbon_changed(current_value: float)
signal max_carbon_changed(current_value: float)
signal carbon_maxed_out

enum GeneratorTypes {Renew, Fossil}
enum BuildingTypes {House, Factory}

var Generators = [
	{
		"name": "Solar Panel",
		"type": GeneratorTypes.Renew,
		"texture": preload("res://Assets/Items/Generators/Solar Panel Icon.svg"),
		"scene": preload("res://Scenes/Objects/Generators/solar_panel.tscn"),
		"price": 25,
		"energy": 1, # Vector2(1, 1),
	},
	{
		"name": "Wind Turbine",
		"type": GeneratorTypes.Renew,
		"texture": preload("res://Assets/Items/Generators/WindTurbine Icon.svg"),
		"scene": preload("res://Scenes/Objects/Generators/wind_turbine.tscn"),
		"price": 80,
		"energy": 3, # Vector2(0, 10),
	},
	{
		"name": "Generator",
		"type": GeneratorTypes.Fossil,
		"texture": preload("res://Assets/Items/Generators/GeneratorRed Icon.svg"),
		"scene": preload("res://Scenes/Objects/Generators/red_generator.tscn"),
		"price": 45,
		"energy": 10, # Vector2(0, 10),
		"carbon": 0.5,
	}
]

var Buildings = [
	{
		"name": "Small House",
		"type": BuildingTypes.House,
		"texture": preload("res://Assets/Items/Buildings/House1.svg"),
		"scene": preload("res://Scenes/Objects/Buildings/house1.tscn"),
		"price": 45,
		"energy": 3,
		"money": 1
	},
	{
		"name": "Medium House",
		"type": BuildingTypes.House,
		"texture": preload("res://Assets/Items/Buildings/House2.svg"),
		"scene": preload("res://Scenes/Objects/Buildings/house2.tscn"),
		"price": 200,
		"energy": 10,
		"money": 4
	}
]

var Batteries = [
	{
		"name": "Small Battery",
		"texture": preload("res://Assets/Items/Batteries/Battery 1.svg"),
		"scene": preload("res://Scenes/Objects/Batteries/battery.tscn"),
		"price": 30,
		"energy": 25,
	}
]

var Trees = [
	{
		"name": "Tree",
		"texture": preload("res://Assets/Items/Trees/Tree1.svg"),
		"scene": preload("res://Scenes/Objects/Trees/tree.tscn"),
		"price": 20,
		"carbon": 2,
	}
]

var Money: int = 100:
	set(value):
		Money = max(0, value)
		money_changed.emit(Money)

var Energy: float = 0:
	set(value):
		var prev_value = Energy
		Energy = max(min(MaxEnergy, value), 0)
		energy_changed.emit(Energy)

var MaxEnergy: float = 0:
	set(value):
		var prev_value = MaxEnergy
		MaxEnergy = max(0, snapped(value, 0.01))
		max_energy_changed.emit(MaxEnergy)

var CarbonFootPrint: float = 0:
	set(value):
		CarbonFootPrint = max(min(MaxCarbonFootPrint, value), 0)
		carbon_changed.emit(CarbonFootPrint)
		if CarbonFootPrint == MaxCarbonFootPrint:
			carbon_maxed_out.emit()

var MaxCarbonFootPrint: float = 2500:
	set(value):
		MaxCarbonFootPrint = max(1, value)
		max_carbon_changed.emit(MaxCarbonFootPrint)

var CarbonReductionPower: float = 5: # Done every 5 seconds
	set(value):
		CarbonReductionPower = value


func initialize() -> void:
	Energy = Energy
	MaxEnergy = MaxEnergy
	CarbonFootPrint = CarbonFootPrint
	MaxCarbonFootPrint = MaxCarbonFootPrint
	Money = Money


func reset():
	Money = 100
	Energy = 0
	MaxEnergy = 0
	CarbonFootPrint = 0
	MaxCarbonFootPrint = 2500
	CarbonReductionPower = 5
