extends Enemy

var bulletDir=[
	Position2D.new(),
	Position2D.new(),
	Position2D.new(),
	Position2D.new(),
	Position2D.new(),
	Position2D.new()
]
var rotatorRef= Node2D.new()
var rotatorRef2= Node2D.new()
var reverseRotator=Node2D.new()
var attackMode=0
onready var playerRef=get_parent().get_node('Player')
onready var explotion=$ExplotionAnim 
onready var bulletSpwan2=$BulletPoint2
onready var bulletSpwan3=$BulletPoint3
onready var bulletSpwan4=$BulletPoint4
func _create_bullet_Targets():
	rotatorRef.position=bulletSpwan.position
	rotatorRef2.position=Vector2(-40,-50)
	add_child(rotatorRef)
	add_child(rotatorRef2)
	add_child(reverseRotator)
	bulletDir[0].position=Vector2(0,10)
	rotatorRef.add_child(bulletDir[0])
	bulletDir[1].position=Vector2(0,10)
	rotatorRef2.add_child(bulletDir[1])
#	bulletDir[2].position=Vector2(-30,-40)
#	rotatorRef.add_child(bulletDir[2])
#	bulletDir[3].position=Vector2(-10,-40)
#	rotatorRef.add_child(bulletDir[3])
#	bulletDir[4].position=Vector2(30,-40)
#	reverseRotator.add_child(bulletDir[4])
#	bulletDir[5].position=Vector2(10,-40)
#	reverseRotator.add_child(bulletDir[5])

func _action():
	rotatorRef.rotation=rotatorRef.global_position.angle_to_point(playerRef.global_position)-deg2rad(90)
	rotatorRef2.rotation=rotatorRef2.global_position.angle_to_point(playerRef.global_position)-deg2rad(90)

func _fire_Bullet():
	if(attackMode==0):
		var bulletIns1=bulletScene.instance()
		bulletIns1.position=bulletSpwan.global_position
		bulletIns1.rotation=bulletSpwan.rotation
		bulletIns1.dir=Vector2(bulletDir[0].global_position.x-bulletSpwan.global_position.x,bulletDir[0].global_position.y-bulletSpwan.global_position.y).normalized()
		bulletIns1.type='EnemyBullet'
		bulletIns1.shooterType=1
		bulletIns1.speed=300
		get_parent().add_child(bulletIns1)
		var bulletIns2=bulletScene.instance()
		bulletIns2.position=bulletSpwan2.global_position
		bulletIns2.rotation=bulletSpwan2.rotation
		bulletIns2.dir=Vector2(bulletDir[1].global_position.x-bulletSpwan2.global_position.x,bulletDir[1].global_position.y-bulletSpwan2.global_position.y).normalized()
		bulletIns2.type='EnemyBullet'
		bulletIns2.shooterType=1
		bulletIns2.speed=300
		get_parent().add_child(bulletIns2)
		pass
#	else:
#		var bulletIns3=bulletScene.instance()
#		bulletIns3.position=bulletSpwan3.global_position
#		bulletIns3.rotation=self.rotation-0.5
#		bulletIns3.dir=Vector2(bulletDir[2].global_position.x-self.global_position.x,bulletDir[2].global_position.y-self.global_position.y).normalized()
#		bulletIns3.type='EnemyBullet'
#		bulletIns3.shooterType=1
#		bulletIns3.speed=300
#		get_parent().add_child(bulletIns3)
#		var bulletIns4=bulletScene.instance()
#		bulletIns4.position=bulletSpwan3.global_position
#		bulletIns4.rotation=rotatorRef.rotation-1
#		bulletIns4.dir=Vector2(bulletDir[3].global_position.x-self.global_position.x,bulletDir[3].global_position.y-self.global_position.y).normalized()
#		bulletIns4.type='EnemyBullet'
#		bulletIns4.shooterType=1
#		bulletIns4.speed=300
#		get_parent().add_child(bulletIns4)
#		var bulletIns5=bulletScene.instance()
#		bulletIns5.position=bulletSpwan4.global_position
#		bulletIns5.rotation=rotatorRef.rotation
#		bulletIns5.dir=Vector2(bulletDir[4].global_position.x-self.global_position.x,bulletDir[4].global_position.y-self.global_position.y).normalized()
#		bulletIns5.type='EnemyBullet'
#		bulletIns5.shooterType=1
#		bulletIns5.speed=300
#		get_parent().add_child(bulletIns5)
#		var bulletIns6=bulletScene.instance()
#		bulletIns6.position=bulletSpwan4.global_position
#		bulletIns6.rotation=rotatorRef.rotation+0.5
#		bulletIns6.dir=Vector2(bulletDir[5].global_position.x-self.global_position.x,bulletDir[5].global_position.y-self.global_position.y).normalized()
#		bulletIns6.type='EnemyBullet'
#		bulletIns6.shooterType=1
#		bulletIns6.speed=300
#		get_parent().add_child(bulletIns6)
func _destroy():
	hitpoints-=1
	if hitpoints==0:
		_death()
		var timer:Timer=Timer.new()
		add_child(timer)
		timer.one_shot=true
		timer.autostart=true
		timer.wait_time=1.3
		timer.connect("timeout",self,"_disable_Boss")
		timer.start()

func _disable_Boss():
	emit_signal("pointsUp",points)
	queue_free() 

func _death():
	$DeathSound.play()
	$Sprite.visible=false
	explotion.visible=true
	var anim=$ExplotionAnim/AnimationPlayer
	anim.play("Explotion")
