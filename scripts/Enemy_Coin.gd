extends Enemy

onready var enemy_sprite: AnimatedSprite = $CoinBodySprite
onready var lap = Globals.lap
var death_timer: Timer
var anim
var death_interval = 1
var startTime: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_determine_level()
	death_timer = Timer.new()
	add_child(death_timer)
	death_timer.wait_time = death_interval
	death_timer.connect("timeout", self, "_death")
	if dir != Vector2.ZERO:
		enemy_sprite.playing = true

	
func _physics_process(delta: float) -> void:
	_animation_and_rotation()
	_handle_death()

func _animation_and_rotation():
	var pos = player.global_position - global_position
	
	# Handle butt animation
	if pos.x > 0 and pos.y < 0:
		enemy_sprite.animation = anim + "Butt"
	else:
		enemy_sprite.animation = anim
		
	# Change rotation direction
	if pos.x > 0:
		enemy_sprite.rotation += .08
	else:
		enemy_sprite.rotation -= .08
	

func _determine_level():
	if lap == 1:
		enemy_sprite.animation = "Penny"
	elif lap == 2:
		enemy_sprite.animation = "Nickle"
	elif lap == 3:
		enemy_sprite.animation = "Dime"
	elif lap >= 4:
		enemy_sprite.animation = "Quarter"
	anim = enemy_sprite.animation


func _handle_death():
	if health <= 0:
		enemy_sprite.modulate = Color(1,0,0)
		if enemy_sprite.rotation < 0:
			enemy_sprite.rotation -= .2
		else:
			enemy_sprite.rotation += .2
		if !startTime:
			death_timer.start()
			startTime = true

func _death():
	Globals.player_scene._update_ammo_counter(1)
	queue_free()
