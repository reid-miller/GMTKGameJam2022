extends Enemy

onready var enemy_sprite: AnimatedSprite = $CardBodySprite
onready var eyes_sprite: AnimatedSprite = $CardEyesSprite

# Animation Variables
var blink_interval: float = 6
var start_blink: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#enemy_sprite.playing = true
	
	# Setup blink timer
	var blink_timer: Timer = Timer.new()
	add_child(blink_timer)
	blink_timer.wait_time = blink_interval
	blink_timer.connect("timeout", self, "_blink")
	blink_timer.start()
	print(enemy_sprite.frames.get_animation_names())
	
func _physics_process(delta: float) -> void:
	_handle_animations()

func _handle_animations():
	# Blinking
	if eyes_sprite.playing and eyes_sprite.frame == 2:
		eyes_sprite.playing = false
		eyes_sprite.frame = 0

func _blink():
	eyes_sprite.playing = true
