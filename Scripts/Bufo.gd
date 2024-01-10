extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var fallSpeed=0.0
var player=null
func _on_Area2D_area_entered(_area):
	queue_free()



func _process(_delta):
	if player==null:
		self.position.y+=fallSpeed
		pass
	else:
		self.position=position.move_toward(player.global_position,5)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_PickUpRange_area_entered(area):
	player=area
