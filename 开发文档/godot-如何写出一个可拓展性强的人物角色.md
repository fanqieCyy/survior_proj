---
title: '【godot】如何写出一个可拓展性强的角色'
mathjax: true
comments: true
date: 2025-05-01 23:24:59
tags:
categories:
---

## 状态机

之前写过的一个项目将状态机和每个状态的处理都写到了同一个代码文件中，为了让后期代码不那么混乱，肯定要将状态机独立出来。

于是，我们可以让状态机作为根节点，包含一系列的状态子节点。

### State

先从最底层思考起，一个状态应该是怎样的？

- 首先，进入该状态要进行怎样的操作。
- 其次，在状态每一帧要进行怎样的操作
- 同时，每一帧判断是否要更新到下一个状态
- 最后，退出该状态要进行的操作

```python
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
```



### State_machine

state_machine要如何获取到所有的节点呢。一种做法是没增加一个状态就在state_machine中手动添加。还有一种更方便的做法是遍历所有state_machine的子节点，将状态存储起来。

- 也就是这样

```python
func _ready() -> void:
	for child in get_children(): #获取子节点中所有的状态，为了可拓展性，因为后续可以加上其他状态
		if child is State: #如果子节点是一个状态
			state_dir[child.name.to_lower()] = child
	if initial_state: #设置初始状态
		current_state = initial_state
		initial_state.enter_state()
```

#### 状态操作

由于在状态中我们已经实现了每一帧中状态要进行的操作，所以在状态机中只需要调用就行了。

- 这样

```python
func _process(delta: float) -> void:
	if(current_state):
		current_state.update_state(delta) #更新节点状态

func _physics_process(delta: float) -> void:
	if(current_state):
		current_state.tick_physics(delta) #当前状态每一帧人物如何移动等等..

```

#### 状态更新

获取到状态节点的更新状态请求时，先判断一下给出的状态是否都存在。如果存在，进行上一个状态的退出操作，以及下一个状态的进入操作

```python
func switch_state(last_state : State, next_state_name): #这里的newState是字符串，需要在states里找，因为该函数要在State中调用，每个State不好获取同级的其他State
	if last_state != current_state: #判断是否在处理当前状态
		return
	var next_state : State = state_dir.get(next_state_name.to_lower()) #获取下一个节点
	if !next_state: #如果没有找到
		return
	last_state.exit_state()
	next_state.enter_state()
	current_state = next_state

```

### 总结

状态机的思想非常好用，可以简化很多问题。

比如，它可以实现一段代码逐步执行。只需要将每一行代码看作是一个状态，某一行代码运行后判断下一个状态（也就是代码行）是哪一个。这样就可以手动控制代码的运行，在每一行代码运行时，也可以进行很多操作。比如，在可视化排序的过程中，可以将排序过程画出来。

