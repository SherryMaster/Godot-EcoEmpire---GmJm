extends Node2D
class_name Building

@onready var progress_bar: BuildingEnergyBar = $ProgressBar


@export var energy_consumption: float
var energy_consumed: float:
	set(value):
		energy_consumed = max(min(value, energy_consumption), 0)
		progress_bar.energy = (energy_consumed/energy_consumption) * 100
		
@export var money_generation: float

var enabled: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if enabled:
		progress_bar.visible = true
	else:
		progress_bar.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enabled:
		if GameData.Energy > energy_consumption * delta:
			energy_consumed += energy_consumption * delta
			GameData.Energy -= energy_consumption * delta
		elif GameData.Energy > 0:
			energy_consumed += GameData.Energy / 2
			GameData.Energy -= GameData.Energy / 2
		
		if energy_consumed == energy_consumption:
			make_money()
		

func make_money():
	GameData.Money += money_generation
	energy_consumed = 0
#func consume_energy():
	#energy_consumed += energy_consumption * delta
	#GameData.Energy -= energy_consumption * delta
