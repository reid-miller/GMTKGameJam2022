extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button2_button_up():
	if zoom.x == 1:
		zoom.x = 0.75
		zoom.y = 0.75
	else:
		zoom.x = 1
		zoom.y = 1
	pass # Replace with function body.
