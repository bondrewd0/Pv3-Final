tool
extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bulletScene=preload("res://Scenes/Bullet.tscn")
onready var playerRef=get_parent().get_node('Player')
onready var targetRef=$TargetDir
var attackType=0
var state
var type='Enemy'
onready var bulletSpwan=$BulletPoint
onready var changeState=$StateChanger
# Called when the node enters the scene tree for the first time.
func _ready():
	state=0
	targetRef.position=Vector2(0,-50)
	
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
	get_parent().add_child(bulletIns)





func _on_Fire_timeout():
	if attackType==0 ||attackType==1  :
		_spawn_Normal_Bullets()


func _on_StateChanger_timeout():
	_change_State()

func _change_State():
	state=round(rand_range(-1,3))
	#print(state)

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
