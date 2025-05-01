extends Node
class_name  State
#状态模板函数

@onready var state_machine = get_parent()

func Enter(): #进入该状态如何处理
	pass
	
func Exit(): #退出该状态如何处理
	pass
	
func Update(delta): #判断何时需要改变状态
	pass
	
func Tick_physics(delta):
	pass

func Transition_state(next_state):  #更改状态 /或者用发送信号实现，可以不需要这个函数？/先用着吧
	pass
