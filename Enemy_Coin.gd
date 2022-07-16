extends Enemy

onready var enemy_sprite: AnimatedSprite = $CoinBodySprite
onready var lap = Globals.lap
var anims
var death_interval = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if dir != Vector2.ZERO:
		enemy_sprite.playing = true
	
	# Get animation names
	anims = enemy_sprite.frames.get_animation_names()
	
func _physics_process(delta: float) -> void:
	var pos = player.global_position - global_position	
	if pos.x > 0 and pos.y < 0:
		enemy_sprite.animation = anims[lap]
	else:
		enemy_sprite.animation = anims[lap-1]
	print(health)
	if pos.x > 0:
		enemy_sprite.rotation += .08
	else:
		enemy_sprite.rotation -= .08
		
	if health <= 0:
		print("dead")
