extends Control

@onready var upgrade_menu: Control = $"../UpgradeMenu"
@onready var options_menu: CanvasLayer = $"../../../options-menu"

signal unpause

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		# GUARD CLAUSE: If the upgrade menu is open, ignore the pause button completely.
		if upgrade_menu.visible and visible == false:
			visible = true
			return
		elif visible and upgrade_menu.visible:
			visible = false
			return
		# Since the upgrade menu is NOT open, we can safely toggle the standard pause menu
		if get_tree().paused == false:
			# The game is running -> Pause it
			get_tree().paused = true
			Global.game_is_paused = true
			visible = true
		else:
			# The game is paused -> Unpause it
			get_tree().paused = false
			Global.game_is_paused = false
			visible = false

func _on_resume_pressed() -> void:
	AudioManager.button_press.play()
	await AudioManager.button_press.finished
	unpause.emit()


func _on_options_pressed() -> void:
	AudioManager.button_press.play()
	Transition.transition()
	AudioManager.main_music.playing = false
	AudioManager.menu_music.playing = true
	await Transition.on_transitioned_finished
	options_menu.visible = true


func _on_exit_to_menu_pressed() -> void:
	AudioManager.button_press.play()
	Transition.transition()
	AudioManager.main_music.playing = false
	await Transition.on_transitioned_finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
