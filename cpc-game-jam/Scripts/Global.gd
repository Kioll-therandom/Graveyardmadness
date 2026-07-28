extends Node

var player_damage = 2.0
var GhostDamageAmount = 2
var PhantomDamageAmount = 4
var player_alive : bool = true
var player_max_exp: int = 30
var player_exp: int = 0
var player_level: int = 1
var player_score: int = 0
var player_health: int
var player_max_health: int
var bullet_speed: int = 5
var player_upgrades: Array[BaseBulletStrategy] = []
var bullet_particles_fire = false
var bullet_firerate: float = 2.0
var bullet_arc: float = 0.0
var bullet_amount: int = 1
var player_money: int = 0
var Blood_on: bool = true
var Dash_unlocked: bool = false
var player_m_speed: int = 300
var penetration_unlocked: bool = false
var max_level = 5
var max_reached: bool = false
var Ghost_movement_speed: int = 100
var game_is_paused: bool = false
var go_to_menu:bool= true

const dash_speed = 800
const dashlength = .1
