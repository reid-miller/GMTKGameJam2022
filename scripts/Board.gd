extends Node2D

var zoom = false
onready var room_instance = $room
var rng = RandomNumberGenerator.new()

func _ready():
	Globals.board = self
	Globals.dice_roller.floor_cleared()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_room(child_idx):
	var room_num
	var room
	var color = $Squares.get_child(child_idx).color
	room_instance.queue_free()
	# Red
	if color == 0:
		rng.randomize()
		room_num = rng.randi_range(0, 2)
		room = load('res://scenes/rooms/room_' + str(room_num) + '.tscn')
		$red_sound.play()
	# Green
	elif color == 1:
		room = load('res://scenes/room.tscn')
		$yellow_sound.play()
		$green_timer.start()
	# Yellow
	else:
		room = load('res://scenes/rooms/item_room.tscn')
		$yellow_sound.play()	
	room_instance = room.instance()
	add_child_below_node($Squares, room_instance)
	room_instance.position.x = 319
	room_instance.position.y = 179
	room_instance.scale.x = 0.6
	room_instance.scale.y = 0.6
	
func change_tile(tile_num):
	$Squares.get_child(tile_num).shuffle_square()

func zoom_in(pos):
	$AnimationPlayer.play("zoom_in")
	new_room(pos)
	
func zoom_out():
	$AnimationPlayer.play("zoom_out")
	
func _on_Player_player_died():
	$game_over.game_over()

func reset():
	Globals.enemies_left = 0
	Globals.lap = 0
	get_tree().change_scene("res://scenes/Title_Screen.tscn")


func _on_green_timer_timeout():
	Globals.player_scene.green_tile_effect()
