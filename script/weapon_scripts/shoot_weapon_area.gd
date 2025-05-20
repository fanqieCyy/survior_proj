extends Area2D
class_name AttackShape

var base_damage : int = 60 #基础伤害
var current_damage : int #现在的伤害

var penetrate_time : int = 1 #可穿透次数

func _ready() -> void:
	current_damage = base_damage

func check_penetrate() -> bool: #返回是否销毁掉了
	if(penetrate_time == 0):
		queue_free()
	elif(penetrate_time > 0):
		penetrate_time -= 1
	elif(penetrate_time < -1): #考虑到有些武器不应该有消失判定，可以设置为-1
		print("[error: envir_collision_base.gd] : penerate_time < 0")
	return penetrate_time == 0
