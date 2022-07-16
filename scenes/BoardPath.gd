extends Path2D


# Declare member variables here. Examples:
export var speed = 200
export var destination = 0
var BOARD_POS = [0, 162, 304, 442, 582, 740, 919, 1100, 1247, 1396, 1564, 1714, 1862, 2021, 2180, 2339]
var BOARD_SIZE = 15
var pos = 0
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if abs($PathFollow2D.offset - 2519) < 10:
		$PathFollow2D.offset = 0
	elif abs($PathFollow2D.offset - BOARD_POS[pos]) > 10:
		$PathFollow2D.offset += speed * delta

func _on_Button_button_down():
	rng.randomize()
	var rand_num = int(round(rng.randf() * 6.0))
	if pos + rand_num > BOARD_SIZE:
		pos = (pos + rand_num) - BOARD_SIZE
	else:
		pos += rand_num
	print_debug(rand_num)
	print_debug(pos)
	print_debug(BOARD_POS[pos])

