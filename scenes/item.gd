extends Node2D

onready var sprite: AnimatedSprite = $Sprite
onready var hit_detector: Area2D = $HitDetector

var triggered: bool = false
var go_to_player: bool = false
var shrink: bool = false
var deceleration: float = .01
var velocity: Vector2 = Vector2.ZERO
var acceleration: float = 1

func _ready() -> void:
	hit_detector.connect("area_entered", self, "_check_trigger")

func _physics_process(delta: float) -> void:
	
	if triggered:
		sprite.speed_scale = clamp(sprite.speed_scale - deceleration, 0, 1)
		if sprite.speed_scale == 0:
			go_to_player = true
			
	if go_to_player:
		var new_speed = velocity.length() + acceleration
		velocity = (global_position - Globals.player_scene.global_position).normalized() * new_speed
		global_position += velocity
		if global_position.distance_to(Globals.player_scene.global_position) <= velocity.length():
			shrink = true
		
func _check_trigger(area: Node):
	if area is player_hitbox:
		triggered = true
		
