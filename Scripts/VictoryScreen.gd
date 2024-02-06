extends Control

var pPoints
var lvl
func _ready():
	$ColorRect/ScoreText/ScorePoints.text=pPoints

func _on_NextLevel_pressed():
	get_tree().change_scene(lvl)
	get_tree().paused=false

func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
	get_tree().paused=false
