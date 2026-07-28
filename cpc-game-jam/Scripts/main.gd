extends Node2D



@onready var player: CharacterBody2D = $Player
@onready var upgrade_menu: Control = $Player/CanvasLayer/UpgradeMenu
@onready var survival_timer: Timer = $survival_timer
@onready var timer_label: Label = $Player/CanvasLayer/timer_label
@onready var pause_menu: Control = $Player/CanvasLayer/PauseMenu
@onready var options_menu: CanvasLayer = $"options-menu"



func _ready() -> void:
	Global.player_alive = true
	Global.player_max_exp = 20
	Global.player_exp = 0
	Global.player_damage = 2
	Global.player_level = 0
	Global.player_score = 0
	Global.bullet_amount = 1
	Global.bullet_arc = 0
	Global.bullet_firerate = 2
	Global.player_money = 0
	Global.player_m_speed = 300
	Global.penetration_unlocked = false
	Global.bullet_particles_fire = false
	Global.Dash_unlocked = false
	Global.max_reached = false
	Global.go_to_menu = false
	upgrade_menu.visible = false
	options_menu.visible = false
	await get_tree().process_frame
	get_tree().paused = false
	AudioManager.main_music.play()
		

func _process(delta: float) -> void:
	timer_label.text = "%02d:%02d" % time_left()

func time_left():
	var time_left = survival_timer.time_left
	var minute = floor(time_left/60)
	var seconds = int(time_left) % 60
	return [minute, seconds]



func spawn_mob():
	if Global.player_alive:
		var new_mob = preload("uid://byor210bjpoyb").instantiate()
		%PathFollow2D.progress_ratio = randf()
		new_mob.global_position = %PathFollow2D.global_position
		add_child(new_mob)
	


func _on_timer_timeout() -> void:
	if Global.player_alive:
		spawn_mob()


func _on_player_leveled_up() -> void:
	get_tree().paused = true
	await get_tree().create_timer(1, true, false, true).timeout
	timer_label.visible = false
	upgrade_menu.visible = true




func _on_upgrade_menu_upgrade_chosen() -> void:
	upgrade_menu.visible = false
	timer_label.visible = true
	get_tree().paused = false


func _on_survival_timer_timeout() -> void:
	Transition.transition()
	await Transition.on_transitioned_finished
	get_tree().change_scene_to_file("res://Scenes/Win-menu.tscn")


func _on_pause_menu_unpause() -> void:
			# GUARD CLAUSE: If the upgrade menu is open, ignore the pause button completely.
		if upgrade_menu.visible and pause_menu.visible == false:
			pause_menu.visible = true
			return
		elif pause_menu.visible and upgrade_menu.visible:
			pause_menu.visible = false
			return
		# Since the upgrade menu is NOT open, we can safely toggle the standard pause menu
		if get_tree().paused == false:
			# The game is running -> Pause it
			get_tree().paused = true
			Global.game_is_paused = true
			pause_menu.visible = true
		else:
			# The game is paused -> Unpause it
			get_tree().paused = false
			Global.game_is_paused = false
			pause_menu.visible = false
