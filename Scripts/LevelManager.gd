extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buffNode= preload("res://Scenes/Buff.tscn")
var enemyV1=preload("res://Scenes/Enemies/NormalEnemy.tscn")
var enemyV2=preload("res://Scenes/Enemies/SniperEnemy.tscn")
var enemyV3=preload("res://Scenes/Enemies/EnemyMultiShoot.tscn")
var enemyV4=preload("res://Scenes/Enemies/SplashEnemy.tscn")
var enemyV5=preload("res://Scenes/Enemies/BossEnemy.tscn")
var positions=[
Vector2(580,20),
Vector2(20,20),
Vector2(580,340),
Vector2(20,340),
Vector2(100,700),
Vector2(500,700),
Vector2(300,20)
]
var endPos=[
Vector2(-100,360),
Vector2(700,360),
Vector2(-100,340),
Vector2(700,340),
Vector2(100,-100),
Vector2(500,-100),
Vector2(300,100)
]
var waveMov=0
var enemyNumber=0
var currSpawnNum=0
var nextWaveTime=0
var enemyFireRate=0.0
var enemySpeed=0
var waveInfo=[
[0,0,4,6,0.5,7],
[4,6,1,40,0.2,5]
]
var enemyType=0
var waveNum=0
var enemyIns
onready var viewportSize=get_viewport().get_size_override()
onready var buffTimer=$Timers/BuffSpawner
onready var waveTimer=$Timers/WaveSpawner
# Called when the node enters the scene tree for the first time.
func _ready():
	_wave_Manager(waveNum)
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
	_spawn_Enemies()
	currSpawnNum+=1
	if currSpawnNum<enemyNumber:
		waveTimer.start(2)
	else:
		waveTimer.start(nextWaveTime)
		waveNum+=1
		if waveNum==waveInfo.size():
			waveNum=0
		_wave_Manager(waveNum)
		currSpawnNum=0

func _spawn_Enemies():
	match enemyType:
		0:
			enemyIns=enemyV1.instance()
		1:
			enemyIns=enemyV2.instance()
		2:
			enemyIns=enemyV3.instance()
		3:
			enemyIns=enemyV4.instance()
		4:
			enemyIns=enemyV5.instance()
			enemyIns.hitpoints=40
			
	enemyIns.position=positions[waveMov]
	enemyIns.finalPos=endPos[waveMov]
	enemyIns.fireRate=enemyFireRate
	enemyIns.movementTime=enemySpeed
	add_child(enemyIns)


func _wave_Manager(waveindex):
	enemyType=waveInfo[waveindex][0]
	waveMov=waveInfo[waveindex][1]
	enemyNumber=waveInfo[waveindex][2]
	nextWaveTime=waveInfo[waveindex][3]
	enemyFireRate=waveInfo[waveindex][4]
	enemySpeed=waveInfo[waveindex][5]
	
