extends Enemy

var bulletDir=Position2D.new()
var state=0

func _create_bullet_Targets():
	bulletDir.position=Vector2(0,-50)
	add_child(bulletDir)


func _fire_Bullet():
	var bulletIns=bulletScene.instance()
	bulletIns.position=bulletSpwan.global_position
	bulletIns.rotation=self.rotation
	bulletIns.dir=Vector2(bulletDir.global_position.x-self.global_position.x,bulletDir.global_position.y-self.global_position.y).normalized()
	bulletIns.type='EnemyBullet'
	bulletIns.shooterType=2
	bulletIns.speed=300
	get_parent().add_child(bulletIns)

func _on_StateChanger_timeout():
	state+=1
	if state==2:
		state=0

func _action():
	if state==0:
		rotate(0.008)
	if state==1:
		rotate(-0.008)
	rotation = clamp(rotation, deg2rad(150), deg2rad(220))
