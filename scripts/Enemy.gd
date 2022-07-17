class_name Enemy
extends KinematicBody2D

var projectile_scene = preload("res://scenes/enemy_projectile.tscn")

onready var animator: AnimationPlayer = $AnimationPlayer
onready var player = Globals.player_scene
var health = 3
var speed = 10
var damage = 1
var movement_interval = 1
var movement_duration = 1.5
var moving: bool = false
var dead = false
var velocity: Vector2 = Vector2.ZERO
var knockback_vector = Vector2.ZERO
var knockback_decay = 10
var movement_timer: Timer = Timer.new()
var movement_delay_timer: Timer = Timer.new()

func _ready():
	
	# Determine Power
	var power = Globals.lap
	health = 2 + power
	speed = 40 + (power*5)
	damage = 3 + floor(power/2)
	_determine_sprite(power)
	
	# Setup movement timer
	add_child(movement_delay_timer)
	add_child(movement_timer)
	movement_delay_timer.wait_time = movement_interval
	movement_delay_timer.one_shot = true
	movement_delay_timer.connect("timeout", self, "_start_movement")
	movement_timer.wait_time = movement_duration
	movement_timer.one_shot = true
	movement_timer.connect("timeout", self, "_stop_movement")
	movement_delay_timer.start()
	
	# Increase number of enemies
	Globals.enemies_left += 1
	print_debug("Enemy made, total = " + str(Globals.enemies_left))
	print_debug(self)
	
func _start_movement():
	velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	velocity = velocity.normalized() * speed
	moving = true
	movement_timer.start()
	
	
func _stop_movement():
	velocity = Vector2.ZERO
	moving = false
	movement_delay_timer.start()

func _physics_process(delta):
	
	# Movement & Knockback
	move_and_slide(velocity + knockback_vector)
	if knockback_vector != Vector2.ZERO:
		if knockback_vector.length() < knockback_decay:
			knockback_vector = Vector2.ZERO
		else:
			knockback_vector -= knockback_vector.normalized() * knockback_decay
	
	# Toggle Death
	if health <= 0 and !dead:
		dead = true
		movement_timer.stop()
		movement_delay_timer.stop()
		moving = false
		Globals.player_scene._update_ammo_counter(1)
		Globals.enemies_left -= 1
		animator.play("death")
		if Globals.enemies_left == 0:
			Globals.dice_roller.floor_cleared()

func _spawn_projectile(dir: Vector2, speed: float):
	var new_projectile: EnemyProjectile = projectile_scene.instance()
	new_projectile.direction = dir.normalized()
	new_projectile.speed = speed
	get_parent().add_child(new_projectile)
	new_projectile.global_position = global_position

func _determine_sprite(power):
	pass
	
