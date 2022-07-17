extends KinematicBody2D

var speed = 500
var rot_speed = 10
var drop_rot_speed = 5
var drop_speed = 200
var velocity = Vector2()
var dice_num = 0

func _ready():
	pass

func start(dir, num):
	$Timer.start()
	$thanos_snap_die.start()
	dice_num = num
	speed = 500
	#rotation = dir
	velocity = dir * speed 
	#Vector2(speed, 0).rotated(rotation)


func _physics_process(delta):
	rotation += delta * clamp(0, rot_speed, 20)
	rot_speed -= delta * drop_rot_speed
	speed -= drop_speed * delta
	var collision = move_and_collide(velocity.normalized() * clamp(0, speed, 500) * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Timer_timeout():
	$AnimatedSprite.frame = dice_num
	$move_piece.start()
	


func _on_thanos_snap_die_timeout():
		queue_free()


func _on_move_piece_timeout():
	get_tree().call_group("player_chip", "move_pos", dice_num)
