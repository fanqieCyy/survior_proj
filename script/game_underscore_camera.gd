extends Camera2D


var Target_position=Vector2.ZERO#这个变量是指向(0,0)向量的意思么

func _ready():
	self.zoom = Vector2(2.5, 2.5)
	make_current()
	
func _process(delta):
	Aquire_target()
	global_position=global_position.lerp(Target_position,1.0-exp(-delta*10))#指数函数让相机跟随丝滑些
	
func Aquire_target():
	var player_nodes= get_tree().get_nodes_in_group("player")	 #获取该分组的信息
	if player_nodes.size()>0:#不是很懂这段代码，照抄的教程，大概是让摄像机位置和玩家位置同步
		var player=player_nodes[0] as Node2D#获取分组的第一个元素，即“player”
		Target_position=player.global_position 
		
