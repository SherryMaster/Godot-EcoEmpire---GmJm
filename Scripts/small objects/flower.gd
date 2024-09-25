extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var Colors: Array = [
	preload("res://Assets/Flowers/Blue.svg"),
	preload("res://Assets/Flowers/Green.svg"),
	preload("res://Assets/Flowers/Orange.svg"),
	preload("res://Assets/Flowers/Parrot.svg"),
	preload("res://Assets/Flowers/Pink.svg"),
	preload("res://Assets/Flowers/White.svg"),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = Colors.pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
