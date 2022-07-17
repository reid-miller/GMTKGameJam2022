extends Enemy

onready var enemy_sprite: AnimatedSprite = $EnemyBodySprite
var lap = Globals.lap
var death_interval: float = 1
var death_timer: Timer
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
	_handle_death()
	
func _determine_level():
	if lap == 1:
		enemy_sprite.animation = "White"
	elif lap == 2:
		enemy_sprite.animation = "Red"
	elif lap == 3:
		enemy_sprite.animation = "Green"
	elif lap >= 4:
		enemy_sprite.animation = "Blue"

func _handle_death():	
	if health <= 0:
		enemy_sprite.modulate = Color(1,0,0)
		enemy_sprite.stop()
		enemy_sprite.flip_v = true
		if !startTime:
			death_timer.start()
			startTime = true

func _death():
	queue_free()

