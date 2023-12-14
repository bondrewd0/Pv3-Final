extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var  speed=0.0
var bulletScene=preload("res://Scenes/Bullet.tscn")
var limits=Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
onready var bulletPos=$Position2D
var  canShoot=true
var firingCooldown=0.3
onready var timerRef=$FireRate
onready var buffTimerRef=$BuffTimer
var type='Player'
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):

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
	position=Vector2(clamp(position.x,20,limits.x-20),clamp(position.y,20,limits.y-20))
	if(Input.is_action_pressed("Shoot")):
		open_fire()
	pass

func open_fire():
	if(canShoot):
		canShoot=false
		timerRef.start(firingCooldown)
		var bulletInstance=bulletScene.instance()
		bulletInstance.global_position=bulletPos.global_position
		bulletInstance.dir=Vector2(0,-1)
		bulletInstance.type='PlayerBullet'
		get_parent().add_child(bulletInstance)
	pass

func _on_FireRate_timeout():
	canShoot=!canShoot

func _on_BuffTimer_timeout():
	firingCooldown=0.15


func _fireRate_up():
	buffTimerRef.start(5)
	firingCooldown=0.05

func _on_Area2D_area_entered(_area):
	_fireRate_up()



