extends Sprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("get_money"):
		body.get_money()
		queue_free()
		
		
		
