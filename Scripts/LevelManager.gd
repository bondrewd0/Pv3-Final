extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buffNode= preload("res://Scenes/Buff.tscn")
var enemyV1=preload("res://Scenes/Enemies/NormalEnemy.tscn")#Type 0
var enemyV2=preload("res://Scenes/Enemies/SniperEnemy.tscn")#Type 1
var enemyV3=preload("res://Scenes/Enemies/EnemyMultiShoot.tscn")#Type 2
var enemyV4=preload("res://Scenes/Enemies/SplashEnemy.tscn")#Type 3
var enemyV5=preload("res://Scenes/Enemies/BossEnemy.tscn")#Type 4
var pauseRef=preload("res://Scenes/PauseMenu.tscn")
var deathRef=preload("res://Scenes/DeathScreen.tscn")
var victoryRef=preload("res://Scenes/VictoryScreen.tscn")
var positions=[
Vector2(1160,-20),
Vector2(-20,-20),
Vector2(1160,360),
Vector2(-20,360),
Vector2(290,740),
Vector2(870,740),
Vector2(580,-20)
]
var endPos=[
Vector2(-100,320),
Vector2(1240,320),
Vector2(-100,340),
Vector2(1240,340),
Vector2(290,-100),
Vector2(870,-100),
Vector2(580,100)
]
var waveMov=0
var enemyNumber=0
var currSpawnNum=0
var nextWaveTime=0
var enemyFireRate=0.0
var enemySpeed=0
var waveInfo=[
#Type,Positions,amount,time to next wave
#fire rate, movement speed
[0,0,5,0.4,0.5,6],
[0,1,5,5,0.5,6],
[1,4,3,0.5,0.5,6],
[1,5,3,5,0.5,6],
[2,0,2,0.5,0.5,6],
[2,1,2,5,0.5,6],
[3,2,1,0.5,0.5,6],
[3,3,1,5,0.5,6],
[4,6,1,30,0.2,5]
]
var enemyType=0
var waveNum=0
var enemyIns
onready var viewportSize=get_viewport().get_size_override()
onready var buffTimer=$Timers/BuffSpawner
onready var waveTimer=$Timers/WaveSpawner
onready var scoreRef=$CanvasLayer/PointsText
onready var bgMusic=$SoundEffects/BackgroundMusic
var playerPoints=0
var gameOn=false
var onBoss=false
# Called when the node enters the scene tree for the first time.
func _ready():
	_wave_Manager(waveNum)
	scoreRef.text=str(playerPoints)
	gameOn=true
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
	if gameOn:
		_spawn_Enemies()
		currSpawnNum+=1
		if currSpawnNum<enemyNumber:
			waveTimer.start(0.5)
		else:
			waveTimer.start(nextWaveTime)
			waveNum+=1
			if waveNum==waveInfo.size():
				waveNum=0
			_wave_Manager(waveNum)
			currSpawnNum=0
	pass

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
			_boss_Wave()
			onBoss=true
	enemyIns.position=positions[waveMov]
	enemyIns.finalPos=endPos[waveMov]
	enemyIns.fireRate=enemyFireRate
	enemyIns.movementTime=enemySpeed
	enemyIns.connect("pointsUp",self,"_score_Up")
	add_child(enemyIns)

func _wave_Manager(waveindex):
	enemyType=waveInfo[waveindex][0]
	waveMov=waveInfo[waveindex][1]
	enemyNumber=waveInfo[waveindex][2]
	nextWaveTime=waveInfo[waveindex][3]
	enemyFireRate=waveInfo[waveindex][4]
	enemySpeed=waveInfo[waveindex][5]

func _score_Up(points):
	$SoundEffects/EnemyDeath.play()
	playerPoints+=points
	scoreRef.text=str(playerPoints)
	if points==1000:
		playerPoints+=$Player.life*10
		var victoryScreen=victoryRef.instance()
		victoryScreen.pPoints=str(playerPoints)
		add_child(victoryScreen)
		get_tree().paused=true

func _process(_delta):
	if !bgMusic.playing && gameOn && !onBoss:
		bgMusic.play()
	if !gameOn:
		bgMusic.volume_db-=0.35
	if Input.is_action_pressed("Pause"):
		var pausemode=pauseRef.instance()
		add_child(pausemode)
		get_tree().paused=true


func _on_Player_playerDead():
	gameOn=false
	var timer:Timer=Timer.new()
	add_child(timer)
	timer.one_shot=true
	timer.autostart=true
	timer.wait_time=1.3
	timer.connect("timeout",self,"_disable_Player")
	timer.start()
	

func _disable_Player():
	var gameOverScreen=deathRef.instance()
	get_node("Player").queue_free()
	gameOverScreen.pPoints=str(playerPoints)
	add_child(gameOverScreen)
	get_tree().paused=true

func _boss_Wave():
	bgMusic.stop()
	$SoundEffects/BossMusic.play()
