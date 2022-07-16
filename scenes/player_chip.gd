extends Node2D


# Declare member variables here. Examples:
const SQUARE_SIZE = 60
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move(spaces):
	for x in spaces:
		# Top Row
		if (position.x >= 30 and position.x < 570):
			pass
		else:
			pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Button_button_down():
	move(2)
	pass # Replace with function body.
