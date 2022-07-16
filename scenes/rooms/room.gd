extends Node2D


# Declare member variables here. Examples:
var ZOOM_SPEED = .5
var zoom = false
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if zoom and scale.x < 1:
		scale.x += ZOOM_SPEED * delta
		scale.y += ZOOM_SPEED * delta
	elif !zoom and scale.x > .6:
		scale.x -= ZOOM_SPEED * delta
		scale.y -= ZOOM_SPEED * delta
		
		
		
	if Input.is_action_just_released("ui_accept"):
		zoom = !zoom
		print_debug(zoom)
