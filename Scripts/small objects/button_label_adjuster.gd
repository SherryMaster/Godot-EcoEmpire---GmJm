extends Label
class_name TextureButtonAdjustedLabel

enum States {NEUTRAL, DOWN, UP}

@export var pixels_to_adjust: float = 8
@export var button_group: ButtonGroup

@onready var texture_button: TextureButton = $".."

var default_y_pos: float = 0
var state: States = States.NEUTRAL:
	set(value):
		state = value
		position.y = default_y_pos + pixels_to_adjust if value == States.DOWN else default_y_pos - pixels_to_adjust if value == States.UP else default_y_pos

func _ready() -> void:
	default_y_pos = position.y
	if button_group:
		button_group.pressed.connect(on_button_press_in_group)


func _on_texture_button_button_down() -> void: 
	if texture_button.toggle_mode:
		state = States.DOWN if not texture_button.button_pressed else States.NEUTRAL
	else:
		state = States.DOWN

func _on_texture_button_button_up() -> void:
	if texture_button.toggle_mode:
		state = States.NEUTRAL if not texture_button.button_pressed else States.DOWN
	else:
		state = States.NEUTRAL

func on_button_press_in_group(button: BaseButton) -> void:
	if button == texture_button:
		label_settings.font_color = Color.WEB_GRAY
	else:
		label_settings.font_color = Color.WHITE
		state = States.NEUTRAL if not texture_button.button_pressed else States.DOWN
