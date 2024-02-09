extends Node2D


#velocidad de caida
export var fallSpeed=0.0
var player=null #Referencia al jugador

#Si colisiona con el jugador se elimina
func _on_Area2D_area_entered(_area):
	queue_free()

#Movimiento
func _process(_delta):
	if player==null: #Si el jugador no fue detectado cae
		self.position.y+=fallSpeed
		pass
	else: #Si el jugador fue detectado va hacia su posicion
		self.position=position.move_toward(player.global_position,5)

#Si sale de la pantalla se elimina 
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

#Si se detecta al jugador activa la referencia
func _on_PickUpRange_area_entered(area):
	player=area
