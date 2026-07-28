extends Node2D
class_name Gun

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

@export var bullet: PackedScene
@export var bullet_count: int = Global.bullet_amount
@export_range(0, 360) var arc: float = Global.bullet_arc
@export_range(0, 20) var fire_rate: float = Global.bullet_firerate

@export var barrel_origin: Node2D

var can_shoot = true
var rng = RandomNumberGenerator.new()
func shoot():
	bullet_count = Global.bullet_amount
	arc = Global.bullet_arc
	fire_rate = Global.bullet_firerate
	if can_shoot:
		can_shoot = false
		for i in range(bullet_count):
			var new_bullet = bullet.instantiate()
			new_bullet.position = barrel_origin.global_position if barrel_origin else global_position
			if bullet_count == 1:
				new_bullet.rotation = global_rotation
			else:
				var arc_rad = deg_to_rad(arc)
				var increment = arc_rad / (bullet_count - 1)
				new_bullet.global_rotation = (
					global_rotation +
					increment * i -
					arc_rad / 2 
			)
			get_tree().root.call_deferred("add_child", new_bullet)
			var audio_to_play = rng.randi_range(1, 3)
			if audio_to_play == 1:
				high_pitch_sound()
			elif audio_to_play == 2:
				normal_pitch_sound()
			else:
				low_pitch_sound()
		await get_tree().create_timer(1.0 / fire_rate).timeout
		can_shoot = true
			
			


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

func high_pitch_sound():
	audio.pitch_scale = 1.3
	audio.play()
	
func normal_pitch_sound():
	audio.pitch_scale = 1
	audio.play()
	
func low_pitch_sound():
	audio.pitch_scale = 0.8
	audio.play()
