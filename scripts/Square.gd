extends Node2D


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
		$Sprite.texture = load('res://sprites/red tile.png')
	# Green
	elif 6 < rand_num and rand_num > 9:
		$Sprite.texture = load('res://sprites/green tile.png')
	else:
		$Sprite.texture = load('res://sprites/special tile.png')
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
