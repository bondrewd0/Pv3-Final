extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _on_Area2D_area_entered(_area):
	queue_free()


