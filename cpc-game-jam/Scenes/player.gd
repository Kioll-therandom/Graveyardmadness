extends CharacterBody2D
class_name player
signal leveled_up


@onready var gun: Node2D = $Node2D/gun
@onready var healthbar = $health_bar
@onready var animation: AnimatedSprite2D = $Node2D/AnimatedSprite2D
@onready var dash: Node2D = $Dash


var dead: bool
var can_take_damage: bool
var rng = RandomNumberGenerator.new()
var is_leveling_up: bool = false

func _ready() -> void:
	dead = false
	can_take_damage = true
	Global.player_health = 5
	Global.player_max_health = 5
	healthbar.init_health(Global.player_health)
	Global.player_money = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !dead:
		if Input.is_action_just_pressed("Dash") and Global.Dash_unlocked:
			dash.start_dash(Global.dashlength)
			
		var speed = Global.dash_speed if dash.is_dashing() else Global.player_m_speed
		
		var direction = Input.get_vector("left", "right", "up", "down")
		velocity = direction * speed
		if velocity.x:
			animation.play("default")
			$Node2D.scale.x = -1 if velocity.x < 0 else 1
		elif velocity.y:
			animation.play("default")
		else:
			animation.play("idle")
		move_and_slide()
		
	
func _process(delta: float) -> void:
	if !dead:
		if Input.is_action_pressed("Shoot"):
			gun.shoot()
		if Global.player_exp >= Global.player_max_exp and !is_leveling_up and !Global.max_reached:
			lvl_up()
		


func take_damage_player():
	if can_take_damage:
		Global.player_health -= 1
		can_take_damage = false
		if Global.player_health <= 0:
			healthbar.health = Global.player_health
			dead = true
			Global.player_alive = false
			await get_tree().create_timer(0.5).timeout
			get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
		else:
			healthbar.health = Global.player_health
			await get_tree().create_timer(1.0).timeout
			can_take_damage = true

func lvl_up():
	if !Global.max_reached:
		is_leveling_up = true
		leveled_up.emit()
		animation.play("level_up")
		Global.player_level += 1
		if Global.player_level >= Global.max_level:
			Global.player_level = Global.max_level
			Global.max_reached = true
		Global.player_health = Global.player_max_health
		healthbar.health = Global.player_health
		Global.player_max_exp *= 2
		Global.player_exp = 0
		Global.player_score += 10
		await get_tree().create_timer(0.7).timeout
		animation.stop()
		is_leveling_up = false

func get_money():
	var gem_value = randi_range(1, 3)
	Global.player_money += gem_value
	Global.player_exp += 5
	Global.player_score += 5
