extends ColorRect


# Declare member variables here. Examples:
var rng = RandomNumberGenerator.new()



# Called when the node enters the scene tree for the first time.
func _ready():
	change_square()
	pass # Replace with function body.

func change_square():
	rng.randomize()
	var rand_num = rng.randf() * 10.0
	print_debug(rand_num)
	# Red
	if 0 < rand_num and rand_num < 6:
		color = Color8(222, 42, 29)
	# Green
	elif 6 < rand_num and rand_num > 9:
		color = Color8(127, 166, 70)
	else:
		color = Color8(242, 170, 107)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
