extends Enemy

onready var enemy_sprite: AnimatedSprite = $CardBodySprite
onready var eyes_sprite: AnimatedSprite = $CardEyesSprite
var lap = Globals.lap

# Animation Variables
var blink_interval: float = 6
var start_blink: bool = false
var death_interval = 1
var death_timer: Timer
var startTime: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_determine_level()
	if dir != Vector2.ZERO:
		enemy_sprite.playing = true
		
	# Setup blink timer
	var blink_timer: Timer = Timer.new()
	add_child(blink_timer)
	blink_timer.wait_time = blink_interval
	blink_timer.connect("timeout", self, "_blink")
	blink_timer.start()
	
	death_timer = Timer.new()
	add_child(death_timer)
	death_timer.wait_time = death_interval
	death_timer.connect("timeout", self, "_death")
	
	
func _physics_process(delta: float) -> void:
	_handle_animations()
	_handle_death()
	
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
	
func _handle_death():	
	if health <= 0:
		enemy_sprite.modulate = Color(1,0,0)
		eyes_sprite.modulate = Color(1,0,0)
		eyes_sprite.frame = 2
		enemy_sprite.stop()
		enemy_sprite.flip_v = true
		eyes_sprite.flip_v = true
		if !startTime:
			death_timer.start()
			startTime = true

func _death():
	queue_free()


func _handle_animations():
	# Blinking
	if eyes_sprite.playing and eyes_sprite.frame == 2:
		eyes_sprite.playing = false
		eyes_sprite.frame = 0

func _blink():
	eyes_sprite.playing = true
