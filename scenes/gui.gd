extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.

func game_over():
	$RichTextLabel.text = 'Rounds survived ' + str(Globals.lap)
	show()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_button_up():
	Globals.board.game_over()
