extends Enemy

onready var enemy_sprite: AnimatedSprite = $EnemyBodySprite


# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_sprite.playing = true # Replace with function body.
	
