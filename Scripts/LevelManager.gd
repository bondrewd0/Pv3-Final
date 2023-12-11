extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buffNode= preload("res://Scenes/Buff.tscn")
var enemyV1=preload("res://Scenes/Enemies/NormalEnemy.tscn")
var enemyV2=preload("res://Scenes/Enemies/SniperEnemy.tscn")
var enemyV3=preload("res://Scenes/Enemies/EnemyMultiShoot.tscn")
var enemyV4=preload("res://Scenes/Enemies/SplashEnemy.tscn")
var positions=[
Vector2(580,20),
Vector2(20,20),
Vector2(580,340),
Vector2(20,340),
Vector2(100,700),
Vector2(500,700)
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


func _process(_delta):
#	if Input.is_action_pressed("Shoot"):
#		print(get_viewport().get_mouse_position())
	pass

func _on_WaveSpawner_timeout():
	posSelector=int(rand_range(-1,6))
	_spawn_Enemies()
	waveTimer.start(10)

func _spawn_Enemies():

	var enemyIns=enemyV4.instance()
	enemyIns.position=Vector2(50,50)
	enemyIns.fireRate=0.2
	enemyIns.position=positions[posSelector]
	match(posSelector):
		0:
			enemyIns.finalPos=Vector2(-100,360)
		1:
			enemyIns.finalPos=Vector2(700,360)
		2:
			enemyIns.finalPos=Vector2(-100,340)
		3:
			enemyIns.finalPos=Vector2(700,340)
		4:
			enemyIns.finalPos=Vector2(100,-100)
		5:
			enemyIns.finalPos=Vector2(500,-100)
	enemyIns.movementTime=9
	add_child(enemyIns)
