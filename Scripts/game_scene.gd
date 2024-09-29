extends Node2D
signal game_over

enum BuildModes{Generator, Building, Battery, Tree}

@onready var grass: TileMapLayer = $Map/Grass
@onready var map: WorldMap = $Map
@onready var flowers: Node2D = $Flowers
@onready var stat_refresh_time: Timer = $StatRefreshTime
@onready var tile_marker: TileMarker = $TileMarker
@onready var build_bar: BuildBar = $HUD/BuildBar
@onready var preview_space: Node2D = $PreviewSpace
@onready var objects: Node2D = $Objects
@onready var game_camera: GameCamera = $GameCamera
@onready var hud: CanvasLayer = $HUD
@onready var q_to_cancel: Label = $HUD/QToCancel


var build_mode: bool = false:
	set(value):
		build_mode = value
		tile_marker.activated = value
		if value:
			build_bar.visible = false
			q_to_cancel.visible = true
		else:
			build_bar.visible = true
			q_to_cancel.visible = false
var build_valid: bool = true:
	set(value):
		build_valid = value
		tile_marker.tile_valid = value

var current_build_mode: BuildModes

var button_index: int
var current_item_to_build

var current_tile_pos: Vector2
var current_tile_cords: Vector2i


var pause_tile_check: bool = false

const FLOWER = preload("res://Scenes/flower.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel_build"):
		cancel_build_mode()
	
	if build_mode:
		if event.is_action_pressed("click"):
			verify_and_build()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for cell in grass.get_used_cells():
		var tile_data = grass.get_cell_tile_data(cell)
		var num_of_flowers = tile_data.get_custom_data("flowers")
		for i in range(num_of_flowers):
			var flower = FLOWER.instantiate()
			flower.global_position.x = randi_range(0, grass.tile_set.tile_size.x) + (grass.tile_set.tile_size.x * cell.x)
			flower.global_position.y = randi_range(0, grass.tile_set.tile_size.y) + (grass.tile_set.tile_size.y * cell.y)
			flowers.add_child(flower)
	
	for button in build_bar.renewables.get_children() as Array[Button]:
		button.pressed.connect(initiate_build_mode.bind("renew", button))
	for button in build_bar.fossil.get_children() as Array[Button]:
		button.pressed.connect(initiate_build_mode.bind("fossil", button))
	for button in build_bar.houses.get_children() as Array[Button]:
		button.pressed.connect(initiate_build_mode.bind("house", button))
	for button in build_bar.batteries.get_children() as Array[Button]:
		button.pressed.connect(initiate_build_mode.bind("battery", button))
	for button in build_bar.trees.get_children() as Array[Button]:
		button.pressed.connect(initiate_build_mode.bind("tree", button))
	
	GameData.carbon_maxed_out.connect(func():
		game_over.emit()
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	select_tile(get_global_mouse_position())
	GameData.CarbonFootPrint -= GameData.CarbonReductionPower * (delta / 5)

func initiate_build_mode(type, button):
	if build_mode:
		cancel_build_mode()
	build_mode = true
	button_index = button.button_index
	if type == "renew":
		initiate_generator_build_mode(GameData.GeneratorTypes.Renew)
	elif type == "fossil":
		initiate_generator_build_mode(GameData.GeneratorTypes.Fossil)
	elif type == "house":
		initiate_building_build_mode(GameData.BuildingTypes.House)
	elif type == "battery":
		initiate_battery_build_mode()
	elif type == "tree":
		initiate_tree_build_mode()
	
	game_camera.on_build_mode_started()

func initiate_generator_build_mode(type: GameData.GeneratorTypes):
	current_build_mode = BuildModes.Generator
	
	var build_items = []
	build_items = GameData.Generators.filter(func(item): return item.type == type)
	
	current_item_to_build = build_items[button_index]
	
	var new_item = current_item_to_build.scene.instantiate() as Generator
	new_item.enabled = false
	new_item.modulate = Color(1, 1, 1, 0.5)
	preview_space.add_child(new_item)

func initiate_building_build_mode(type: GameData.BuildingTypes):
	current_build_mode = BuildModes.Building
	
	var build_items = []
	build_items = GameData.Buildings.filter(func(item): return item.type == type)
	
	current_item_to_build = build_items[button_index]
	
	var new_item = current_item_to_build.scene.instantiate() as Building
	new_item.enabled = false
	new_item.modulate = Color(1, 1, 1, 0.5)
	preview_space.add_child(new_item)

func initiate_battery_build_mode():
	current_build_mode = BuildModes.Battery
	
	current_item_to_build = GameData.Batteries[button_index]
	
	var new_item = current_item_to_build.scene.instantiate() as Battery
	new_item.enabled = false
	new_item.modulate = Color(1, 1, 1, 0.5)
	preview_space.add_child(new_item)

func initiate_tree_build_mode():
	current_build_mode = BuildModes.Tree
	
	current_item_to_build = GameData.Trees[button_index]
	
	var new_item = current_item_to_build.scene.instantiate() as TreeObject
	new_item.enabled = false
	new_item.modulate = Color(1, 1, 1, 0.5)
	preview_space.add_child(new_item)


func verify_and_build():
	if build_valid:
		if GameData.Money >= current_item_to_build.price:
			var item_to_build = current_item_to_build.scene.instantiate()
			item_to_build.global_position = current_tile_pos
			if current_build_mode == BuildModes.Generator:
				item_to_build.energy_gen_sec = current_item_to_build.energy
				if "carbon" in current_item_to_build:
					item_to_build.carbon_sec = current_item_to_build.carbon
			if current_build_mode == BuildModes.Building:
				item_to_build.energy_consumption = current_item_to_build.energy
				item_to_build.money_generation = current_item_to_build.money
			if current_build_mode == BuildModes.Tree:
				item_to_build.carbon = current_item_to_build.carbon
			if current_build_mode == BuildModes.Battery:
				item_to_build.energy = current_item_to_build.energy
			item_to_build.enabled = true
			objects.add_child(item_to_build)
			
			GameData.Money -= current_item_to_build.price
			map.set_place_able(current_tile_cords, false)
		else:
			build_valid = false
			pause_tile_check = true
			await get_tree().create_timer(0.2).timeout
			build_valid = true
			pause_tile_check = false
		
		return true
	return false

func cancel_build_mode():
	build_mode = false
	preview_space.get_child(0).queue_free() if is_instance_valid(preview_space.get_child(0)) else null
	
	game_camera.on_build_mode_ended()

func update_build_preview(pos: Vector2):
	if build_mode:
		preview_space.get_child(0).global_position = pos

func select_tile(m_pos: Vector2):
	current_tile_cords = grass.local_to_map(m_pos)
	current_tile_pos = grass.map_to_local(current_tile_cords)
	
	tile_marker.global_position = current_tile_pos
	update_build_preview(current_tile_pos)
	
	if build_mode and not pause_tile_check:
		var can_place = map.get_place_able(current_tile_cords)
		if can_place:
			build_valid = true
		else:
			build_valid = false
