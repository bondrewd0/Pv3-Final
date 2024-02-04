extends Control


var pPoints

func _ready():
	$ColorRect/ScoreText/ScorePoints.text=pPoints

func _on_Retry_pressed():
	get_tree().reload_current_scene()
	get_tree().paused=false


func _on_Quit_pressed():
	get_tree().quit()
