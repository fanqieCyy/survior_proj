extends CharacterBody2D

var player: Player
var direction : Vector2
var MAX_SPEED := 80
var ACCELRATION := 2000

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	direction = self.position.direction_to(player.position) 
	velocity = velocity.move_toward(MAX_SPEED * direction, delta * ACCELRATION)
	move_and_slide()
