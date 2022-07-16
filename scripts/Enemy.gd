class_name Enemy
extends KinematicBody2D

onready var player = Globals.player_scene
# Declare member variables here. Examples:
var health = 2
var knockback_vector = Vector2.ZERO
var speed = 10
var knockback_decay = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var dir = (player.global_position - global_position).normalized()
	move_and_collide((dir * speed * delta) + knockback_vector)
	
	# Decay Knockback
	if knockback_vector != Vector2.ZERO:
		if knockback_vector.length() < knockback_decay:
			knockback_vector = Vector2.ZERO
		else:
			knockback_vector -= knockback_vector.normalized() * knockback_decay

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
