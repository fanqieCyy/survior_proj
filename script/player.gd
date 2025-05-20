extends CharacterBody2D
class_name Player

const ACCELERATION := 5000
const MAXSPEED := 200
var direction : Vector2 = Vector2.DOWN
var last_direction : Vector2 = Vector2.DOWN #记录最后一次的位置
var push_force = 50

const MAX_HEALTH := 50

func _ready() -> void:
	add_to_group("player")
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	z_index = 99 # 保证显示在大部分图片上方

func _on_interact_area_area_entered(area: Area2D) -> void:
	var node = area.get_parent()
	if(node.is_in_group("enemy")):
		node.knock_back((velocity.length() / MAXSPEED) * 3500.0, direction)
		#print((velocity.length() / MAXSPEED) * 3500.0, " " ,last_direction)
