extends CharacterBody2D
class_name Enemy

var ACCELRATION : float = 2000
var MAX_SPEED : float = 50
var MAX_HEALTH : int = 1000

var player: Player
var direction : Vector2
var current_health : int

var knock_force : float = 0 #击退力
var knock_dir : Vector2 = Vector2.ZERO

var knock_timer : Timer #模拟在一段时间内往后提供加速度
var enemy_type : String = "enemy"

signal enemy_die_signal(enemy_name : String)

func _ready() -> void:
	add_to_group("enemy")
	
	knock_timer = Timer.new()
	add_child(knock_timer)
	knock_timer.wait_time = 0.2
	knock_timer.one_shot = true
	
	current_health = MAX_HEALTH
	position = player.position - Vector2(randi_range(150, 200), randi_range(150, 300))

func _physics_process(delta: float) -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING #避免敌人将玩家看作平台，这样会卡住
	direction = self.position.direction_to(player.position)
	velocity = velocity.move_toward(MAX_SPEED * direction, delta * ACCELRATION)
	check_health()
	check_knock(delta)
	move_and_slide()

func check_health() -> void:
	if(current_health <= 0):
		enemy_die_signal.emit(enemy_type)
		queue_free()

func knock_back(_knock_force : float, _knock_dir : Vector2) -> void: #检查碰撞
	knock_timer.start()
	knock_force = _knock_force
	knock_dir = _knock_dir

func check_knock(delta : float) -> void:
	if(knock_timer.is_stopped()):
		return
	velocity = velocity.move_toward(MAX_SPEED * knock_dir, delta * knock_force)

func _on_area_2d_area_entered(area: Area2D) -> void:
	var node = area.get_parent()
	if(node.is_in_group("weapon")):
		if("current_damage" in node):
			current_health -= node.current_damage
			if(node.has_method("check_penetrate")):
				node.check_penetrate()
	if(node.is_in_group("enemy")):
		if(node.velocity.dot(self.velocity) < -0.8):
			node.knock_back(velocity.length() / MAX_SPEED * 2800, direction)
