class_name EnemyProjectile
extends Node2D

onready var area: Area2D = $Area2D
var speed = 10
var direction = Vector2(1, 0)
var lifetime = 1000


func _ready() -> void:
	area.connect("area_entered", self, "damage_player")
	area.connect("body_entered", self, "damage_player")

func _physics_process(delta: float) -> void:
	position += direction * speed
	look_at(position + direction)
	lifetime -= 1
	if lifetime <= 0:
		queue_free()

func damage_player(area: Node):
	if area.get_parent() == Globals.player_scene:
		Globals.player_scene._handle_player_damage(self)
		queue_free()
	if area is Wall:
		queue_free()
