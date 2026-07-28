extends CharacterBody2D
class_name Ghost

@onready var player = get_node("/root/main/Player")
@export var health: int = 3
@export var damage: int = 3
@export var Exp_to_give: int = 10

var player_damage: int

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100
	move_and_slide()
	if !Global.player_alive:
		queue_free()
		

func take_damage():
	player_damage = Global.player_damage
	health -= player_damage
	if health <= 0:
		queue_free()
		Global.player_exp += Exp_to_give




func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage_player"):
		body.take_damage_player()
