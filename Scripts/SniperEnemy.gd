extends Enemy

onready var playerRef=get_parent().get_node('Player')
var bulletDir=Position2D.new()

func _create_bullet_Targets():
	bulletDir.position=Vector2(0,-50)
	add_child(bulletDir)

func _action():
	rotation=position.angle_to_point(playerRef.global_position)-deg2rad(90)

func _fire_Bullet():
	var bulletIns=bulletScene.instance()
	bulletIns.position=bulletSpwan.global_position
	bulletIns.rotation=self.rotation
	bulletIns.dir=Vector2(bulletDir.global_position.x-self.global_position.x,bulletDir.global_position.y-self.global_position.y).normalized()
	bulletIns.type='EnemyBullet'
	bulletIns.speed=300
	get_parent().add_child(bulletIns)
