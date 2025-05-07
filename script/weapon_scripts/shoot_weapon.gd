extends Node2D
class_name ShootWeapon

var direction : Vector2 = Vector2.ZERO
var shoot_speed : float = 600.0

func _ready() -> void:
	pass

func set_direction(dir : Vector2) -> void:
	direction = dir
	rotation += direction.angle() + PI / 2

func _physics_process(delta: float) -> void:
	position += delta * direction * shoot_speed
