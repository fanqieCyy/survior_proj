extends Node
class_name  State
#状态模板函数

@onready var state_machine = get_parent()

func enter_state(): #进入该状态如何处理
	pass
	
func exit_state(): #退出该状态如何处理
	pass
	
func update_state(delta): #判断何时需要改变状态
	pass
	
func tick_physics(delta):
	pass

func transition_state(next_state):  #更改状态 /或者用发送信号实现，可以不需要这个函数？/先用着吧
	pass
