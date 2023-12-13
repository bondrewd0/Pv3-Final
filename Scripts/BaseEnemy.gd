
extends RigidBody2D
#Collision type
var type='Enemy'

#Reference variables:
onready var bulletSpwan=$BulletPoint
onready var changeState=$StateChanger
onready var fireRef=$Fire
onready var playerRef=get_parent().get_node('Player')
onready var tween=$Movement
var bulletScene=preload("res://Scenes/Bullet.tscn")

#Variables for enemy type:
var attackType=0
export var fireRate =0
var state=0
var finalPos=Vector2(0,0)
var moreRefPoints=[
	Position2D.new(),
	Position2D.new(),
	Position2D.new(),
	Position2D.new() 
]
var reverseRefPoints=[
	Position2D.new(),
	Position2D.new(),
	Position2D.new(),
	Position2D.new() 
]  
var rotatorRef= Node2D.new()
var reverseRotator=Node2D.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	print(attackType)
	moreRefPoints[0].position=Vector2(0,-50)
	fireRef.start(fireRate)
	match attackType:
		0:
			add_child(moreRefPoints[0])
			tween.interpolate_property(self,'position',position,finalPos,7,Tween.TRANS_CIRC,Tween.EASE_IN)
		1:
			add_child(moreRefPoints[0])
			tween.interpolate_property(self,'position',position,finalPos,5.5,Tween.TRANS_CIRC,Tween.EASE_IN)
		2,3:
			add_child(rotatorRef)
			rotatorRef.add_child(moreRefPoints[0])
			moreRefPoints[1].position=Vector2(40,-50)
			rotatorRef.add_child(moreRefPoints[1])
			moreRefPoints[2].position=Vector2(-40,-50)
			rotatorRef.add_child(moreRefPoints[2])
			tween.interpolate_property(self,'position',position,finalPos,10,Tween.TRANS_CIRC,Tween.EASE_IN)
		4:
			add_child(reverseRotator)
			add_child(rotatorRef)
			rotatorRef.add_child(moreRefPoints[0])
			moreRefPoints[1].position=Vector2(50,0)
			rotatorRef.add_child(moreRefPoints[1])
			moreRefPoints[2].position=Vector2(-50,0)
			rotatorRef.add_child(moreRefPoints[2])
			moreRefPoints[3].position=Vector2(0,50)
			rotatorRef.add_child(moreRefPoints[3])
			reverseRefPoints[0].position=Vector2(50,-25)
			reverseRotator.add_child(reverseRefPoints[0])
			reverseRefPoints[1].position=Vector2(50,25)
			reverseRotator.add_child(reverseRefPoints[1])
			reverseRefPoints[2].position=Vector2(-50,25)
			reverseRotator.add_child(reverseRefPoints[2])
			reverseRefPoints[3].position=Vector2(-50,-25)
			reverseRotator.add_child(reverseRefPoints[3])
			tween.interpolate_property(self,'position',position,finalPos,10,Tween.TRANS_CIRC,Tween.EASE_IN)
	tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(deg2rad(self.rotation))
	match attackType:
		0,2:
			_fan_Rotation()
		1:
			_lockOn_Player()
		3,4:
			_rotate_RefPoints()
	_out_Of_View()


func _destroy():
	queue_free()


func _out_Of_View():
	if(position.x<-20 || position.x>620):
		queue_free()
	if(position.y<-20 || position.y>740):
		queue_free()

#fire
func _spawn_Normal_Bullets():
	var bulletIns=bulletScene.instance()
	bulletIns.position=bulletSpwan.global_position
	bulletIns.rotation=self.rotation
	bulletIns.dir=Vector2(moreRefPoints[0].global_position.x-self.global_position.x,moreRefPoints[0].global_position.y-self.global_position.y).normalized()
	bulletIns.type='EnemyBullet'
	bulletIns.speed=300
	get_parent().add_child(bulletIns)

