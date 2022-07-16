extends StaticBody2D

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$AnimatedSprite.set_frame(rng.randi_range(0, 2))

