extends Enemy

onready var enemy_sprite: AnimatedSprite = $CardBodySprite
onready var eyes_sprite: AnimatedSprite = $CardEyesSprite
var lap = Globals.lap

# Animation Variables
var blink_interval: float = 2
var blink_timer: Timer = Timer.new()

func _ready() -> void:
	add_child(blink_timer)
	blink_timer.wait_time = blink_interval
	blink_timer.connect("timeout", self, "_blink")
	blink_timer.start()

func _determine_level():
	if lap == 1:
		enemy_sprite.animation = "Jack"
		eyes_sprite.animation = "Jack"
	elif lap == 2:
		enemy_sprite.animation = "Queen"
		eyes_sprite.animation = "Queen"
	elif lap == 3:
		enemy_sprite.animation = "King"
		eyes_sprite.animation = "King"
	elif lap >= 4:
		enemy_sprite.animation = "Ace"
		eyes_sprite.animation = "Ace"

func _blink():
	eyes_sprite.frame = 0
	eyes_sprite.playing = true
	_spawn_projectile(Globals.player_scene.global_position - global_position, 4)
