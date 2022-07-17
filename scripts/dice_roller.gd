extends Area2D


func _ready():
	Globals.dice_roller = self
	set_monitoring(false)
	hide()


func _process(delta):
	pass

		
func floor_cleared():
	Globals.board.zoom_out()
	show()
	set_monitoring(true)
	pass


func _on_dice_roller_area_entered(area):
	if area is player_hitbox:
		set_monitoring(false)
		hide()
		get_tree().call_group("player_chip", "roll_dice")
		#queue_free()
