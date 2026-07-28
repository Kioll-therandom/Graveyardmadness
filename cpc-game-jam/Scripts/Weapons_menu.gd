extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.





func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_exit_game_pressed() -> void:
	get_tree().quit()


func _on_try_again_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
