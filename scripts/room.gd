extends Node2D


# Declare member variables here. Examples:
var ZOOM_SPEED = .5
var zoom = false
var zoom_amount = 1

func _ready():
	
	pass 

func _process(delta):
	if zoom_amount > 1:
		zoom_amount = 1
	if zoom_amount < 0:
		zoom_amount = 0
	if zoom and scale.x < 1:
		scale.x = lerp(.6, 1, zoom_amount)
		scale.y = lerp(.6, 1, zoom_amount)
		zoom_amount += delta
	elif  !zoom and scale.x > 0.6:
		scale.x = lerp(1, .6, zoom_amount)
		scale.y = lerp(1, .6, zoom_amount)
		zoom_amount += delta

		
	if Input.is_action_just_released("ui_accept"):
		zoom = !zoom
		zoom_amount = 0


func _on_dice_roller_area_entered(area):
	
	pass # Replace with function body.
