extends Control

signal upgrade_chosen

@onready var upgrade_menu: Control = $"."
@onready var money_label: Label = $Label
@onready var damage_panel: Panel = $"ScrollContainer/Panel/Bullet Upgrades/Damage upgrade/Damage_panel"
@onready var shotgun_panel: Panel = $"ScrollContainer/Panel/Bullet Upgrades/Shotgun upgrade/Shotgun_panel"
@onready var explosion_panel: Panel = $"ScrollContainer/Panel/Bullet Upgrades/Explosion upgrade2/Explosion panel"
@onready var pill_panel: Panel = $"ScrollContainer/Panel/Health Upgrades/health upgrade/pill panel"
@onready var heart_panel: Panel = $"ScrollContainer/Panel/Health Upgrades/Big heart upgrade/heart panel"
@onready var chemical_panel: Panel = $"ScrollContainer/Panel/Health Upgrades/Chemical upgrade/Chemical panel"
@onready var pick_panel: Panel = $"ScrollContainer/Panel/Special upgrades/pickup upgrade/Pick panel"
@onready var firerate_panel: Panel = $"ScrollContainer/Panel/Special upgrades/Firerate upgrade/firerate panel"
@onready var dash_panel: Panel = $"ScrollContainer/Panel/Special upgrades/Dash upgrade/dash_panel"




@export var Damage_mult: float = 1.2
@export var Explode_Dmg: float = 1.5
@export var Health_mult: float = 1.15
@export var Bullet: PackedScene
@export var Damage_price: int = 5
@export var shotgun_price: int = 10
@export var explosion_price: int = 15
@export var health_price: int = 5
@export var heart_price: int = 10
@export var chemical_price: int = 15
@export var pick_price: int = 15
@export var firerate_price: int = 20
@export var Dash_price: int = 30



var first_upgrade_locked = false
var second_upgrade_locked = false
var third_upgrade_locked = false
var fourth_upgrade_locked = false
var fifth_upgrade_locked = false
var sixth_upgrade_locked = false
var seventh_upgrade_locked = false
var eighth_upgrade_locked = false
var ninth_upgrade_locked = false



func _ready() -> void:
	damage_panel.visible = false
	shotgun_panel.visible = false
	explosion_panel.visible = false
	pill_panel.visible = false
	heart_panel.visible = false
	chemical_panel.visible = false
	pick_panel.visible = false
	firerate_panel.visible = false
	dash_panel.visible = false

func _physics_process(delta: float) -> void:
	money_label.text = "Gems: " + str(Global.player_money)

func _on_damage_upgrade_pressed() -> void:
	if !first_upgrade_locked and Global.player_money >= Damage_price:
		Global.player_damage *= Damage_mult 
		Global.player_money -= Damage_price
		first_upgrade_locked = true
		damage_panel.visible = true
	else:
		print("upgrade locked")


func _on_health_upgrade_pressed() -> void:
	if !second_upgrade_locked and Global.player_money >= health_price:
		Global.player_max_health *= Health_mult
		Global.player_money -= health_price
		second_upgrade_locked = true
		pill_panel.visible = true
	else:
		print("upgrade locked")


func _on_explosion_upgrade_pressed() -> void:
	if !third_upgrade_locked and Global.player_money >= explosion_price:
		Global.player_money -= explosion_price
		Global.bullet_particles_fire = true
		Global.player_damage *= Explode_Dmg
		Global.Ghost_movement_speed *= 1.25
		third_upgrade_locked = true
		explosion_panel.visible = true
	else:
		print("upgrade locked")



func _on_shotgun_upgrade_pressed() -> void:
	if !fourth_upgrade_locked and Global.player_money >= shotgun_price:
		Global.player_money -= shotgun_price
		Global.bullet_arc += 10
		Global.bullet_amount += 4
		Global.player_damage -= (Global.player_damage * 0.1)
		fourth_upgrade_locked  = true
		shotgun_panel.visible = true
	else:
		print("upgrade locked")


func _on_big_heart_upgrade_pressed() -> void:
	if !fifth_upgrade_locked and Global.player_money >= heart_price:
		Global.player_money -= heart_price
		Global.player_damage -= (Global.player_damage * 0.15)
		Global.player_max_health *= 1.3
		heart_panel.visible = true
		fifth_upgrade_locked = true



func _on_chemical_upgrade_pressed() -> void:
	if !sixth_upgrade_locked and Global.player_money >= chemical_price:
		Global.player_money -= chemical_price
		Global.player_max_health *= 1.5
		Global.player_m_speed -= (Global.player_m_speed * 0.15)
		chemical_panel.visible = true
		sixth_upgrade_locked = true
		


func _on_continue_pressed() -> void:
	upgrade_chosen.emit()


func _on_pickup_upgrade_pressed() -> void:
	if !seventh_upgrade_locked and Global.player_money >= pick_price:
		Global.player_money -= pick_price
		Global.penetration_unlocked = true
		Global.player_damage -= (Global.player_damage * 0.1)
		pick_panel.visible = true
		seventh_upgrade_locked = true


func _on_firerate_upgrade_pressed() -> void:
	if !eighth_upgrade_locked and Global.player_money >= firerate_price:
		Global.player_money -= firerate_price
		Global.bullet_firerate *= 1.3
		Global.player_damage -= (Global.player_damage * 0.1)
		firerate_panel.visible = true
		eighth_upgrade_locked = true

func _on_dash_upgrade_pressed() -> void:
	if !ninth_upgrade_locked and Global.player_money >= Dash_price:
		Global.Dash_unlocked = true
		Global.player_money -= Dash_price
		Global.player_max_health -= (Global.player_max_health * 0.20)
		dash_panel.visible = true
		ninth_upgrade_locked = true
