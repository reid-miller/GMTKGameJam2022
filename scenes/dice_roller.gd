extends Area2D


func _ready():
	Globals.dice_roller = self
	set_monitoring(false)
	hide()


#func _process(delta):
#	pass

# Check if any enemys are in room
func check_room(from_enemy):
	if from_enemy:
		if get_tree().get_nodes_in_group('enemy').size() - 1 == 0:
			floor_cleared()

	else: 
		if get_tree().get_nodes_in_group('enemy').size() == 0:
			floor_cleared()


		
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
