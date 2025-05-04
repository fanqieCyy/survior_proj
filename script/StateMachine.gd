extends Node
class_name StateMachine

@export var initial_state :State #外部导入初始状态

var current_state : State #当前状态
var state_dir :Dictionary = {}  #创建状态节点字典

func _ready() -> void:
	for child in get_children(): #获取子节点中所有的状态，为了可拓展性，因为后续可以加上其他类的节点
		if child is State: #如果子节点是一个状态
			state_dir[child.name.to_lower()] = child
	if initial_state: #设置初始状态
		current_state = initial_state
		initial_state.Enter_state()
	
func _process(delta: float) -> void:
	if(current_state):
		current_state.Update_state(delta) #更新节点状态

func _physics_process(delta: float) -> void:
	if(current_state):
		current_state.Tick_physics(delta) #当前状态每一帧人物如何移动等等..

func Switch_state(last_state : State, next_state_name): #这里的newState是字符串，需要在states里找，因为该函数要在State中调用，每个State不好获取同级的其他State
	if last_state != current_state: #判断是否在处理当前状态
		return
	var next_state : State = state_dir.get(next_state_name.to_lower()) #获取下一个节点
	if !next_state: #如果没有找到
		return
	last_state.Exit_state()
	next_state.Enter_state()
	current_state = next_state
