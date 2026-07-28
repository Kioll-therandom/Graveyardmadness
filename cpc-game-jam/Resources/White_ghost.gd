extends CharacterBody2D
class_name White_Ghost

@onready var player = get_node("/root/main/Player")
@export var health: int = 3
@export var Exp_to_give: int = 10
@export var money: PackedScene
@export var blood: PackedScene

var player_damage: int

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * Global.Ghost_movement_speed
	move_and_slide()
	if !Global.player_alive:
		queue_free()
		

func take_damage():
	health -= Global.player_damage
	if health <= 0:
		if money:
			var emerald = money.instantiate()
			emerald.position = global_position
			get_tree().root.call_deferred("add_child", emerald)
			if Global.Blood_on and blood:
				var _particle = blood.instantiate()
				_particle.position = global_position
				_particle.rotation = global_rotation
				_particle.emitting = true
				get_tree().current_scene.add_child(_particle)
		queue_free()




func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage_player"):
		body.take_damage_player()