func _spawn_Multiple_Bullets():
	var bulletIns1=bulletScene.instance()
	bulletIns1.position=bulletSpwan.global_position
	bulletIns1.rotation=self.rotation
	bulletIns1.dir=Vector2(moreRefPoints[0].global_position.x-self.global_position.x,moreRefPoints[0].global_position.y-self.global_position.y).normalized()
	bulletIns1.type='EnemyBullet'
	bulletIns1.speed=300
	get_parent().add_child(bulletIns1)
	var bulletIns2=bulletScene.instance()
	bulletIns2.position=bulletSpwan.global_position
	bulletIns2.rotation=self.rotation+0.5
	bulletIns2.dir=Vector2(moreRefPoints[1].global_position.x-self.global_position.x,moreRefPoints[1].global_position.y-self.global_position.y).normalized()
	bulletIns2.type='EnemyBullet'
	bulletIns2.speed=300
	get_parent().add_child(bulletIns2)
	var bulletIns3=bulletScene.instance()
	bulletIns3.position=bulletSpwan.global_position
	bulletIns3.rotation=self.rotation-0.5
	bulletIns3.dir=Vector2(moreRefPoints[2].global_position.x-self.global_position.x,moreRefPoints[2].global_position.y-self.global_position.y).normalized()
	bulletIns3.type='EnemyBullet'
	bulletIns3.speed=300
	get_parent().add_child(bulletIns3)
	if(attackType==4):
		var bulletIns4=bulletScene.instance()
		bulletIns4.position=bulletSpwan.global_position
		bulletIns4.rotation=rotatorRef.rotation
		bulletIns4.dir=Vector2(reverseRefPoints[0].global_position.x-self.global_position.x,reverseRefPoints[0].global_position.y-self.global_position.y).normalized()
		bulletIns4.type='EnemyBullet'
		bulletIns4.speed=300
		get_parent().add_child(bulletIns4)
		var bulletIns5=bulletScene.instance()
		bulletIns5.position=bulletSpwan.global_position
		bulletIns5.rotation=rotatorRef.rotation-1
		bulletIns5.dir=Vector2(moreRefPoints[3].global_position.x-self.global_position.x,moreRefPoints[3].global_position.y-self.global_position.y).normalized()
		bulletIns5.type='EnemyBullet'
		bulletIns5.speed=300
		get_parent().add_child(bulletIns5)
		var bulletIns6=bulletScene.instance()
		bulletIns6.position=bulletSpwan.global_position
		bulletIns6.rotation=rotatorRef.rotation+0.5
		bulletIns6.dir=Vector2(reverseRefPoints[1].global_position.x-self.global_position.x,reverseRefPoints[1].global_position.y-self.global_position.y).normalized()
		bulletIns6.type='EnemyBullet'
		bulletIns6.speed=300
		get_parent().add_child(bulletIns6)
		var bulletIns7=bulletScene.instance()
		bulletIns7.position=bulletSpwan.global_position
		bulletIns7.rotation=rotatorRef.rotation-0.5
		bulletIns7.dir=Vector2(reverseRefPoints[2].global_position.x-self.global_position.x,reverseRefPoints[2].global_position.y-self.global_position.y).normalized()
		bulletIns7.type='EnemyBullet'
		bulletIns7.speed=300
		get_parent().add_child(bulletIns7)
		var bulletIns8=bulletScene.instance()
		bulletIns8.position=bulletSpwan.global_position
		bulletIns8.rotation=rotatorRef.rotation-1
		bulletIns8.dir=Vector2(reverseRefPoints[3].global_position.x-self.global_position.x,reverseRefPoints[3].global_position.y-self.global_position.y).normalized()
		bulletIns8.type='EnemyBullet'
		bulletIns8.speed=300
		get_parent().add_child(bulletIns8)

func _on_Fire_timeout():
	match attackType:
		0, 1 :
			_spawn_Normal_Bullets()
		2,3,4:
			_spawn_Multiple_Bullets()


func _on_StateChanger_timeout():
	_change_State()

func _change_State():
	state+=1
	if state==2:
		state=0

#actions
func _fan_Rotation():
	if state==0:
		rotate(0.008)
	if state==1:
		rotate(-0.008)
	rotation = clamp(rotation, deg2rad(150), deg2rad(220))
#actions
func _rotate_RefPoints():
	rotatorRef.rotate(0.01)
	if(attackType==4):
		reverseRotator.rotate(-0.01)


func _lockOn_Player():
	rotation=position.angle_to_point(playerRef.global_position)-deg2rad(90)

