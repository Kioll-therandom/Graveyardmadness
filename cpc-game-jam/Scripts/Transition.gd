extends CanvasLayer

signal on_transitioned_finished

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect


func _ready() -> void:
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	if anim_name == "Fade_to_black":
		on_transitioned_finished.emit()
		animation_player.play("Fade_to_normal")
	elif anim_name == "Fade_to_normal":
		color_rect.visible = false

func transition():
	color_rect.visible = true
	animation_player.play("Fade_to_black")
