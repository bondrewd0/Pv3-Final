extends Control

var settingsRef=preload("res://Scenes/Settings.tscn")

func _on_Continue_pressed():
	get_tree().paused=false
	queue_free()


func _on_Quit_pressed():
	get_tree().quit()


func _on_Settings_pressed():
	var settingIns=settingsRef.instance()
	add_child(settingIns)
