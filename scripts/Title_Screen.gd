extends Control

export var audio_bus_name := "Master"

onready var _bus := AudioServer.get_bus_index(audio_bus_name)

func _on_value_changed(value: float):
	AudioServer.set_bus_volume_db(_bus, linear2db(value))
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var value = db2linear(AudioServer.get_bus_volume_db(_bus))

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
