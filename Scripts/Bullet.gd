extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed=0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position-=transform.y*speed*delta


func _on_Area2D_area_entered(_area):
	queue_free()

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
