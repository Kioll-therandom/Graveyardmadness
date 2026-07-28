extends CanvasLayer

@onready var master: HSlider = $TextureRect/Master
@onready var music: HSlider = $TextureRect/Music
@onready var sfx: HSlider = $TextureRect/Sfx
@onready var blood: CheckButton = $TextureRect/blood
@onready var fullscreen: CheckButton = $TextureRect/Fullscreen



func _ready() -> void:
	master.value = AudioServer.get_bus_volume_linear(0)
	music.value = AudioServer.get_bus_volume_linear(1)
	sfx.value = AudioServer.get_bus_volume_linear(2)
	if Global.Blood_on:
		blood.button_pressed = true
	else:
		blood.button_pressed = false
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		fullscreen.button_pressed = true
	else:
		fullscreen.button_pressed = false


func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
	if AudioManager.button_press.playing == false:
		AudioManager.button_press.play()

func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	if AudioManager.button_press.playing == false:
		AudioManager.button_press.play()


func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	if AudioManager.button_press.playing == false:
		AudioManager.button_press.play()


func _on_blood_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global.Blood_on = true
	else:
		Global.Blood_on = false


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_button_pressed() -> void:
	AudioManager.button_press.play()
	Transition.transition()
	AudioManager.menu_music.playing = false
	await Transition.on_transitioned_finished
	if Global.go_to_menu == true:
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	else:
		visible = false
