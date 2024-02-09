extends Control

#Referencias a nodos internos a usar
onready var musicSlider=$ColorRect/MusicSilder
onready var soundSlider=$ColorRect/SoundSlider
onready var muteButton=$ColorRect/Mute
#Estado de sonido
var muteSound:bool

#Establezco el valor de los sliders y botones
func _ready():
	#Valor de los sliders segun el volumen de los buses
	musicSlider.value=AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	soundSlider.value=AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effects"))
	#Estado del sonido segun uno de los buses
	muteSound=AudioServer.is_bus_mute(AudioServer.get_bus_index("Music"))
	muteButton.pressed=muteSound #Estado del boton

#cierra el muenu de opciones
func _on_Button_pressed():
	queue_free()

#Modifica bus de efectos de sonido
func _on_Sound_Slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"),value)

#Modifica bus de musica
func _on_Music_Silder_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),value)


#des/mutea los buses
func _on_CheckBox_pressed():
	muteSound=!muteSound
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),muteSound)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"),muteSound)
