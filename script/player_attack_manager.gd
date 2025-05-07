extends Node
@onready var player: Player = $".."

const FLY_CUTTER = preload("res://scenes/weapons/templates/fly_cutter.tscn")

var shootTimer : Timer

func _ready() -> void:
	shootTimer = Timer.new() #定时发射
	add_child(shootTimer)
	shootTimer.wait_time = 1 #间隔时间为0
	shootTimer.start()
	shootTimer.one_shot = false
	shootTimer.timeout.connect(on_timer_timeout.bind("shootTimer"))
	
func on_timer_timeout(timerName : String):
	timerName = timerName.to_lower()
	if(timerName == "shoottimer"):
		var fly_cutter = FLY_CUTTER.instantiate()
		fly_cutter.position = player.position
		fly_cutter.set_direction(player.last_direction)
		get_tree().current_scene.add_child.call_deferred(fly_cutter)
