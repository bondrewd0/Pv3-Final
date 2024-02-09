extends KinematicBody2D

#Velocidad de movimiento
export var  speed=0.0 
#Referencia a bala a usar
var bulletScene=preload("res://Scenes/Bullet.tscn")
#Valores para limitar le movimiento
var limits=Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
#Freno al disparo
var canShoot=true
#Cadencia de disparo
export var firingCooldown=0.3
#Referencia a nodos internos a usar
onready var timerRef=$FireRate
onready var buffTimerRef=$BuffTimer
onready var colliderRef=$CollisionShape2D
onready var iFrameRef=$DamageCooldown
onready var explotion=$ExplotionAnim
onready var hit=$HurtSound
onready var bulletPos=$Position2D
#Tipo
var type='Player'
#puntos de vida
var life=0
#Daño recibido
export var damage=0
#Señales de cambio de vida
signal player_hit(health_value)
signal playerDead

#Inicio con 100 de vida
func _ready():
	life=100

#Deteccion de inputs y movimiento
func _process(_delta):
	if life!=0:
		var motion=Vector2()
		if(Input.is_action_pressed("Right")):
			motion+=Vector2(1,0)
		if(Input.is_action_pressed("Left")):
			motion+=Vector2(-1,0)
		if(Input.is_action_pressed("Up")):
			motion+=Vector2(0,-1)
		if(Input.is_action_pressed("Down")):
			motion+=Vector2(0,1)
		var velocity=motion.normalized()*speed
		move_and_slide(velocity)
#limita movimiento del jugador a dentro de la pantalla
		position=Vector2(clamp(position.x,20,limits.x-140),clamp(position.y,20,limits.y-20))
		if(Input.is_action_pressed("Shoot")):
			open_fire()
	pass

#Administrador de disparos
func open_fire():
	if(canShoot):#Si se puede disparar
		canShoot=false#Mete freno
		timerRef.start(firingCooldown)#timer para remover el freno
		var bulletInstance=bulletScene.instance()#Crea intancia de bala
		#caracteristicas de bala
		bulletInstance.global_position=bulletPos.global_position
		bulletInstance.dir=Vector2(0,-1)
		bulletInstance.speed=650
		bulletInstance.type='PlayerBullet'
		get_parent().add_child(bulletInstance)#Genera bala
	pass

#Saca el freno
func _on_FireRate_timeout():
	canShoot=!canShoot

#Devuelve cadencia de disparo al valor inicial
func _on_BuffTimer_timeout():
	firingCooldown=0.3

#aumenta la cadencia de disparo temporalmente
func _fireRate_up():
	buffTimerRef.start(5)
	firingCooldown=0.05


#Deteccion de colsion con buff
func _on_Area2D_area_entered(_area):
	_fireRate_up()


#Consecuancia de resibir daño
func  _taking_Fire():
	life-=damage #Reduce vida
	hit.play() #Efecto de sonido
	emit_signal("player_hit",life) #Señal de cambio de vida para el nivel
	colliderRef.disabled=true #Tiempo de inmunidad
	iFrameRef.start()#Timer para desactivar inmunidad
	$Sprite/DamageAnim.play("ScenesDamage") #Efecto visual
	if(life==0): #Si no tiene vida muere
		_death()

#Activa colider
func _on_DamageCooldown_timeout():
	colliderRef.disabled=false

#Efectos visuales y de sonido para muerte
func _death():
	$DeathSound.play()
	$Sprite.visible=false
	explotion.visible=true
	var anim=$ExplotionAnim/AnimationPlayer
	anim.play("Boom")
	emit_signal("playerDead")
	
