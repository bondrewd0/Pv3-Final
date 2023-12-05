extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buffNode= preload("res://Scenes/Buff.tscn")
var enemyScene=preload("res://Scenes/Enemy.tscn")
var positions=[
Vector2(50,40),
Vector2(150,40),
Vector2(250,40),
Vector2(350,40),
Vector2(450,40),
Vector2(550,40)
]
var posSelector=0
onready var viewportSize=get_viewport().get_size_override()
onready var buffTimer=$Timers/BuffSpawner
onready var waveTimer=$Timers/WaveSpawner
# Called when the node enters the scene tree for the first time.
func _ready():
	

	pass

func _on_BuffSpawner_timeout():
	_spawn_Buff()

func _spawn_Buff():
	var buffInstance=buffNode.instance()
	add_child(buffInstance)
	buffInstance.global_position=_generate_Random_Pos()
	buffTimer.start(15)

func _generate_Random_Pos():
	var posY=rand_range(10,50)
	var posX=rand_range(50,viewportSize.x-50)
	return  Vector2(posX,posY)




func _on_WaveSpawner_timeout():
	posSelector=round(rand_range(-1,5))
	_spawn_Enemies()
	waveTimer.start(10)

func _spawn_Enemies():
	var enemyIns=enemyScene.instance()
	enemyIns.attackType=round(rand_range(-1,1))
	enemyIns.position=positions[posSelector]
	enemyIns.fireRate=0.5
	add_child(enemyIns)
