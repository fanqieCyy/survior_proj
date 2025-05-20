extends StaticBody2D
class_name ShootWeapon

var direction : Vector2 = Vector2.ZERO
var shoot_speed : float = 600.0
var player : Player

func _ready() -> void:
	add_to_group("weapon")
	z_index = 100

func set_direction(dir : Vector2) -> void:
	direction = dir
	rotation += direction.angle() + PI / 2 #将武器初始方向转到敌人方向

func _physics_process(delta: float) -> void:
	position += delta * direction * shoot_speed
	if(player.position.distance_to(self.position) > 1500): #当武器距离玩家足够远
		queue_free()

func _on_attack_shape_area_entered(area: Area2D) -> void:
	var node = area.get_parent()
	if(node.is_in_group("enemy")):
		node.knock_back(2800, direction)
		
