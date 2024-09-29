extends Control
class_name MoneyDisplay

@onready var label: Label = $Panel/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.money_changed.connect(on_money_changed)


func on_money_changed(value):
	label.text = "$ " + str(value)
