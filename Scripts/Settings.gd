extends Control
onready var musicSlider=$ColorRect/MusicSilder
onready var soundSlider=$ColorRect/SoundSlider
onready var muteButton=$ColorRect/Mute
var muteSound:bool
func _ready():
	musicSlider.value=AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	soundSlider.value=AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effects"))
	muteSound=AudioServer.is_bus_mute(AudioServer.get_bus_index("Music"))
	muteButton.pressed=muteSound


func _on_Button_pressed():
	queue_free()


func _on_Sound_Slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"),value)


func _on_Music_Silder_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),value)



func _on_CheckBox_pressed():
	muteSound=!muteSound
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),muteSound)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"),muteSound)
