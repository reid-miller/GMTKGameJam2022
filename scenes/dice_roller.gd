extends Area2D

var can_hit = false

func _ready():
	Globals.dice_roller = self
	can_hit = false

func _process(delta):
	if can_hit:
		$AnimatedSprite.frame = 0
	else:
		$AnimatedSprite.frame = 1

		
func floor_cleared():
	Globals.board.zoom_out()
	can_hit = true

func roll_dice():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(1, 6)

func _on_dice_roller_area_entered(area):
	if area is player_hitbox and can_hit:
		can_hit = false
		var die = load('res://scenes/dice.tscn')
		var die_instance = die.instance()
		add_child_below_node(get_tree().get_root(), die_instance)
		die_instance.global_position = global_position
		die_instance.z_index = 100
		die_instance.show()
		var roll = roll_dice()
		die_instance.start(die_instance.global_position - Globals.player_scene.global_position, roll)
