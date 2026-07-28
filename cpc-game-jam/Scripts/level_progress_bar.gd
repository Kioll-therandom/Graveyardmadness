extends Control

@onready var progress_bar: ProgressBar = $CanvasLayer/ProgressBar
@onready var label: Label = $CanvasLayer/Label
const PIXEL_FONT = preload("uid://djmwfr4cl06rj")

func _ready() -> void:
	progress_bar.max_value = Global.player_max_exp
	progress_bar.value = Global.player_exp
	label.text = "level: " + str(Global.player_level)
	label.add_theme_font_size_override("font_size", 30)
	label.add_theme_font_override("font", PIXEL_FONT)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.max_reached == false:
		progress_bar.value = Global.player_exp
		progress_bar.max_value = Global.player_max_exp
		label.text = "level: " + str(Global.player_level)
		if progress_bar.value == progress_bar.max_value:
			progress_bar.value = 0
			progress_bar.max_value = Global.player_max_exp
	else:
		label.text = "level: " + str(Global.player_level)
		progress_bar.value = 0
		
