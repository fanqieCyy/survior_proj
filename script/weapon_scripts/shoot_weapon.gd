extends StaticBody2D
class_name ShootWeapon

var direction : Vector2 = Vector2.ZERO
var shoot_speed : float = 600.0
var player : Player
var penetrate_time : int = -1 #可穿透次数
var base_damage : int = 60 #基础伤害
var current_damage : int #现在的伤害

func _ready() -> void:
	add_to_group("weapon")
	z_index = 100
	current_damage = base_damage

func set_direction(dir : Vector2) -> void:
	direction = dir
	rotation += direction.angle() + PI / 2 #将武器初始方向转到敌人方向

func _physics_process(delta: float) -> void:
	position += delta * direction * shoot_speed
	if(player.position.distance_to(self.position) > 1500): #当武器距离玩家足够远
		queue_free()

func check_penetrate() -> bool: #返回是否销毁掉了
	if(penetrate_time == 0):
		queue_free()
	elif(penetrate_time > 0):
		penetrate_time -= 1
	elif(penetrate_time < -1): #考虑到有些武器不应该有消失判定，可以设置为-1
		print("[error: envir_collision_base.gd] : penerate_time < 0")
	return penetrate_time == 0

func _on_attack_shape_area_entered(area: Area2D) -> void:
	var node = area.get_parent()
	print("knocked")
	if(node.is_in_group("enemy")):
		node.knock_back(2800, direction)
		
