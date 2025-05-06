extends Node
@onready var player: Player = $".."

const FLY_CUTTER = preload("res://scenes/weapons/templates/fly_cutter.tscn")

func _ready() -> void:
	var fly_cutter = FLY_CUTTER.instantiate()
	fly_cutter.position = player.position
	fly_cutter.set_direction(player.direction)
	get_tree().current_scene.add_child.call_deferred(fly_cutter)
	
