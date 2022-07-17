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
		var timer = Timer.new()
		add_child(timer)
		timer.connect("timeout", Globals.board, 'zoom_in', [pos])
		timer.wait_time = 1
		timer.one_shot = true
		timer.start()
		pass
		
		
func move_pos(roll):
	print_debug('HELLO?')
	Globals.board.change_tile(pos)
	rng.randomize()
	if pos + roll > BOARD_SIZE:
		Globals.lap += 1
		pos = (pos + roll) - BOARD_SIZE
	else:
		pos += roll
	moving = true
	

