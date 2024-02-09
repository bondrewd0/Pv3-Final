extends Control

#referencia al menu de opcines
var settingsRef=preload("res://Scenes/Settings.tscn")

#Continuar juego
func _on_Continue_pressed():
	get_tree().paused=false #Se despausa el juego princiapl
	queue_free()

#Se sale del programa
func _on_Quit_pressed():
	get_tree().quit()

#cargar menu de opciones
func _on_Settings_pressed():
	var settingIns=settingsRef.instance()
	add_child(settingIns)
