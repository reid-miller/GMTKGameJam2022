extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_StartButton_button_up():
	get_tree().change_scene("res://scenes/Board.tscn")

func _on_Minimize_button_up():
	if OS.window_fullscreen:
		OS.window_fullscreen = !OS.window_fullscreen

func _on_Maximize_button_up():
	if !OS.window_fullscreen:
		OS.window_fullscreen = !OS.window_fullscreen

func _on_ExitButton_button_up():
	get_tree().quit()
