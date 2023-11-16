extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var body=$KinematicBody2D
export var  speed=0.0
var bulletScene=preload("res://Bullet.tscn")
onready var bulletPos=$KinematicBody2D/Position2D
var  canShoot=true
var firingCooldown=0.3
onready var timerRef=$KinematicBody2D/FireRate
onready var buffTimerRef=$KinematicBody2D/BuffTimer
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
	body.move_and_slide(velocity)
	if(Input.is_action_pressed("Shoot")):
		open_fire()
	pass
func open_fire():
	if(canShoot):
		canShoot=false
		var bulletInstance=bulletScene.instance()
		add_child(bulletInstance)
		bulletInstance.global_position=bulletPos.global_position
		timerRef.start(firingCooldown)
	pass

func _on_FireRate_timeout():
	canShoot=!canShoot



func _on_BuffTimer_timeout():
	firingCooldown=0.15


func _fireRate_up():
	buffTimerRef.start(5)
	firingCooldown=0.05
	print(1)





func _on_Area2D_area_entered(_area):
	_fireRate_up()



