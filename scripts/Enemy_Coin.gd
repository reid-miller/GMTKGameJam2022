extends Enemy

onready var front_sprite: AnimatedSprite = $BodySprite
onready var ass_sprite: AnimatedSprite = $AssSprite
var lap = Globals.lap
var dashing: bool = false
# Animation Variables
var dash_interval: float = 5
var dash_duration: float = 2
var dash_timer: Timer = Timer.new()
var dash_end_timer: Timer = Timer.new()

func _ready() -> void:
	add_child(dash_timer)
	dash_timer.wait_time = dash_interval
	dash_timer.connect("timeout", self, "_dash")
	dash_timer.one_shot = true
	dash_timer.start()
	add_child(dash_end_timer)
	dash_end_timer.one_shot = true
	dash_end_timer.connect("timeout", self, "_end_dash")
	_determine_level()
	speed = 10 + (lap)

func _physics_process(delta: float) -> void:
	if global_position.y - Globals.player_scene.global_position.y < -10:
		front_sprite.visible = true
		ass_sprite.visible = false
	elif global_position.y - Globals.player_scene.global_position.y > 10:
		front_sprite.visible = false
		ass_sprite.visible = true


	# Dash
	if dashing:
		rotation_degrees += speed * sign(velocity.x)
	else:
		rotation_degrees = 0
	
	# moving
	velocity = (Globals.player_scene.global_position - global_position).normalized() * speed
	move_and_slide(velocity)

func _determine_level():
	if lap == 1:
		front_sprite.animation = "penny"
		ass_sprite.animation = "penny"
	elif lap == 2:
		front_sprite.animation = "nickel"
		ass_sprite.animation = "nickel"
	elif lap == 3:
		front_sprite.animation = "dime"
		ass_sprite.animation = "dime"
	elif lap >= 4:
		front_sprite.animation = "quarter"
		ass_sprite.animation = "quarter"

func _dash():
	dashing = true
	speed = speed * 5
	dash_end_timer.start()
	
func _end_dash():
	rotation_degrees = 0
	dashing = false
	speed = speed / 5
	dash_timer.start()
