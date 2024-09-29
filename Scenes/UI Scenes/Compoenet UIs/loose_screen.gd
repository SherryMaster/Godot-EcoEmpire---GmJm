extends ColorRect

signal restart_game
signal quit_to_title


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	get_tree().paused = false
	restart_game.emit()


func _on_quit_pressed() -> void:
	get_tree().paused = false
	quit_to_title.emit()
