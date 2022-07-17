extends KinematicBody2D

# Scenes
var PlayerHitbox = preload("res://scenes/player_hitbox.tscn")
var PlayerBullet = preload("res://scenes/player_bullet.tscn")

# Nodes
onready var body_sprite: AnimatedSprite = $PlayerBodySprite
onready var eyes_sprite: AnimatedSprite = $PlayerEyesSprite
onready var anim_tree = $AnimationTree
onready var collider = $PlayerCollider
onready var animation_tree = $AnimationTree["parameters/playback"]
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var weapon: Node2D = $Weapon
onready var muzzle: Position2D = $Weapon/WeaponSprite/Muzzle
onready var shoot_position: Position2D = $Weapon/WeaponSprite/ShootDirection
onready var hitboxes: Node2D = $Weapon/Hitboxes
onready var muzzle_flash: AnimatedSprite = $Weapon/WeaponSprite/MuzzleFlash
onready var hurtbox: Area2D = $PlayerHurtBox
onready var ammo_counter: AnimatedSprite = $AmmoCounter

# Stats
const BASE_MOVEMENT_SPEED: float = 90.0
const BASE_HEALTH: float = 6.0
const BASE_ATTACK_SPEED: float = 1.0
const BASE_DAMAGE: float = 1.0
const BASE_KNOCKBACK: float = 250.0
var movement_speed: float = BASE_MOVEMENT_SPEED
var health: float = BASE_HEALTH
var attack_speed: float = BASE_ATTACK_SPEED
var damage: float = BASE_DAMAGE
var knockback: float = BASE_KNOCKBACK
var i_frames: int = 100

# Animation Variables
var blink_interval: float = 6
var ammo_counter_alpha: int = 0

# Functional Variables
var velocity: Vector2 = Vector2.ZERO
var can_move: bool = true
var can_attack: bool = true
var can_shoot: bool = true
var remaining_iframes: int = 0
var ammo: int = 3
var label_alpha = 1.5
# Signals
signal player_died
signal player_damaged

func _ready() -> void:
	
	Globals.player_scene = self

	hurtbox.connect("body_entered", self, "_handle_player_damage")
	hurtbox.connect("area_entered", self, "_handle_player_damage")
	
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
	anim_tree["parameters/swing_1/TimeScale/scale"] = attack_speed
	anim_tree["parameters/swing_2/TimeScale/scale"] = attack_speed
	anim_tree["parameters/shoot/TimeScale/scale"] = attack_speed
	#print("\nDAMGE " + str(damage) + "\nHEALTH " + str(health) + "\nATK SPEED " + str(attack_speed) + "\nMVMNT SPEED " + str(movement_speed) + "\nKNOCKBACK" + str(knockback))
	$CanvasLayer/Label.modulate.a = clamp(label_alpha, 0, 1)
	label_alpha = max(0, label_alpha - .01)
	
func _handle_player_animations():
	
	# Movement
	if velocity != Vector2(0, 0) and body_sprite.animation != "moving":
		body_sprite.animation = "moving"
		body_sprite.frame = 0
	elif velocity == Vector2(0,0) and body_sprite.animation != "idle":
		body_sprite.animation = "idle"
		body_sprite.frame = 0

	# Blinking
	if eyes_sprite.playing and eyes_sprite.frame == 6:
		eyes_sprite.playing = false
		eyes_sprite.frame = 0
	if body_sprite.animation == "idle" and body_sprite.frame == 1:
		eyes_sprite.offset.y = 2
	else:
		eyes_sprite.offset.y = 0

	# Red eyes
	if health <= 1:
		eyes_sprite.modulate = Color("ff4444")
	else:
		eyes_sprite.modulate = Color("ffffff")
		
	# Iframes
	if remaining_iframes > 0:
		remaining_iframes -= 1
		if remaining_iframes % 5 == 0:
			visible = !visible
	else:
		visible = true


func _handle_weapon_animations() -> void:
	
	# Ammo counter
	ammo_counter_alpha = clamp(ammo_counter_alpha - 5, 0, 500)
	ammo_counter.modulate.a = float(ammo_counter_alpha)/255.0
	
	# Idle
	if animation_tree.get_current_node() == "weapon_bob":
		weapon.scale.y = 1
		weapon.scale.x = 1
		weapon.look_at(get_viewport().get_mouse_position())
		animation_player.playback_speed = 1
		if get_viewport().get_mouse_position().x < global_position.x:
			weapon.scale.y = -1
	# Attacking
	if can_attack and animation_tree.get_current_node() == "weapon_bob" and Input.is_action_pressed("attack"):
		animation_tree.travel("swing_1")
	
	# Shooting
	elif can_shoot and Input.is_action_pressed("shoot") and animation_tree.get_current_node() == "weapon_bob" and ammo > 0:
		animation_tree.travel("shoot")
	elif Input.is_action_pressed("shoot") and ammo <= 0:
		_update_ammo_counter(0)
	if animation_tree.get_current_node() == "shoot":
		weapon.look_at(get_viewport().get_mouse_position())
		if get_viewport().get_mouse_position().x < global_position.x:
				weapon.scale.y = -1
	
	# Muzzle Flash
	if muzzle_flash.frame >= 5:
		muzzle_flash.playing = false
		muzzle_flash.frame = 0


func _update_ammo_counter(amount: int):
	ammo = clamp(ammo + amount, 0, 3)
	ammo_counter.frame = ammo
	ammo_counter_alpha = 500


func _check_for_combo():
	if Input.is_action_pressed("attack"):
		weapon.look_at(get_viewport().get_mouse_position())
		if animation_tree.get_current_node() == "swing_1":
			animation_tree.travel("swing_2")
		elif animation_tree.get_current_node() == "swing_2":
			animation_tree.travel("swing_1")


func _handle_player_damage(area: Node):
	if (area is Enemy or area is Spike or area is EnemyProjectile) and remaining_iframes <= 0:
		emit_signal("player_damaged")
		health -= 1
		if health <= 0:
			emit_signal("player_died")
		else:
			remaining_iframes = i_frames


func _blink():
	eyes_sprite.playing = true


func green_tile_effect():
	health = 6
	_update_ammo_counter(3)
	Globals.dice_roller.floor_cleared()
	animation_player.play("green")
	show_banner("HP AND AMMO RESTORED!", Color.green)


func _move() -> void:
	
	# Check if can move
	if !can_move:
		return
	
	# Gather Input
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	
	# Move
	velocity = input_vector.normalized() * movement_speed
	move_and_slide(velocity)


func _spawn_hitbox():
	var hitbox = PlayerHitbox.instance()
	hitbox.damage = damage
	hitbox.knockback = knockback
	hitboxes.add_child(hitbox)


func show_banner(text: String, color: Color):
	$CanvasLayer/Label.text = text
	$CanvasLayer/Label.modulate = color
	label_alpha = 2.0

func _spawn_bullet():
	var bullet = PlayerBullet.instance()
	muzzle_flash.frame = 1
	muzzle_flash.playing = true
	bullet.global_position = to_local(muzzle.global_position)
	bullet.damage = damage
	bullet.knockback = knockback
	bullet.velocity = get_viewport().get_mouse_position() - position
	add_child(bullet)
	_update_ammo_counter(-1)
	
