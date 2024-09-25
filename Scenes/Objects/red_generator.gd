extends Generator
class_name FuelGenerator

@export var carbon_sec: float = 5
var carbon: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	general_process(delta)

func generate_energy(delta):
	energy += energy_gen_sec * delta
	carbon += carbon_sec * delta

func collect_energy():
	GameData.Energy += energy
	GameData.CarbonFootPrint += carbon
	energy = 0
	carbon = 0
