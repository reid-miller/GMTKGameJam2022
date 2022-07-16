class_name Enemy
extends KinematicBody2D


# Declare member variables here. Examples:
var health = 2
onready var obj = get_parent().get_node("Player")

var speed = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	pass
	var dir = (obj.global_position - global_position).normalized()
	move_and_collide(dir * speed * delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
