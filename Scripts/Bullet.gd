extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed=0
var dir= Vector2(1,0)
var type=''
var shooterType=0
var bulletSprite
# Called when the node enters the scene tree for the first time.
func _ready():
	match shooterType:
		0:
			bulletSprite=ResourceLoader.load("res://Assets/06.png")
			$Sprite.scale=Vector2(0.5,0.5)
		1:
			bulletSprite=ResourceLoader.load("res://Assets/OvalBullet.png")
		2:
			bulletSprite=ResourceLoader.load("res://Assets/RoundBullet.png")
	$Sprite.texture=bulletSprite
	


 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position+=dir*speed*delta
	if($RayCast2D.is_colliding()):
		var collid=$RayCast2D.get_collider()
		if collid!=null:
			if(collid.type=='Enemy' && type=='PlayerBullet'):
				collid._destroy()
				queue_free()
			if(type=='EnemyBullet' && collid.type=='Player'):
				collid._taking_Fire()
				queue_free()



func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()
