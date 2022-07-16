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
	_handle_death()
	
	var pos = player.global_position - global_position	
	# Handle butt animation
	if pos.x > 0 and pos.y < 0:
		enemy_sprite.animation = anims[lap]
	else:
		enemy_sprite.animation = anims[lap-1]

	# Change rotation direction
	if pos.x > 0:
		enemy_sprite.rotation += .08
	else:
		enemy_sprite.rotation -= .08

func _handle_death():
	var death_timer: Timer = Timer.new()
	add_child(death_timer)
	death_timer.wait_time = death_interval
	death_timer.connect("timeout", self, "_death")
	
	if health <= 0:
		enemy_sprite.modulate = Color(1,0,0)
		if enemy_sprite.rotation < 0:
			enemy_sprite.rotation -= .2
		else:
			enemy_sprite.rotation += .2
		death_timer.start()

func _death():
	queue_free()
