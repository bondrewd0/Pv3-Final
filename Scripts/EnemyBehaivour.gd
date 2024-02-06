extends RigidBody2D

class_name Enemy

var type='Enemy'
var bulletType='EnemyBullet'

onready var bulletSpwan=$BulletPoint
onready var fireRef=$Fire
onready var tween=$Movement
var bulletScene=preload("res://Scenes/Bullet.tscn")
var movementTime=10.0
export var fireRate =2
var finalPos=Vector2(0,0)
export var hitpoints=1
export var spawnProtection=1
signal pointsUp(score)
export var points:int=100
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

func _create_bullet_Targets():
	pass

func _out_Of_View():
	if(position.x<-40 || position.x>1200):
		queue_free()
	if(position.y<-40 || position.y>760):
		queue_free()

func _action():
	pass

func _fire_Bullet():
	pass

func _destroy():
	hitpoints-=1
	if(hitpoints==0):
		emit_signal("pointsUp",points)
		queue_free()

func _on_Fire_timeout():
	_fire_Bullet()

func _create_Bullet_DirPoints():
	pass

func _move():
	tween.interpolate_property(self,'position',position,finalPos,movementTime,Tween.TRANS_CIRC,Tween.EASE_IN)
	tween.start()


func _on_SpawnProtection_timeout():
	$CollisionShape2D.disabled=false
