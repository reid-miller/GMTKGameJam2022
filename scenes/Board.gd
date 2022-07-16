extends Node2D

var zoom = false
onready var room_instance = $room
var rng = RandomNumberGenerator.new()

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		if Input.is_action_just_released("ui_accept"):
			new_room()
			zoom = !zoom
			if zoom:
				$AnimationPlayer.play("zoom_in")
			else:
				$AnimationPlayer.play("zoom_out")

func new_room():
	room_instance.queue_free()
	rng.randomize()
	var room_num = rng.randi_range(1, 2)
	var room = load('res://scenes/rooms/room_' + str(room_num) + '.tscn')
	room_instance = room.instance()
	add_child(room_instance)
	room_instance.position.x = 319
	room_instance.position.y = 179
	room_instance.scale.x = 0.6
	room_instance.scale.y = 0.6
