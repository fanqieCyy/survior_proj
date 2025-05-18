extends State
class_name  PlayerRun
#状态模板函数

@onready var player: Player = $"../.."

func enter_state(): #进入该状态如何处理
	pass

func exit_state(): #退出该状态如何处理
	pass
	
func update_state(delta): #判断何时需要改变状态
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down") #get_vector可以实现360度方向获取
	if input_vector.length() > 0:
		player.direction = input_vector
		player.last_direction = input_vector
	else:
		player.direction = Vector2.ZERO
		transition_state("idle")
func tick_physics(delta):
	var dot = player.direction.normalized().dot(player.velocity.normalized()) #向量的点积
	var acceleration = player.ACCELERATION
	if(dot < -0.8): #如果说速度方向和玩家输入方向反向，将加速度设置为很大，这样会让手感更好，不会漂移
		acceleration = 20000
	player.velocity = player.velocity.move_toward(player.direction * player.MAXSPEED,  acceleration * delta)
	player.move_and_slide()
	
			
func transition_state(next_state):  #更改状态 /或者用发送信号实现，可以不需要这个函数？/先用着吧
	pass
