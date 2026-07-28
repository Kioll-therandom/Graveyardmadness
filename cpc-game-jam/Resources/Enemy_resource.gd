extends Resource
class_name Enemy_type

@export var name: String
@export var type: types

@export var speed: int
@export var health: float
@export var damage: float


enum types {
	Ghost, 
	Monster, 
	Big_Ghost}
