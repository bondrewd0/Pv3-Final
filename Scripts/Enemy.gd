extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bulletScene=preload("res://Scenes/Bullet.tscn")
onready var targetRef=$TargetDir
var state
var type='Enemy'
onready var changeState=$StateChanger
# Called when the node enters the scene tree for the first time.
func _ready():
	state=0
	targetRef.position=Vector2(0,-50)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	print(deg2rad(self.rotation))
	if state==0:
		self.rotate(0.008)
	if state==1:
		self.rotate(-0.008)
	if state==2:
		self.rotate(0.005)
	if state==3:
		self.rotate(-0.005)
	self.rotation = clamp(self.rotation, deg2rad(150), deg2rad(200))

func _spawn_bullets():
	var bulletIns=bulletScene.instance()
	bulletIns.position=self.position
	bulletIns.rotation=self.rotation
	bulletIns.dir=Vector2(targetRef.global_position.x-self.global_position.x,targetRef.global_position.y-self.global_position.y).normalized()
	get_parent().add_child(bulletIns)




func _on_Fire_timeout():
	_spawn_bullets()


func _on_StateChanger_timeout():
	_change_State()

func _change_State():
	state=round(rand_range(0,3))
	print(state)

