extends Control


# Declare member variables here. Examples:
var past_health
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	past_health = Globals.player_scene.health
	pass # Replace with function body.



func _process(delta):
	$Label.text = "Loops:\n" + str(Globals.lap)
	$AnimatedSprite.frame = Globals.player_scene.health



func _on_Player_player_damaged():
	$AnimatedSprite/AnimationPlayer.play("spin")
