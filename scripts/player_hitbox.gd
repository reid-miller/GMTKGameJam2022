extends Area2D

var knockback: float = 1
var damage: float = 1
var lifetime: float = .1
var hitlist: Array = Array()


func _ready() -> void:
	connect("body_entered", self, "_handle_collision")


func _process(delta: float):
	lifetime -= delta
	if lifetime <= 0:
		queue_free()


func _handle_collision(body: Node) -> void:
	if body is Enemy and not hitlist.has(body):
		print("Hit " + str(body))
		body.health -= damage
		var knockback_vector: Vector2 = (body.global_position - global_position).normalized() * knockback
		body.knockback_vector = knockback_vector
		hitlist.append(body)


