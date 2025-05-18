extends Node
class_name EnemyGenerator

var scene_list : Dictionary = {}
var enemy_num_list : Dictionary = {}
@onready var player: Player = $"../Player"

var enemyInfo : Dictionary = { #将敌人数据通过字典导入
	"enemy" : {
		"update_time": 2, #更新时间
		"max_update_num": 3, #每次生成最大数量
		"max_num": 9 #场中最多存在数量
	}
}

func _ready() -> void:
	handle_enemy_info()
	pass

func _physics_process(delta: float) -> void:
	pass
		
func handle_enemy_die(enemy_name : String):
	enemy_num_list[enemy_name] -= 1

func handle_enemy_info(): #处理一下敌人数据
	for key in enemyInfo:
		#设置计时器
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = enemyInfo[key]["update_time"]
		timer.one_shot = false
		timer.timeout.connect(on_time_out.bind(key))
		timer.start()
		enemy_num_list[key] = 0 #初始时敌人数量为0
		var scene = load("res://scenes/enemies/" + key + ".tscn") as PackedScene
		if(scene): 
			scene_list[key] = scene #记录场景

func on_time_out(timer_id : String): #定时产生敌人
	timer_id = timer_id.to_lower()
	if(enemy_num_list[timer_id] < enemyInfo[timer_id]["max_num"]):
		for i in range(0, min(enemyInfo[timer_id]["max_num"] - enemy_num_list[timer_id], enemyInfo[timer_id]["max_update_num"])):
			enemy_num_list[timer_id] += 1
			var enemy = scene_list[timer_id].instantiate()
			enemy.player = player
			add_child(enemy)
			enemy.enemy_die_signal.connect(handle_enemy_die)
