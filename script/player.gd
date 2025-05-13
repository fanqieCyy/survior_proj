extends CharacterBody2D
class_name Player

const ACCELERATION := 5000
const MAXSPEED := 300
var direction : Vector2 = Vector2.DOWN
var last_direction : Vector2 = Vector2.DOWN
var push_force = 50

const MAX_HEALTH := 50

func _ready() -> void:
	add_to_group("player")
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	z_index = 99 # 保证显示在大部分图片上方
