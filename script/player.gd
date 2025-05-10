extends CharacterBody2D
class_name Player

const ACCELERATION := 5000
const MAXSPEED := 300
var direction : Vector2 = Vector2.DOWN
var last_direction : Vector2 = Vector2.DOWN

const MAX_HEALTH := 50

func _ready() -> void:
	z_index = 99 # 保证显示在大部分图片上方
