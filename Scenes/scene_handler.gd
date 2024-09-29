extends Node

const GAME_SCENE = preload("res://Scenes/game_scene.tscn")
const LOOSE_SCREEN = preload("res://Scenes/UI Scenes/Compoenet UIs/loose_screen.tscn")
const MAIN_TITLE = preload("res://Scenes/UI Scenes/main_title.tscn")

var game_scene

func _ready() -> void:
	load_title_screen()

func clear_scene():
	if is_instance_valid(get_child(0)):
		get_child(0).queue_free()

func load_title_screen():
	clear_scene()
	var title_scene = MAIN_TITLE.instantiate()
	title_scene.start_game.connect(load_game_scene)
	add_child(title_scene)

func load_game_scene():
	clear_scene()
	game_scene = GAME_SCENE.instantiate()
	game_scene.game_over.connect(on_game_end)
	add_child(game_scene)
	GameData.reset()
	GameData.initialize()

func on_game_end():
	var new_loose_screen = LOOSE_SCREEN.instantiate()
	game_scene.hud.add_child(new_loose_screen)
	new_loose_screen.restart_game.connect(func():
		load_game_scene()
	)
	new_loose_screen.quit_to_title.connect(func():
		load_title_screen()
	)
	get_tree().paused = true
