extends Control



func _on_Continue_pressed():
	get_tree().paused=false
	queue_free()


func _on_Quit_pressed():
	get_tree().quit()
