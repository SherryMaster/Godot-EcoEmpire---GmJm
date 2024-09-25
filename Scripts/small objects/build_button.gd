extends TextureButton

@onready var item_icon: TextureRect = $ItemIcon
@onready var label: Label = $Label


var icon: Texture2D
var price: int
var button_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_icon.texture = icon
	label.text = "$  " + str(price)
	size_flags_vertical = SizeFlags.SIZE_SHRINK_CENTER
