extends BaseBulletStrategy
class_name DamageBulletStrategy

@export var Damage_increase: float = 1.1

func apply_upgrade(player):
	Global.player_damage * Damage_increase
