extends Control


# Declare member variables here. Examples:
var past_health
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	past_health = Globals.player_scene.health
	pass # Replace with function body.



func _process(delta):
	$RichTextLabel.text = "Loops: " + str(Globals.lap)
	$AnimatedSprite.frame = Globals.player_scene.health
	if past_health != Globals.player_scene.health:
		past_health = Globals.player_scene.health
		$AnimatedSprite/AnimationPlayer.play()

