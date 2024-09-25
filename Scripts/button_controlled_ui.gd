extends Control
class_name ButtonControlledUI

@export var button: TextureButton
@export var button_group: ButtonGroup

func _ready() -> void:
	button_group.pressed.connect(on_button_trigger)


func on_button_trigger(btn: BaseButton):
	if btn == button:
		visible = true
	else:
		visible = false
