extends Node2D


#Velocidad de la bala
export var speed=0
#Direccion
var dir= Vector2(1,0)
#Tipo de bala para colision
var type=''
#Tipo de bala para el sprite
var shooterType=0
#Sprite a usar
var bulletSprite

#carga la textura segun el objeto que lo genera
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
	


#Movimeinto y colison
func _process(delta):
	self.position+=dir*speed*delta #se mueve segun la velocidad y direccion dados
	if($RayCast2D.is_colliding()): #Revisa colison
		var collid=$RayCast2D.get_collider()
		if collid!=null: # si ha colisionado
			if(collid.type=='Enemy' && type=='PlayerBullet'):#Si la bala viene del jugador y colisiona con un enemigo
				collid._destroy()
				queue_free()
			if(type=='EnemyBullet' && collid.type=='Player'):#Si la bala viene de un enemigo y colisiona con jugador
				collid._taking_Fire()
				queue_free()


#si sale de la pantalla se elimina
func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()
