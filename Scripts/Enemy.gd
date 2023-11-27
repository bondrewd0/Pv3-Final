extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bulletScene=preload("res://Scenes/Bullet.tscn")
onready var targetRef=$TargetDir
var type='Enemy'
# Called when the node enters the scene tree for the first time.
func _ready():
	targetRef.position=Vector2(0,-50)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.rotate(0.05)

func _spawn_bullets():
	var bulletIns=bulletScene.instance()
	
	
	bulletIns.position=self.position
	bulletIns.rotation=self.rotation
	print(bulletIns.dir,self.position,targetRef.position)
	bulletIns.dir=Vector2(targetRef.global_position.x-self.global_position.x,targetRef.global_position.y-self.global_position.y).normalized()
	get_parent().add_child(bulletIns)




func _on_Fire_timeout():
	_spawn_bullets()
