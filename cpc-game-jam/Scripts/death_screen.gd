extends Control

@onready var score: Label = $CanvasLayer/Score
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.set_text("Score: " + str(Global.player_score))
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_quit_pressed() -> void:
	audio.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	Global.player_score = 0
	Global.player_level = 0


func _on_exit_game_pressed() -> void:
	audio.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()


func _on_try_again_pressed() -> void:
	audio.play()
	await get_tree().create_timer(0.3).timeout
	Global.player_score = 0
	Global.player_level = 0
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
