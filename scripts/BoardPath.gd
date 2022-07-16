extends Path2D


const BOARD_POS = [0, 162, 304, 442, 582, 740, 919, 1100, 1247, 1396, 1564, 1714, 1862, 2021, 2180, 2339]
const BOARD_SIZE = 15
var pos = 0
export var speed = 200
export var destination = 0
var moving = false
var rng = RandomNumberGenerator.new()


func _ready():
	pass # Replace with function body.


func _process(delta):
	if abs($PathFollow2D.offset - 2519) < 10:
		$PathFollow2D.offset = 0
	elif abs($PathFollow2D.offset - BOARD_POS[pos]) > 10:
		$PathFollow2D.offset += speed * delta
	# Done moving
	elif abs($PathFollow2D.offset - BOARD_POS[pos]) < 10 and moving:
		moving = false
		Globals.board.new_room()
		pass
		

func _on_Button_button_down():
	rng.randomize()
	var rand_num = int(round(rng.randf() * 6.0))
	if pos + rand_num > BOARD_SIZE:
		pos = (pos + rand_num) - BOARD_SIZE
	else:
		pos += rand_num
		
func roll_dice():
	Globals.board.change_tile(pos)
	rng.randomize()
	var rand_num = int(round(rng.randf() * 6.0))
	if pos + rand_num > BOARD_SIZE:
		pos = (pos + rand_num) - BOARD_SIZE
	else:
		pos += rand_num
	moving = true
	

