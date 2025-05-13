extends CharacterBody2D

var player: Player
var direction : Vector2
var MAX_SPEED := 80
var ACCELRATION := 2000
var knocked_back_velocity := Vector2.ZERO

func _ready() -> void:
	add_to_group("enemy")
	position = player.position - Vector2(randi_range(150, 200), randi_range(150, 300))

func _physics_process(delta: float) -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING #避免敌人将玩家看作平台，这样会卡住
	direction = self.position.direction_to(player.position)
	
	
	velocity = velocity.move_toward(MAX_SPEED * direction, delta * ACCELRATION)
	velocity += knocked_back_velocity
	
	move_and_slide()
	var knocked = false
	
	if(get_slide_collision_count() != 0):
		knocked = true
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if(collider.is_in_group("enemy") and collider.has_method("knock_back")):
			var dir = collision.get_normal()
			collider.knock_back(- dir * 30)
	if(!knocked):
		knocked_back_velocity = Vector2.ZERO

func knock_back(force : Vector2):
	knocked_back_velocity = force
