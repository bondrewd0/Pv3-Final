extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buffNode= preload("res://Buff.tscn")
var pos=Vector2(100,300)
# Called when the node enters the scene tree for the first time.
func _ready():
	var buffInstance=buffNode.instance()
	add_child(buffInstance)
	buffInstance.global_position=pos
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
