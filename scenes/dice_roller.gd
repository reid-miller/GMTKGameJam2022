extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	monitorable = false
	floor_cleared()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func floor_cleared():
	show()
	monitorable = true
	pass


func _on_dice_roller_area_entered(area):
	if area is player_hitbox:
		get_tree().call_group("player_chip", "roll_dice")
		#queue_free()
