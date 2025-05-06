extends State
class_name  PlayerIdle
#状态模板函数

@onready var player: Player = $"../.."

func enter_state(): #进入该状态如何处理
	pass
	
func exit_state(): #退出该状态如何处理
	pass
	
func update_state(delta): #判断何时需要改变状态
	if(Input.is_action_just_pressed("move_up") || Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right") || Input.is_action_just_pressed("move_down")):
		transition_state("run")
	
func tick_physics(delta):
	pass

func transition_state(next_state):  #更改状态 /或者用发送信号实现，可以不需要这个函数？/先用着吧
	state_machine.switch_state(self, next_state)
