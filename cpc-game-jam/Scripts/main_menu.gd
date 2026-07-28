extends Control

@onready var main_buttons: VBoxContainer = $CanvasLayer/main_buttons
@onready var monster: AnimatedSprite2D = $CanvasLayer/Control/AnimatedSprite2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_buttons.visible = true
	Global.go_to_menu = true
	monster.play("Eyes_Open")
	AudioManager.menu_music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	AudioManager.button_press.play()
	Transition.transition()
	await Transition.on_transitioned_finished
	AudioManager.menu_music.playing = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_exit_pressed() -> void:
	AudioManager.button_press.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()


func _on_options_pressed() -> void:
	AudioManager.button_press.play()
	Transition.transition()
	await get_tree().create_timer(0.3).timeout
	await Transition.on_transitioned_finished
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")
	
