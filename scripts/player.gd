 extends KinematicBody2D

# Nodes
onready var body_sprite: AnimatedSprite = $PlayerBodySprite
onready var eyes_sprite: AnimatedSprite = $PlayerEyesSprite
onready var animation_tree = $AnimationTree["parameters/playback"]
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var weapon: Node2D = $Weapon

# Stats
const BASE_MOVEMENT_SPEED: float = 50.0
const BASE_HEALTH: float = 10.0
const BASE_ATTACK_SPEED: float = 10.0
const BASE_DAMAGE: float = 10.0
var movement_speed: float = BASE_MOVEMENT_SPEED
var health: float = BASE_HEALTH
var attack_speed: float = BASE_ATTACK_SPEED
var damage: float = BASE_DAMAGE


# Animation Variables
var blink_interval: float = 6
var start_blink: bool = false


# Functional Variables
var velocity: Vector2 = Vector2.ZERO
var can_move: bool = true
var can_attack: bool = true
var can_shoot: bool = true

func _ready() -> void:
	
	# Setup blink timer
	var blink_timer: Timer = Timer.new()
	add_child(blink_timer)
	blink_timer.wait_time = blink_interval
	blink_timer.connect("timeout", self, "_blink")
	blink_timer.start()

func _physics_process(delta: float) -> void:
	_move()
	_handle_player_animations()
	_handle_weapon_animations()


func _handle_player_animations():
	
	# Movement
	if velocity != Vector2.ZERO:
		body_sprite.playing = true
	else:
		body_sprite.playing = false
		body_sprite.frame = 0

	# Blinking
	if eyes_sprite.playing and eyes_sprite.frame == 6:
		eyes_sprite.playing = false
		eyes_sprite.frame = 0


func _handle_weapon_animations() -> void:

	# Idle
	if animation_tree.get_current_node() == "weapon_bob":
		weapon.scale.y = 1
		weapon.scale.x = 1
		weapon.look_at(get_viewport().get_mouse_position())
		if get_viewport().get_mouse_position().x < global_position.x:
			weapon.scale.y = -1

	# Attacking
	if can_attack and animation_tree.get_current_node() == "weapon_bob" and Input.is_action_pressed("attack"):
			animation_tree.travel("swing_1")
	
	# Shooting
	elif can_shoot and Input.is_action_pressed("shoot") and animation_tree.get_current_node() == "weapon_bob":
		animation_tree.travel("shoot")

func _check_for_combo():
	if Input.is_action_pressed("attack"):
		weapon.look_at(get_viewport().get_mouse_position())
		if animation_tree.get_current_node() == "swing_1":
			animation_tree.travel("swing_2")
		elif animation_tree.get_current_node() == "swing_2":
			animation_tree.travel("swing_1")

func _blink():
	eyes_sprite.playing = true


func _move() -> void:
	
	# Check if can move
	if !can_move:
		return
	
	# Gather Input
	var input_vector: Vector2 = Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	
	# Move
	velocity = input_vector.normalized() * movement_speed
	move_and_slide(velocity)
	
