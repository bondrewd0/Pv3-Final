
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
var state=0
var finalPos=Vector2(0,0)
var moreRefPoints=[
	Position2D.new(),
	Position2D.new() 
] 

# Called when the node enters the scene tree for the first time.
func _ready():
	targetRef.position=Vector2(0,-50)
	fireRef.start(fireRate)
	match attackType:
		0:
			tween.interpolate_property(self,'position',position,finalPos,10,Tween.TRANS_CIRC,Tween.EASE_IN,0.3)
		1:
			tween.interpolate_property(self,'position',position,finalPos,8,Tween.TRANS_CIRC,Tween.EASE_IN)
		2:
			moreRefPoints[0].position=Vector2(40,-50)
			add_child(moreRefPoints[0])
			moreRefPoints[1].position=Vector2(-40,-50)
			add_child(moreRefPoints[1])
			tween.interpolate_property(self,'position',position,finalPos,14,Tween.TRANS_CIRC,Tween.EASE_IN,0.3)
	tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(deg2rad(self.rotation))
	match attackType:
		0:
			_fan_Rotation()
		1:
			_lockOn_Player()
		2:
			_fan_Rotation()
	_out_Of_View()


func _spawn_Normal_Bullets():
	var bulletIns=bulletScene.instance()
	bulletIns.position=bulletSpwan.global_position
	bulletIns.rotation=self.rotation
	bulletIns.dir=Vector2(targetRef.global_position.x-self.global_position.x,targetRef.global_position.y-self.global_position.y).normalized()
	bulletIns.type='EnemyBullet'
	bulletIns.speed=300
	get_parent().add_child(bulletIns)

func _spawn_Multiple_Bullets():
	var bulletIns1=bulletScene.instance()
	bulletIns1.position=bulletSpwan.global_position
	bulletIns1.rotation=self.rotation
	bulletIns1.dir=Vector2(targetRef.global_position.x-self.global_position.x,targetRef.global_position.y-self.global_position.y).normalized()
	bulletIns1.type='EnemyBullet'
	bulletIns1.speed=300
	get_parent().add_child(bulletIns1)
	var bulletIns2=bulletScene.instance()
	bulletIns2.position=bulletSpwan.global_position
	bulletIns2.rotation=self.rotation+0.5
	bulletIns2.dir=Vector2(moreRefPoints[0].global_position.x-self.global_position.x,moreRefPoints[0].global_position.y-self.global_position.y).normalized()
	bulletIns2.type='EnemyBullet'
	bulletIns2.speed=300
	get_parent().add_child(bulletIns2)
	var bulletIns3=bulletScene.instance()
	bulletIns3.position=bulletSpwan.global_position
	bulletIns3.rotation=self.rotation-0.5
	bulletIns3.dir=Vector2(moreRefPoints[1].global_position.x-self.global_position.x,moreRefPoints[1].global_position.y-self.global_position.y).normalized()
	bulletIns3.type='EnemyBullet'
	bulletIns3.speed=300
	get_parent().add_child(bulletIns3)


func _on_Fire_timeout():
	if attackType==0 ||attackType==1  :
		_spawn_Normal_Bullets()
	if attackType==2:
		_spawn_Multiple_Bullets()


func _on_StateChanger_timeout():
	_change_State()

func _change_State():
	state+=1
	if state==2:
		state=0


func _destroy():
	queue_free()

func _fan_Rotation():
	if state==0:
		rotate(0.008)
	if state==1:
		rotate(-0.008)
	rotation = clamp(rotation, deg2rad(150), deg2rad(220))


func _lockOn_Player():
	rotation=position.angle_to_point(playerRef.global_position)-deg2rad(90)


func _out_Of_View():
	if(position.x<-20 || position.x>620):
		queue_free()
	if(position.y<-20 || position.y>740):
		queue_free()


