extends Camera2D
class_name GameCamera

var can_move = false
var scale_factor = 0.95

var build_mode_started_in_game = false

@export var right_limit_node: Node2D
@export var bottom_limit_node: Node2D

@export var min_zoom_limit: float = 0.5
@export var max_zoom_limit: float = 3


func _unhandled_input(event: InputEvent) -> void:
	if not build_mode_started_in_game:
		if event.is_action_pressed("click"):
			can_move = true
		elif event.is_action_released("click"):
			can_move = false
	
	if event.is_action_pressed("scroll_up"):
		zoom /= scale_factor
		zoom.x = min(zoom.x, max_zoom_limit)
		zoom.y = min(zoom.y, max_zoom_limit)
	elif event.is_action_pressed("scroll_down"):
		zoom *= scale_factor
		zoom.x = max(zoom.x, min_zoom_limit)
		zoom.y = max(zoom.y, min_zoom_limit)
	
	if event is InputEventMouseMotion:
		if can_move:
			global_position -= event.relative/get_screen_transform().x.x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	limit_right = right_limit_node.global_position.x
	limit_bottom = bottom_limit_node.global_position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x = min(max(limit_left + (get_viewport_rect().size.x / 2) / get_screen_transform().x.x, global_position.x), limit_right - (get_viewport_rect().size.x / 2) / get_screen_transform().x.x)
	global_position.y = min(max(limit_top + (get_viewport_rect().size.y / 2) / get_screen_transform().x.x, global_position.y), limit_bottom - (get_viewport_rect().size.y / 2) / get_screen_transform().x.x)
	pass

func on_build_mode_started():
	build_mode_started_in_game = true

func on_build_mode_ended():
	build_mode_started_in_game = false
