extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed=0
var dir= Vector2(1,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position+=dir*speed*delta



func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()
