extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var playerRef=get_node("../../Player")
onready var barValue=$TextureProgress
# Called when the node enters the scene tree for the first time.
func _ready():
	playerRef.connect("player_hit",self,"_health_Change")
	barValue.value=100


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _health_Change(life):
	barValue.value=life
