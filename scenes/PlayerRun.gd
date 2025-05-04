extends State
class_name  PlayerRun
#状态模板函数

@onready var player: Player = $"../.."

func Enter_state(): #进入该状态如何处理
	pass
	
func Exit_state(): #退出该状态如何处理
	pass
	
func Update_state(delta): #判断何时需要改变状态
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down") #get_vector可以实现360度方向获取
	if input_vector.length() > 0:
		player.direction = input_vector
	else:
		player.direction = Vector2.ZERO
		Transition_state("idle")
func Tick_physics(delta):
	player.velocity = player.direction * player.MAXSPEED
	player.move_and_slide()
	print(player.velocity, player.direction)

func Transition_state(next_state):  #更改状态 /或者用发送信号实现，可以不需要这个函数？/先用着吧
	pass
