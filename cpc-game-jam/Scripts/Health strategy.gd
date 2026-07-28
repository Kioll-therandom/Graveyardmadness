extends BaseBulletStrategy
class_name Health_strategy

func apply_upgrade(player):
	Global.player_max_health * 1.1
	Global.player_health = Global.player_max_health
