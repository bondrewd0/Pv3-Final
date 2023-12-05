
extends RigidBody2D
#Collision type
var type='Enemy'

#Reference variables:
onready var bulletSpwan=$BulletPoint
onready var changeState=$StateChanger
onready var fireRef=$Fire
onready var playerRef=get_parent().get_node('Player')
onready var targetRef=$TargetDir
onready var tween=$Movement
var bulletScene=preload("res://Scenes/Bullet.tscn")

#Variables for enemy type:
var attackType=0
export var fireRate =0
var state
var finalPos=Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	state=0
	targetRef.position=Vector2(0,-50)
	fireRef.start(fireRate)
	if attackType==1:
		finalPos=Vector2(self.position.x,self.position.y+900)
		tween.interpolate_property(self,'position',position,finalPos,9,Tween.TRANS_CIRC,Tween.EASE_IN,0.3)
	if attackType==0:
		finalPos=Vector2(0,self.position.y+700)
		print(finalPos.x)
		print(self.position.x)
		tween.interpolate_property(self,'position',position,finalPos,9,Tween.TRANS_CIRC,Tween.EASE_IN,0.3)
	tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(deg2rad(self.rotation))
	if attackType==0:
		_fan_Rotation()
	if attackType==1:
		_lockOn_Player()


func _spawn_Normal_Bullets():
	var bulletIns=bulletScene.instance()
	bulletIns.position=bulletSpwan.global_position
	bulletIns.rotation=self.rotation
	bulletIns.dir=Vector2(targetRef.global_position.x-self.global_position.x,targetRef.global_position.y-self.global_position.y).normalized()
	bulletIns.type='EnemyBullet'
	bulletIns.speed=300
	get_parent().add_child(bulletIns)


func _on_Fire_timeout():
	if attackType==0 ||attackType==1  :
		_spawn_Normal_Bullets()


func _on_StateChanger_timeout():
	_change_State()

func _change_State():
	state+=1
	if state==2:
		state=0


func _destroy(hitType):
	if hitType=='PlayerBullet':
		queue_free()
	pass

func _fan_Rotation():
	if state==0:
		rotate(0.008)
	if state==1:
		rotate(-0.008)
	rotation = clamp(rotation, deg2rad(150), deg2rad(220))


func _lockOn_Player():
	rotation=position.angle_to_point(playerRef.global_position)-deg2rad(90)
