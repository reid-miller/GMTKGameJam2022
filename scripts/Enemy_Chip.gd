extends Enemy

onready var enemy_sprite: AnimatedSprite = $EnemyBodySprite

var gun_interval: float = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_sprite.playing = true
	
	# Setup gun timer
	var gun_timer: Timer = Timer.new()
	add_child(gun_timer)
	gun_timer.wait_time = gun_interval
	gun_timer.connect("timeout", self, "_shoot")
	gun_timer.start()
	
func _shoot():
	print("Bang")
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass	
