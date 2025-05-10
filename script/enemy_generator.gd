extends Node

const ENEMY = preload("res://scenes/enemy.tscn")
@onready var player: Player = $"../Player"

func _ready() -> void:
	var enemy = ENEMY.instantiate()
	enemy.player = player
	add_child(enemy)
	enemy.position = player.position - Vector2(100, 100)
