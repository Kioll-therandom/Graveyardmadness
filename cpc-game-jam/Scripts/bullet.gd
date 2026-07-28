extends CharacterBody2D

@export var explosion_particle: PackedScene

var speed: int = Global.bullet_speed
var direction = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = Vector2.RIGHT.rotated(global_rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = direction * speed
	var collision = move_and_collide(velocity)
	
	
	

func _on_timer_timeout() -> void:
	if Global.bullet_particles_fire:
			var _particle = explosion_particle.instantiate()
			_particle.position = global_position
			_particle.rotation = global_rotation
			_particle.emitting = true
			get_tree().current_scene.add_child(_particle)
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
		if Global.bullet_particles_fire:
			var _particle = explosion_particle.instantiate()
			_particle.position = global_position
			_particle.rotation = global_rotation
			_particle.emitting = true
			get_tree().current_scene.add_child(_particle)
		if !Global.penetration_unlocked:
			queue_free()
	
