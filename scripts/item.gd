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
			
	if go_to_player and !shrink:
		var new_speed = velocity.length() + acceleration
		velocity = -(global_position - Globals.player_scene.global_position).normalized() * new_speed
		global_position += velocity
		if global_position.distance_to(Globals.player_scene.global_position) <= velocity.length():
			shrink = true
	elif shrink:
		global_position = Globals.player_scene.global_position
		scale -= Vector2(0.1, 0.1)
		if scale.x <= 0:
			_give_stats()
			Globals.dice_roller.floor_cleared()
			queue_free()
		
func _check_trigger(area: Node):
	if area is player_hitbox:
		triggered = true
		$AnimationPlayer.play("hit")
		
func _give_stats():
	match sprite.frame:
		0:
			Globals.player_scene.health = 6
		1:
			Globals.player_scene.attack_speed += .25
		2:
			Globals.player_scene.damage += 1
		3:
			Globals.player_scene.movement_speed += Globals.player_scene.BASE_MOVEMENT_SPEED * .2
		4:
			Globals.player_scene.knockback += Globals.player_scene.BASE_KNOCKBACK * .2
		5:
			Globals.player_scene.i_frames += 50
