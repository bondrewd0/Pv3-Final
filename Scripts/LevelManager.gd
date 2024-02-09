extends Node

#Las variables y funciones utilizadas 
#son similares en ambos niveles

#Referencias a nodos externos a utilizar
var buffNode= preload("res://Scenes/Buff.tscn")
var enemyV1=preload("res://Scenes/Enemies/NormalEnemy.tscn")#Type 0
var enemyV2=preload("res://Scenes/Enemies/SniperEnemy.tscn")#Type 1
var enemyV3=preload("res://Scenes/Enemies/EnemyMultiShoot.tscn")#Type 2
var enemyV4=preload("res://Scenes/Enemies/SplashEnemy.tscn")#Type 3
var enemyV5=preload("res://Scenes/Enemies/BossEnemy.tscn")#Type 4
var pauseRef=preload("res://Scenes/PauseMenu.tscn")
var deathRef=preload("res://Scenes/DeathScreen.tscn")
var victoryRef=preload("res://Scenes/VictoryScreen.tscn")
#Direccion del siguiente nivel
var nexlvlRef="res://Scenes/Nivel2.tscn"
#Posiciones iniciales de enemigos
var positions=[
Vector2(1160,-20),
Vector2(-20,-20),
Vector2(1160,200),
Vector2(-20,200),
Vector2(290,740),
Vector2(870,740),
Vector2(580,-20)
]
#Posiciones finales de enemigos
var endPos=[
Vector2(-100,320),
Vector2(1240,320),
Vector2(-100,340),
Vector2(1240,340),
Vector2(290,-100),
Vector2(870,-100),
Vector2(580,100)
]
#Varaibles de caracteristicas de oleadas 
var waveMov=0
var enemyNumber=0
var currSpawnNum=0
var nextWaveTime=0
var enemyFireRate=0.0
var enemySpeed=0
var enemyType=0
var waveNum=0
var enemyIns
var waveInfo=[
#Administrador de oleadas enemigas
#Type  #Pos #amount #next wave  #firerate  #speed
[    0,    0,    5,    0.4,    0.5,    6],
[    0,    1,    5,    5,    0.5,    6],
[    1,    4,    2,    0.5,    0.5,    6],
[    1,    5,    2,    5,    0.5,    6],
[    2,    0,    2,    0.5,    0.5,    6],
[    2,    1,    2,    5,    0.5,    6],
[    3,    2,    2,    0.5,    0.5,    6],
[    3,    3,    2,    5,    0.5,    6],
[    4,    6,    1,    3,    0.2,    5],#Final Boss
[    0,    2,    2,    0.4,    0.8,    10],
[    0,    3,    2,    2,    0.4,    10],
[    1,    0,    1,    0.2,    0.8,    5],
[    1,    1,    1,    15,    0.8,    5]
]

#tamaño de pantalla para generacion de buffos
onready var viewportSize=get_viewport().get_size_override()
#Referencias a nodos internos para usar
onready var buffTimer=$Timers/BuffSpawner
onready var waveTimer=$Timers/WaveSpawner
onready var scoreRef=$CanvasLayer/PointsText
onready var bgMusic=$SoundEffects/BackgroundMusic
#puntos de jugador 
var playerPoints=0
#Estado de juego
var gameOn=false
#Estado del jefe de nivel
var onBoss=false

#Inicio juego, puntos y llamo a la funcion para administar las oleadas de enemigos
func _ready():
	_wave_Manager(waveNum) #Se cargan los valores a utilizar segun el administrador de oleada
	scoreRef.text=str(playerPoints)
	gameOn=true
	pass

#Timer para la generacion de buffos
func _on_BuffSpawner_timeout():
	_spawn_Buff()

#Se genera un buff en una posicion aleatoria
func _spawn_Buff():
	var buffInstance=buffNode.instance()
	add_child(buffInstance)
	buffInstance.global_position=_generate_Random_Pos()
	buffTimer.start(15)

#Se genera una posicion aleatoria dentro de la pantalla
func _generate_Random_Pos():
	var posY=rand_range(10,50)
	var posX=rand_range(50,viewportSize.x-50)
	return  Vector2(posX,posY)

