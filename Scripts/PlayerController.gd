extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var body=$KinematicBody2D
export var  speed=0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	var motion=Vector2()
	if(Input.is_action_pressed("Right")):
		motion+=Vector2(1,0)
	
	if(Input.is_action_pressed("Left")):
		motion+=Vector2(-1,0)
	
	if(Input.is_action_pressed("Up")):
		motion+=Vector2(0,-1)
	
	if(Input.is_action_pressed("Down")):
		motion+=Vector2(0,1)
	var velocity=motion.normalized()*speed
	body.move_and_slide(velocity)
	pass
