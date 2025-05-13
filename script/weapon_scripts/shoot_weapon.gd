extends Node2D
class_name ShootWeapon

var direction : Vector2 = Vector2.ZERO
var shoot_speed : float = 600.0
var player : Player

func _ready() -> void:
	pass

func set_direction(dir : Vector2) -> void:
	direction = dir
	rotation += direction.angle() + PI / 2

func _physics_process(delta: float) -> void:
	position += delta * direction * shoot_speed
	if(player.position.distance_to(self.position) > 1500): #当武器距离玩家足够远
		#print("freed")
		queue_free()
	
