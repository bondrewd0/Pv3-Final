extends Enemy


var bulletDir=[
	Position2D.new(),
	Position2D.new(),
	Position2D.new(),
	Position2D.new() 
]
var rotatorRef= Node2D.new()

func _create_bullet_Targets():
	add_child(rotatorRef)
	bulletDir[0].position=Vector2(0,-50)
	rotatorRef.add_child(bulletDir[0])
	bulletDir[1].position=Vector2(50,0)
	rotatorRef.add_child(bulletDir[1])
	bulletDir[2].position=Vector2(-50,0)
	rotatorRef.add_child(bulletDir[2])
	bulletDir[3].position=Vector2(0,50)
	rotatorRef.add_child(bulletDir[3])

func _action():
	rotatorRef.rotate(0.01)

func _fire_Bullet():
	var bulletIns1=bulletScene.instance()
	bulletIns1.position=bulletSpwan.global_position
	bulletIns1.rotation=self.rotation
	bulletIns1.dir=Vector2(bulletDir[0].global_position.x-self.global_position.x,bulletDir[0].global_position.y-self.global_position.y).normalized()
	bulletIns1.type='EnemyBullet'
	bulletIns1.shooterType=2
	bulletIns1.speed=300
	get_parent().add_child(bulletIns1)
	var bulletIns2=bulletScene.instance()
	bulletIns2.position=bulletSpwan.global_position
	bulletIns2.rotation=self.rotation+0.5
	bulletIns2.dir=Vector2(bulletDir[1].global_position.x-self.global_position.x,bulletDir[1].global_position.y-self.global_position.y).normalized()
	bulletIns2.type='EnemyBullet'
	bulletIns2.shooterType=2
	bulletIns2.speed=300
	get_parent().add_child(bulletIns2)
	var bulletIns3=bulletScene.instance()
	bulletIns3.position=bulletSpwan.global_position
	bulletIns3.rotation=self.rotation-0.5
	bulletIns3.dir=Vector2(bulletDir[2].global_position.x-self.global_position.x,bulletDir[2].global_position.y-self.global_position.y).normalized()
	bulletIns3.type='EnemyBullet'
	bulletIns3.shooterType=2
	bulletIns3.speed=300
	get_parent().add_child(bulletIns3)
	var bulletIns4=bulletScene.instance()
	bulletIns4.position=bulletSpwan.global_position
	bulletIns4.rotation=rotatorRef.rotation-1
	bulletIns4.dir=Vector2(bulletDir[3].global_position.x-self.global_position.x,bulletDir[3].global_position.y-self.global_position.y).normalized()
	bulletIns4.type='EnemyBullet'
	bulletIns4.shooterType=2
	bulletIns4.speed=300
	get_parent().add_child(bulletIns4)
