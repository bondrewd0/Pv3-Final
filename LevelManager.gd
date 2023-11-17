extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buffNode= preload("res://Buff.tscn")
onready var viewportSize=get_viewport().get_size_override()
onready var buffTimer=$BuffSpawner
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_BuffSpawner_timeout():
	_spawn_Buff()

func _spawn_Buff():
	var buffInstance=buffNode.instance()
	add_child(buffInstance)
	buffInstance.global_position=_generate_Random_Pos()
	buffTimer.start(10)

func _generate_Random_Pos():
	var posY=rand_range(50,viewportSize.y-50)
	var posX=rand_range(50,viewportSize.x-50)
	return  Vector2(posX,posY)
