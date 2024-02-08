extends Control

var settingsRef=preload("res://Scenes/Settings.tscn")
func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/Nivel2.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Button_pressed():
	var settingIns=settingsRef.instance()
	add_child(settingIns)
