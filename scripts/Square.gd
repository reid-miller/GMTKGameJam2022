extends Node2D


# Declare member variables here. Examples:
var rng = RandomNumberGenerator.new()
var color = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	shuffle_square()
	pass # Replace with function body.

func shuffle_square():
	$Timer.start()
	$AnimatedSprite.play()
	pass
	
func change_square():
	$AnimatedSprite.stop()
	rng.randomize()
	var rand_num = rng.randi_range(1, 100)
	print_debug(rand_num)
	# Red
	if 0 < rand_num and rand_num < 80:
		$AnimatedSprite.set_frame(0)
		color = 0
	# Green
	elif 80 < rand_num and rand_num > 90:
		$AnimatedSprite.set_frame(1)
		color = 1
	else:
		
		$AnimatedSprite.set_frame(2)
		color = 2
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	change_square()
