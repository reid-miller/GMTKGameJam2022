extends Path2D


# Declare member variables here. Examples:
export var speed = 100
export var destination = 0
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $PathFollow2D.offset < destination:
		$PathFollow2D.offset += speed * delta


func _on_Button_button_down():
	rng.randomize()
	var rand_num = int(round(rng.randf() * 12.0))
	print_debug(rand_num)
	destination += rand_num * 60

