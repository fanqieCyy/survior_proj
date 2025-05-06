extends Node2D
class_name ShootWeapon

var direction : Vector2 = Vector2.ZERO
var shoot_speed : float = 600.0

func _ready() -> void:
	print("weapaon")

func set_direction(dir : Vector2) -> void:
	direction = dir

func _physics_process(delta: float) -> void:
	print(position)
	position += delta * direction * shoot_speed
