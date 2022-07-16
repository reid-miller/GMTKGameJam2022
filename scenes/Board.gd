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

func new_room(pos):
	# print_debug($Squares.get_child(pos).color) # Get color of tile, red: 0 green: 1 yellow: 2
	room_instance.queue_free()
	rng.randomize()
	var room_num = rng.randi_range(0, 2)
	var room = load('res://scenes/rooms/room_' + str(room_num) + '.tscn')
	room_instance = room.instance()
	add_child_below_node($Squares, room_instance)
	room_instance.position.x = 319
	room_instance.position.y = 179
	room_instance.scale.x = 0.6
	room_instance.scale.y = 0.6
	
func change_tile(tile_num):
	$Squares.get_child(tile_num).shuffle_square()
	pass

func zoom_in():
	$AnimationPlayer.play("zoom_in")
func zoom_out():
	$AnimationPlayer.play("zoom_out")
	
func _on_Player_player_died():
	$gui.game_over()

func reset():
	get_tree().reload_current_scene()
