extends Node2D
class_name Generator

@export var type: GameData.GeneratorTypes
@export var energy_gen_sec: float = 0
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var carbon_sec: float = 0
var enabled: bool = true

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if enabled and animation_player:
		animation_player.play("default")

func _process(delta: float) -> void:
	if enabled:
		GameData.Energy += energy_gen_sec * delta
		GameData.CarbonFootPrint += carbon_sec * delta