#Administrador de la generacion de enemigos
func _on_WaveSpawner_timeout():
	if gameOn:  #cuando empieza el juego
		_spawn_Enemies() #Se genera enemigo
		currSpawnNum+=1 #Contador de enemigos en pantalla
		if currSpawnNum<enemyNumber: #Si los enemigos generados son menoras a los que 
			waveTimer.start(0.5) #Se genera otro despues de unos segundos para que no se encimen
		else:#Cuando aparezcan todos los enemigos que deben aparecer
			waveTimer.start(nextWaveTime) #Se espera a generar la siguiente oleada
			waveNum+=1 #index para la matriz administradora
			if waveNum==waveInfo.size(): #Si la matriz se completa se reinicia la oleada
				waveNum=0
			_wave_Manager(waveNum)
			currSpawnNum=0
	pass

#Generacion de enemigos
func _spawn_Enemies():
	match enemyType:  #segun el tipo
		0:
			enemyIns=enemyV1.instance()
		1:
			enemyIns=enemyV2.instance()
		2:
			enemyIns=enemyV3.instance()
		3:
			enemyIns=enemyV4.instance()
		4: #Jefe de nivel
			enemyIns=enemyV5.instance()
			_boss_Wave() #Efectos de musica
			onBoss=true  #Se entra en estado de jefe
#Asigna distintas caracteristicas a la instancia del enemigo actual
	enemyIns.position=positions[waveMov]
	enemyIns.finalPos=endPos[waveMov]
	enemyIns.fireRate=enemyFireRate
	enemyIns.movementTime=enemySpeed
	enemyIns.connect("pointsUp",self,"_score_Up") #conecto la señal de muerte a la funcion de puntaje
	add_child(enemyIns) #Añado el enemigo en pantalla

#Iniciasion y actualizacion de las variables segun el administrador
func _wave_Manager(waveindex):
	enemyType=waveInfo[waveindex][0]
	waveMov=waveInfo[waveindex][1]
	enemyNumber=waveInfo[waveindex][2]
	nextWaveTime=waveInfo[waveindex][3]
	enemyFireRate=waveInfo[waveindex][4]
	enemySpeed=waveInfo[waveindex][5]

#Aumento de puntos y actualizacion de texto en pantalla
func _score_Up(points):
	$SoundEffects/EnemyDeath.play() #efecto de muerte de enemigos
	playerPoints+=points #aumenta el puntaje segun los puntos recibidos del enemigo
	scoreRef.text=str(playerPoints) #Actualizo el texto en pantalla
	if points==1000: #Si el jefe es derrotado
		playerPoints+=$Player.life*100 #Se a;aden puntos segun la vida restante del jugador
		var victoryScreen=victoryRef.instance() #Se genera instancia de pantalla de victoria
		victoryScreen.pPoints=str(playerPoints) #Se envian los puntos para utilizar
		victoryScreen.lvl=nexlvlRef #Se envia el nombre del siguiente nivel
		add_child(victoryScreen) #Se añade la pantalla
		get_tree().paused=true #Se pausa el juego principal

#Control de sonido
func _process(_delta):
#Si deja de sonar la musica del nivel y no aparecio el jefe
	if !bgMusic.playing && gameOn && !onBoss:
		bgMusic.play() #Se vuelve a reproducir la musica
	if !gameOn: #cuando termina el nivel
		bgMusic.volume_db-=0.35 #Se reduce el sonido
	if Input.is_action_pressed("Pause"): #si se pulsa escape
		var pausemode=pauseRef.instance() #Se añade la pantalla de pausa
		add_child(pausemode)
		get_tree().paused=true #Se pausa el juego principal

#Cuando muere el jugador
func _on_Player_playerDead():
	gameOn=false #Se deja de jugar
	var timer:Timer=Timer.new() #Timer para deshabilitar al jugador despues de la animacion de muerte
	add_child(timer)
	timer.one_shot=true
	timer.autostart=true
	timer.wait_time=1.3
	timer.connect("timeout",self,"_disable_Player")
	timer.start()

#Desactivar jugador y añadir derrota
func _disable_Player():
	var gameOverScreen=deathRef.instance() #Se añade pantalla de derrota
	get_node("Player").queue_free() #Se elimina al jugador
	gameOverScreen.pPoints=str(playerPoints) #Se eniva el puntaje actual 
	add_child(gameOverScreen)
	get_tree().paused=true #Se pausa el juego principal

#efecto de musica jefe
func _boss_Wave():
#Pausa musica
	bgMusic.stop()
	$SoundEffects/BossMusic.play() #why do i hear boss music?
