extends Control

#Referencia de puntos
var pPoints

#Se inica el texto de puntaje segun la referencia
func _ready():
	$ColorRect/ScoreText/ScorePoints.text=pPoints

#cuando se pulsa el boton de reinicio se vuelve a cargar el nivel actual
func _on_Retry_pressed():
	get_tree().reload_current_scene()
	get_tree().paused=false #Se despausa el juego princiapl

#Se sale del programa
func _on_Quit_pressed():
	get_tree().quit()
