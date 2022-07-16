extends player_hitbox

var speed = 500
var velocity: Vector2 = Vector2.ZERO



func _ready() -> void:
	lifetime = 1000
	velocity = velocity.normalized() * speed
	connect("body_entered", self, "_detect_wall")


func _physics_process(delta: float) -> void:
	global_position += (velocity - Globals.player_scene.velocity) * delta
	look_at(position + velocity)


func _detect_wall(area: Node):
	if area is Wall or area is Enemy:
		queue_free()
