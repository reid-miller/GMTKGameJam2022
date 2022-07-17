extends Enemy

onready var enemy_sprite: AnimatedSprite = $BodySprite
var lap = Globals.lap

# Animation Variables
var fire_interval: float = 3
var fire_timer: Timer = Timer.new()

func _ready() -> void:
	add_child(fire_timer)
	fire_timer.wait_time = fire_interval
	fire_timer.connect("timeout", self, "_fire")
	fire_timer.start()
	_determine_level()

func _determine_level():
	if lap == 1:
		enemy_sprite.animation = "white"
	elif lap == 2:
		enemy_sprite.animation = "green"
	elif lap == 3:
		enemy_sprite.animation = "red"
	elif lap >= 4:
		enemy_sprite.animation = "black"

func _fire():
	var fire_type = randi() % 2
	if fire_type == 0:
		_spawn_projectile(Vector2(1,0), 4)
		_spawn_projectile(Vector2(-1,0), 4)
		_spawn_projectile(Vector2(0,1), 4)
		_spawn_projectile(Vector2(0,-1), 4)
	if fire_type == 1:
		_spawn_projectile(Vector2(1,-1), 4)
		_spawn_projectile(Vector2(1,1), 4)
		_spawn_projectile(Vector2(-1,1), 4)
		_spawn_projectile(Vector2(-1,-1), 4)
