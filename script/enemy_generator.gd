extends Node

var scene_list : Dictionary = {}
var enemy_num_list : Dictionary = {}
@onready var player: Player = $"../Player"

var enemyInfo : Dictionary = {
	"enemy" : {
		"update_time": 3,
		"max_update_num": 10,
		"max_num": 50
	}
}

func _ready() -> void:
	handle_enemy_info()
	pass

func _physics_process(delta: float) -> void:
	pass
		

func handle_enemy_info(): #处理一下敌人数据
	for key in enemyInfo:
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = enemyInfo[key]["update_time"]
		timer.one_shot = false
		timer.timeout.connect(on_time_out.bind(key))
		timer.start()
		
		enemy_num_list[key] = 0
		var scene = load("res://scenes/enemies/" + key + ".tscn") as PackedScene
		if(scene):
			scene_list[key] = scene
		

func on_time_out(timer_id : String):
	timer_id = timer_id.to_lower()
	if(enemy_num_list[timer_id] < enemyInfo[timer_id]["max_num"]):
		for i in range(0, min(enemyInfo[timer_id]["max_num"] - enemy_num_list[timer_id], enemyInfo[timer_id]["max_update_num"]) + 1):
			enemy_num_list[timer_id] += 1
			var enemy = scene_list[timer_id].instantiate()
			enemy.player = player
			add_child(enemy)
