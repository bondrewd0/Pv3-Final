extends Enemy

var bulletDir=[
	Position2D.new(),
	Position2D.new(),
	Position2D.new(),
	Position2D.new() 
]
var rotatorRef= Node2D.new()
var state=0
func _create_bullet_Targets():
	add_child(rotatorRef)
	bulletDir[0].position=Vector2(0,-50)
	rotatorRef.add_child(bulletDir[0])
	bulletDir[1].position=Vector2(40,-50)
	rotatorRef.add_child(bulletDir[1])
	bulletDir[2].position=Vector2(-40,-50)
	rotatorRef.add_child(bulletDir[2])

func _action():
	if state==0:
		rotate(0.01)
	if state==1:
		rotate(-0.01)
	rotation = clamp(rotation, deg2rad(150), deg2rad(220))

func _fire_Bullet():
	var bulletIns1=bulletScene.instance()
	bulletIns1.position=bulletSpwan.global_position
	bulletIns1.rotation=self.rotation
	bulletIns1.dir=Vector2(bulletDir[0].global_position.x-self.global_position.x,bulletDir[0].global_position.y-self.global_position.y).normalized()
	bulletIns1.type='EnemyBullet'
	bulletIns1.speed=300
	get_parent().add_child(bulletIns1)
	var bulletIns2=bulletScene.instance()
	bulletIns2.position=bulletSpwan.global_position
	bulletIns2.rotation=self.rotation+0.5
	bulletIns2.dir=Vector2(bulletDir[1].global_position.x-self.global_position.x,bulletDir[1].global_position.y-self.global_position.y).normalized()
	bulletIns2.type='EnemyBullet'
	bulletIns2.speed=300
	get_parent().add_child(bulletIns2)
	var bulletIns3=bulletScene.instance()
	bulletIns3.position=bulletSpwan.global_position
	bulletIns3.rotation=self.rotation-0.5
	bulletIns3.dir=Vector2(bulletDir[2].global_position.x-self.global_position.x,bulletDir[2].global_position.y-self.global_position.y).normalized()
	bulletIns3.type='EnemyBullet'
	bulletIns3.speed=300
	get_parent().add_child(bulletIns3)


func _on_StateChanger_timeout():
	state+=1
	if state==2:
		state=0
