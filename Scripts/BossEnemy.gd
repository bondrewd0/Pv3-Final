extends Enemy
#Este jefe ataca rotando sus cañones en todas direcciones
#nodos locales para dar direccion a las balas
var bulletDir=[
	Position2D.new(),
	Position2D.new(),
	Position2D.new(),
	Position2D.new(),
	Position2D.new(),
	Position2D.new(),
	Position2D.new(),
	Position2D.new()  
]

#nodos locales para rotar las direcciones 
var rotatorRef= Node2D.new()
var reverseRotator=Node2D.new()

#Referencia a animacion
onready var explotion=$ExplotionAnim 

#Inicializacion de nodos locales
func _create_bullet_Targets():
	add_child(rotatorRef)
	add_child(reverseRotator)
	bulletDir[0].position=Vector2(0,-50)
	rotatorRef.add_child(bulletDir[0])
	bulletDir[1].position=Vector2(50,0)
	rotatorRef.add_child(bulletDir[1])
	bulletDir[2].position=Vector2(-50,0)
	rotatorRef.add_child(bulletDir[2])
	bulletDir[3].position=Vector2(0,50)
	rotatorRef.add_child(bulletDir[3])
	bulletDir[4].position=Vector2(50,-25)
	reverseRotator.add_child(bulletDir[4])
	bulletDir[5].position=Vector2(50,25)
	reverseRotator.add_child(bulletDir[5])
	bulletDir[6].position=Vector2(-50,25)
	reverseRotator.add_child(bulletDir[6])
	bulletDir[7].position=Vector2(-50,-25)
	reverseRotator.add_child(bulletDir[7])

#Rotacion de nodos
func _action():
	rotatorRef.rotate(0.01)
	reverseRotator.rotate(-0.01)

#Generacion de balas
func _fire_Bullet():
	#Creo la instancia y defino caracteristicas
	var bulletIns1=bulletScene.instance()
	bulletIns1.position=bulletSpwan.global_position #posicion de inicio
	bulletIns1.rotation=self.rotation #Rotacion en base al cuerpo
	#direccion segun el nodo
	bulletIns1.dir=Vector2(bulletDir[0].global_position.x-self.global_position.x,bulletDir[0].global_position.y-self.global_position.y).normalized()
	bulletIns1.type='EnemyBullet' #Tipo de bala
	bulletIns1.shooterType=1 #Tipo de sprite a usar
	bulletIns1.speed=300 #velocidad de bala
	get_parent().add_child(bulletIns1) #Se a;ade al nivel
	var bulletIns2=bulletScene.instance()
	bulletIns2.position=bulletSpwan.global_position
	bulletIns2.rotation=self.rotation+0.5
	bulletIns2.dir=Vector2(bulletDir[1].global_position.x-self.global_position.x,bulletDir[1].global_position.y-self.global_position.y).normalized()
	bulletIns2.type='EnemyBullet'
	bulletIns2.shooterType=1
	bulletIns2.speed=300
	get_parent().add_child(bulletIns2)
	var bulletIns3=bulletScene.instance()
	bulletIns3.position=bulletSpwan.global_position
	bulletIns3.rotation=self.rotation-0.5
	bulletIns3.dir=Vector2(bulletDir[2].global_position.x-self.global_position.x,bulletDir[2].global_position.y-self.global_position.y).normalized()
	bulletIns3.type='EnemyBullet'
	bulletIns3.shooterType=1
	bulletIns3.speed=300
	get_parent().add_child(bulletIns3)
	var bulletIns4=bulletScene.instance()
	bulletIns4.position=bulletSpwan.global_position
	bulletIns4.rotation=rotatorRef.rotation-1
	bulletIns4.dir=Vector2(bulletDir[3].global_position.x-self.global_position.x,bulletDir[3].global_position.y-self.global_position.y).normalized()
	bulletIns4.type='EnemyBullet'
	bulletIns4.shooterType=1
	bulletIns4.speed=300
	get_parent().add_child(bulletIns4)
	var bulletIns5=bulletScene.instance()
	bulletIns5.position=bulletSpwan.global_position
	bulletIns5.rotation=rotatorRef.rotation
	bulletIns5.dir=Vector2(bulletDir[4].global_position.x-self.global_position.x,bulletDir[4].global_position.y-self.global_position.y).normalized()
	bulletIns5.type='EnemyBullet'
	bulletIns5.shooterType=1
	bulletIns5.speed=300
	get_parent().add_child(bulletIns5)
	var bulletIns6=bulletScene.instance()
	bulletIns6.position=bulletSpwan.global_position
	bulletIns6.rotation=rotatorRef.rotation+0.5
	bulletIns6.dir=Vector2(bulletDir[5].global_position.x-self.global_position.x,bulletDir[5].global_position.y-self.global_position.y).normalized()
	bulletIns6.type='EnemyBullet'
	bulletIns6.shooterType=1
	bulletIns6.speed=300
	get_parent().add_child(bulletIns6)
	var bulletIns7=bulletScene.instance()
	bulletIns7.position=bulletSpwan.global_position
	bulletIns7.rotation=rotatorRef.rotation-0.5
	bulletIns7.dir=Vector2(bulletDir[6].global_position.x-self.global_position.x,bulletDir[6].global_position.y-self.global_position.y).normalized()
	bulletIns7.type='EnemyBullet'
	bulletIns7.shooterType=1
	bulletIns7.speed=300
	get_parent().add_child(bulletIns7)
	var bulletIns8=bulletScene.instance()
	bulletIns8.position=bulletSpwan.global_position
	bulletIns8.rotation=rotatorRef.rotation-1
	bulletIns8.dir=Vector2(bulletDir[7].global_position.x-self.global_position.x,bulletDir[7].global_position.y-self.global_position.y).normalized()
	bulletIns8.type='EnemyBullet'
	bulletIns8.shooterType=1
	bulletIns8.speed=300
	get_parent().add_child(bulletIns8)


#Consecuencia de colision con bala
func _destroy():
	hitpoints-=1#reduce vida
	if hitpoints==0: #Si se queda sin vida
		_death()
		var timer:Timer=Timer.new() #Timer para efecto visual de muerto
		add_child(timer)
		timer.one_shot=true
		timer.autostart=true
		timer.wait_time=1.3
		timer.connect("timeout",self,"_disable_Boss")
		timer.start()

#Emision de puntos y eliminacion del nodo
func _disable_Boss():
	emit_signal("pointsUp",points)
	queue_free() 

#Efectos de muerte
func _death():
	$DeathSound.play()#Efecto sonoro
	$Sprite.visible=false
	#Efecto visual
	explotion.visible=true
	var anim=$ExplotionAnim/AnimationPlayer
	anim.play("Explotion")
