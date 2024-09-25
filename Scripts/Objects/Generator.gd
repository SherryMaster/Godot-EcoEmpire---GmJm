extends Node2D
class_name Generator

@export var type: GameData.GeneratorTypes
@export var energy_gen_sec: float
@export var efficency: float = 0.5
@onready var sprite_2d: Sprite2D = $Sprite2D

var enabled = false

var energy: float = 0


func general_process(delta: float) -> void:
	if enabled:
		generate_energy(delta)

func generate_energy(delta):
	energy += energy_gen_sec * delta

func collect_energy():
	GameData.Energy += energy
	energy = 0
