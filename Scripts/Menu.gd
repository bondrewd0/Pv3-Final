extends Control

#referencia al menu de opcines
var settingsRef=preload("res://Scenes/Settings.tscn")

#Se carga el primer nivel
func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/Nivel 1.tscn")

#Se sale del programa
func _on_Exit_pressed():
	get_tree().quit()

#cargar menu de opciones
func _on_Button_pressed():
	var settingIns=settingsRef.instance()
	add_child(settingIns)
