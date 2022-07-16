extends player_hitbox

var speed = 500
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	lifetime = 1000
	velocity = velocity.normalized() * speed

func _physics_process(delta: float) -> void:
	global_position += velocity * delta
