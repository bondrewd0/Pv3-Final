extends RigidBody2D

class_name Enemy

#Tipos
var type='Enemy'
var bulletType='EnemyBullet'

#Referencias a nodos internos a usar
onready var bulletSpwan=$BulletPoint #Posicion de generacion de balas
onready var fireRef=$Fire #Timer de cadencia de disparo
onready var tween=$Movement
#Referneica a balas
var bulletScene=preload("res://Scenes/Bullet.tscn")
#Tiempo de movimiento desde pos inicial a final
var movementTime=10.0
#Cadencia de disparo
export var fireRate =2
#Posicion final
var finalPos=Vector2(0,0)
#puntos de vida
export var hitpoints=1
#Tiempo de proteccion al generarse
export var spawnProtection=1
#Señal de puntos a dar
signal pointsUp(score)
#Cantidad de puntos a dar
export var points:int=100


#Inicia variables, desactiva colider y empieza timer de proteccion
func _ready():
	$CollisionShape2D.disabled=true
	fireRef.start(fireRate)
	_create_bullet_Targets()
	_move()
	var timer:Timer=Timer.new()
	add_child(timer)
	timer.one_shot=true
	timer.autostart=true
	timer.wait_time=spawnProtection
	timer.connect("timeout",self,"_on_SpawnProtection_timeout")
	timer.start()


func _process(_delta):
	_out_Of_View()
	_action()

#Funcion modificable por los hijos
func _create_bullet_Targets():
	pass

#Se auto elimina si sale de la pantalla
func _out_Of_View():
	if(position.x<-40 || position.x>1200):
		queue_free()
	if(position.y<-40 || position.y>760):
		queue_free()

#Funcion modificable por los hijos
func _action():
	pass

#Funcion modificable por los hijos
func _fire_Bullet():
	pass

#Destruye el objeto cuando no tiene vida
func _destroy():
	hitpoints-=1
	if(hitpoints==0):#Emite señal de puntos y envia la cantidad de puntos
		emit_signal("pointsUp",points)
		queue_free()

#Timer de disparo
func _on_Fire_timeout():
	_fire_Bullet()

#Funcion modificable por los hijos
func _create_Bullet_DirPoints():
	pass

#Movimiento 
func _move():
	tween.interpolate_property(self,'position',position,finalPos,movementTime,Tween.TRANS_CIRC,Tween.EASE_IN)
	tween.start()

#Activa el colider
func _on_SpawnProtection_timeout():
	$CollisionShape2D.disabled=false
