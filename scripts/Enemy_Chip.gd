extends Enemy

onready var enemy_sprite: AnimatedSprite = $EnemyBodySprite

var death_interval: float = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_sprite.playing = true
	
func _physics_process(delta: float) -> void:
	_handle_death()
	
func _handle_death():
	var death_timer: Timer = Timer.new()
	add_child(death_timer)
	death_timer.wait_time = death_interval
	death_timer.connect("timeout", self, "_death")
	
	if health <= 0:
		enemy_sprite.modulate = Color(1,0,0)
		enemy_sprite.stop()
		enemy_sprite.flip_v = true
		death_timer.start()

func _death():
	queue_free()

