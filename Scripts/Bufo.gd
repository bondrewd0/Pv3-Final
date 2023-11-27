extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var fallSpeed=0.0

func _on_Area2D_area_entered(_area):
	queue_free()



func _process(_delta):
	self.position.y+=fallSpeed


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
