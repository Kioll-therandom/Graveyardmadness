extends Resource
class_name BaseBulletStrategy

@export var Upgrade_name: String = ""
@export var Upgrade_cost: int = 0
@export var Upgrade_icon: Texture2D
@export var Upgrade_type: String
@export_multiline() var Upgrade_desc: String

func apply_upgrade(player):
	pass
