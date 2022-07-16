extends Node2D

var zoom = false


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		if Input.is_action_just_released("ui_accept"):
			zoom = !zoom
			if zoom:
				$AnimationPlayer.play("zoom_in")
			else:
				$AnimationPlayer.play("zoom_out")
