extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.dice_roller = self
	set_monitoring(false)
	hide()
	check_room(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	show()
	set_monitoring(true)
	pass


func _on_dice_roller_area_entered(area):
	if area is player_hitbox:
		Globals.board.zoom_out()
		set_monitoring(false)
		hide()
		get_tree().call_group("player_chip", "roll_dice")
		#queue_free()
