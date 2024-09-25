extends Node

const GAME_SCENE = preload("res://Scenes/game_scene.tscn")

func _ready() -> void:
	load_game_scene()

func clear_scene():
	if is_instance_valid(get_child(0)):
		get_child(0).queue_free()

func load_game_scene():
	clear_scene()
	var game_scene = GAME_SCENE.instantiate()
	add_child(game_scene)
