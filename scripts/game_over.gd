extends Control

var over = false

func _ready():
	pass

func game_over():
	if !over:
		over = true
		$Laps.text = 'Completed Laps: ' + str(Globals.lap)
		Globals.board.zoom_out()
		show()
	
func _on_Button_button_up():
	Globals.board.reset()

func _on_Exit_button_up():
	get_tree().quit()
