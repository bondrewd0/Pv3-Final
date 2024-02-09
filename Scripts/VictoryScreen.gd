extends Control

#Referencia de puntos
var pPoints
#Variable para guardar nombre de escena a cargar
var lvl

#Se inica el texto de puntaje segun la referencia
func _ready():
	$ColorRect/ScoreText/ScorePoints.text=pPoints

#Carga el siguiente nivel
func _on_NextLevel_pressed():
	get_tree().change_scene(lvl)
	get_tree().paused=false #Se despausa el juego princiapl

#Vuelve al menu principal
func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
	get_tree().paused=false #Se despausa el juego princiapl
